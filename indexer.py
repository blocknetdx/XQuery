#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Copyright (C) 2022-2022 Riku Block
# All rights reserved.
#
# This file is part of XQuery2.

import logging
import sys
import os

#import pidfile

from web3 import Web3
from web3.middleware import geth_poa_middleware

from sqlalchemy import select

import xquery.cache
import xquery.controller
import xquery.db
import xquery.db.orm as orm
from xquery.config import CONFIG as C
dex = os.getenv("DEX", '')
if dex == 'PANGOLIN':
    from xquery.event import (
        EventFilterExchangePangolin as EventFilterExchange,
        EventIndexerExchangePangolin as EventIndexerExchange,
        EventProcessorExchangePangolin as EventProcessorExchange,
    )
    from xquery.contract import png_factory as factory
elif dex == 'PEGASYS':
    from xquery.event import (
        EventFilterExchangePegasys as EventFilterExchange,
        EventIndexerExchangePegasys as EventIndexerExchange,
        EventProcessorExchangePegasys as EventProcessorExchange,
    )
    from xquery.contract import psys_factory as factory
else:
    logging.critical("CRITICAL ERROR: {} is an unknown DEX/Router".format(dex))
    sys.exit(1)

from xquery.middleware import http_backoff_retry_request_middleware
from xquery.provider import BatchHTTPProvider
from xquery.util.misc import timeit

log = logging.getLogger("main")

MIN_PYTHON = (3, 8)
if sys.version_info < MIN_PYTHON:
    sys.exit("Python {}.{} or later is required!".format(*MIN_PYTHON))


@timeit
def main() -> int:
    """
    Example XQuery configuration for a DEX
    """
    logging.basicConfig(
        level=C["LOG_LEVEL"],
        format=C["LOG_FORMAT"],
        datefmt=C["LOG_DATE_FORMAT"],
        handlers=[
            # logging.FileHandler(filename="run.log", mode="w"),
            logging.StreamHandler(),
        ]
    )

    log.info("API_URL = {}".format(C["API_URL"]))
    w3 = Web3(BatchHTTPProvider(endpoint_uri=C["API_URL"], request_kwargs={"timeout": 120}))
    w3.middleware_onion.clear()
    w3.middleware_onion.add(http_backoff_retry_request_middleware, "http_backoff_retry_request")
    w3.middleware_onion.inject(geth_poa_middleware, layer=0)

    db = xquery.db.FusionSQL(
        conn=xquery.db.build_url(
            driver=C["DB_DRIVER"],
            host=C["DB_HOST"],
            port=C["DB_PORT"],
            username=C["DB_USERNAME"],
            password=C["DB_PASSWORD"],
            database=C["DB_DATABASE"],
        ),
        verbose=C["DB_DEBUG"],
    )

    cache = xquery.cache.Cache_Redis(
        host=C["REDIS_HOST"],
        port=C["REDIS_PORT"],
        password=C["REDIS_PASSWORD"],
        db=C["REDIS_DATABASE"],
    )

    # ensure the service is running
    cache.ping()
    cache.flush()

    # load pair addresses
    with db.session() as session:
        pairs = session.execute(
            select(orm.Pair)
        ).scalars().all()

        pair_addresses = {pair.address for pair in pairs}

    # select the event indexer class/type
    # Note: will be instantiated in the worker process and therefore needs to be passed as type
    indexer_cls = EventIndexerExchange

    # create an event filter
    event_filter = EventFilterExchange(
        w3=w3,
        pair_addresses=pair_addresses,
    )

    # create an event processor
    # Note: the actual processor stages will be instantiated in the worker process
    event_processor = EventProcessorExchange()

    with xquery.controller.Controller(w3=w3, db=db, cache=cache, indexer_cls=indexer_cls, num_workers=int(C["XQ_NUM_WORKERS"])) as c:
        c.run(
            start_block=factory.from_block,
            end_block="latest",
            num_safety_blocks=int(os.getenv("NUM_SAFETY_BLOCKS", 10)),
            filter_=event_filter,
            processor=event_processor,
            chunk_size=2048,
            target_sleep_time=int(os.getenv("TARGET_SLEEP_TIME", 30)),
        )

    return 0


if __name__ == "__main__":
    sys.exit(main())
