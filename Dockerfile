FROM python:3.9-buster

COPY . /app/xq-engine
WORKDIR /app/xq-engine

RUN apt-get update
RUN apt-get install -y build-essential musl-dev gcc g++ libffi-dev libssl-dev python3-dev curl libkrb5-dev python3-zmq libpq-dev alembic \
#    && pip install cython \
#    && pip install psycopg2-binary \
    && pip3 install -r /app/xq-engine/requirements.txt \
    && curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash \
    && rm -rf /var/cache/apk/* \
    && rm -rf /usr/share/man \
    && rm -rf /tmp/*

CMD sleep 20 && \
    echo "Creating/Updating db schema via alembic..." && \
    /app/xq-engine/schemas.sh && \
    echo "db schema created/updated; starting indexer..." && \
    python3 -m indexer
