SET check_function_bodies = false;
CREATE SCHEMA xgraph_png;
CREATE SCHEMA xgraph_psys;
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);
CREATE TABLE xgraph_png.block (
    id integer NOT NULL,
    hash character varying(66) NOT NULL,
    number integer NOT NULL,
    "timestamp" integer NOT NULL
);
CREATE SEQUENCE xgraph_png.block_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.block_id_seq OWNED BY xgraph_png.block.id;
CREATE TABLE xgraph_png.bundle (
    id integer NOT NULL,
    "nativePrice" numeric(78,18) NOT NULL,
    block_id integer,
    "logIndex" integer
);
CREATE SEQUENCE xgraph_png.bundle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.bundle_id_seq OWNED BY xgraph_png.bundle.id;
CREATE TABLE xgraph_png.burn (
    id integer NOT NULL,
    transaction_id integer,
    "timestamp" integer NOT NULL,
    pair_address character varying(42),
    liquidity numeric(78,18) NOT NULL,
    sender character varying(42),
    amount0 numeric(78,18),
    amount1 numeric(78,18),
    "to" character varying(42),
    "logIndex" integer,
    "amountUSD" numeric(78,18),
    "needsComplete" boolean NOT NULL,
    "feeTo" character varying(42),
    "feeLiquidity" numeric(78,18)
);
CREATE SEQUENCE xgraph_png.burn_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.burn_id_seq OWNED BY xgraph_png.burn.id;
CREATE TABLE xgraph_png.exchange_day_data (
    id integer NOT NULL,
    identifier integer NOT NULL,
    date integer NOT NULL,
    "dailyVolumeNative" numeric(78,18) NOT NULL,
    "dailyVolumeUSD" numeric(78,18) NOT NULL,
    "dailyVolumeUntracked" numeric(78,18) NOT NULL,
    "totalVolumeNative" numeric(78,18) NOT NULL,
    "totalLiquidityNative" numeric(78,18) NOT NULL,
    "totalVolumeUSD" numeric(78,18) NOT NULL,
    "totalLiquidityUSD" numeric(78,18) NOT NULL,
    "txCount" integer NOT NULL
);
CREATE SEQUENCE xgraph_png.exchange_day_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.exchange_day_data_id_seq OWNED BY xgraph_png.exchange_day_data.id;
CREATE TABLE xgraph_png.factory (
    id integer NOT NULL,
    address character varying(42) NOT NULL,
    "pairCount" integer NOT NULL,
    "totalVolumeUSD" numeric(78,18) NOT NULL,
    "totalVolumeNative" numeric(78,18) NOT NULL,
    "untrackedVolumeUSD" numeric(78,18) NOT NULL,
    "totalLiquidityUSD" numeric(78,18) NOT NULL,
    "totalLiquidityNative" numeric(78,18) NOT NULL,
    "txCount" integer NOT NULL
);
CREATE SEQUENCE xgraph_png.factory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.factory_id_seq OWNED BY xgraph_png.factory.id;
CREATE TABLE xgraph_png.liquidity_position (
    id integer NOT NULL,
    user_id integer,
    pair_address character varying(42),
    "liquidityTokenBalance" numeric(78,18) NOT NULL
);
CREATE SEQUENCE xgraph_png.liquidity_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.liquidity_position_id_seq OWNED BY xgraph_png.liquidity_position.id;
CREATE TABLE xgraph_png.liquidity_position_snapshot (
    id integer NOT NULL,
    block_id integer,
    "timestamp" integer NOT NULL,
    "blockHeight" integer NOT NULL,
    "liquidityPosition_id" integer,
    user_id integer,
    pair_address character varying(42),
    "token0PriceUSD" numeric(78,18) NOT NULL,
    "token1PriceUSD" numeric(78,18) NOT NULL,
    reserve0 numeric(78,18) NOT NULL,
    reserve1 numeric(78,18) NOT NULL,
    "reserveUSD" numeric(78,18) NOT NULL,
    "liquidityTokenTotalSupply" numeric(78,18) NOT NULL,
    "liquidityTokenBalance" numeric(78,18) NOT NULL
);
CREATE SEQUENCE xgraph_png.liquidity_position_snapshot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.liquidity_position_snapshot_id_seq OWNED BY xgraph_png.liquidity_position_snapshot.id;
CREATE TABLE xgraph_png.mint (
    id integer NOT NULL,
    transaction_id integer,
    pair_address character varying(42),
    "timestamp" integer NOT NULL,
    liquidity numeric(78,18) NOT NULL,
    sender character varying(42),
    amount0 numeric(78,18),
    amount1 numeric(78,18),
    "to" character varying(42) NOT NULL,
    "logIndex" integer,
    "amountUSD" numeric(78,18),
    "feeTo" character varying(42),
    "feeLiquidity" numeric(78,18)
);
CREATE SEQUENCE xgraph_png.mint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.mint_id_seq OWNED BY xgraph_png.mint.id;
CREATE TABLE xgraph_png.pair (
    id integer NOT NULL,
    address character varying(42) NOT NULL,
    token0_address character varying(42),
    token1_address character varying(42),
    reserve0 numeric(78,18) NOT NULL,
    reserve1 numeric(78,18) NOT NULL,
    "totalSupply" numeric(78,18) NOT NULL,
    "reserveNative" numeric(78,18) NOT NULL,
    "reserveUSD" numeric(78,18) NOT NULL,
    "trackedReserveNative" numeric(78,18) NOT NULL,
    "token0Price" numeric(78,18) NOT NULL,
    "token1Price" numeric(78,18) NOT NULL,
    "volumeToken0" numeric(78,18) NOT NULL,
    "volumeToken1" numeric(78,18) NOT NULL,
    "volumeUSD" numeric(78,18) NOT NULL,
    "untrackedVolumeUSD" numeric(78,18) NOT NULL,
    "txCount" integer NOT NULL,
    "createdAtTimestamp" integer NOT NULL,
    "createdAtBlockNumber" integer NOT NULL,
    block_id integer,
    "liquidityProviderCount" integer NOT NULL,
    CONSTRAINT pair_unequal_token_address CHECK (((token0_address)::text <> (token1_address)::text))
);
CREATE TABLE xgraph_png.pair_day_data (
    id integer NOT NULL,
    "dayIndex" integer NOT NULL,
    "dayStartUnix" integer NOT NULL,
    pair_address character varying(42),
    reserve0 numeric(78,18) NOT NULL,
    reserve1 numeric(78,18) NOT NULL,
    "reserveUSD" numeric(78,18) NOT NULL,
    "totalSupply" numeric(78,18) NOT NULL,
    "dailyVolumeToken0" numeric(78,18) NOT NULL,
    "dailyVolumeToken1" numeric(78,18) NOT NULL,
    "dailyVolumeUSD" numeric(78,18) NOT NULL,
    "dailyTxns" integer NOT NULL,
    CONSTRAINT pair_day_data_check CHECK (("dayStartUnix" = ("dayIndex" * 86400)))
);
CREATE SEQUENCE xgraph_png.pair_day_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.pair_day_data_id_seq OWNED BY xgraph_png.pair_day_data.id;
CREATE TABLE xgraph_png.pair_hour_data (
    id integer NOT NULL,
    "hourIndex" integer NOT NULL,
    "hourStartUnix" integer NOT NULL,
    pair_address character varying(42),
    reserve0 numeric(78,18) NOT NULL,
    reserve1 numeric(78,18) NOT NULL,
    "reserveUSD" numeric(78,18) NOT NULL,
    "totalSupply" numeric(78,18),
    "totalSupplyChange" numeric(78,18) NOT NULL,
    "hourlyVolumeToken0" numeric(78,18) NOT NULL,
    "hourlyVolumeToken1" numeric(78,18) NOT NULL,
    "hourlyVolumeUSD" numeric(78,18) NOT NULL,
    "hourlyTxns" integer NOT NULL,
    CONSTRAINT pair_hour_data_check CHECK (("hourStartUnix" = ("hourIndex" * 3600)))
);
CREATE SEQUENCE xgraph_png.pair_hour_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.pair_hour_data_id_seq OWNED BY xgraph_png.pair_hour_data.id;
CREATE SEQUENCE xgraph_png.pair_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.pair_id_seq OWNED BY xgraph_png.pair.id;
CREATE TABLE xgraph_png.state (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    block_number integer,
    block_hash character varying(66),
    finalized integer
);
CREATE SEQUENCE xgraph_png.state_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.state_id_seq OWNED BY xgraph_png.state.id;
CREATE TABLE xgraph_png.swap (
    id integer NOT NULL,
    transaction_id integer,
    pair_address character varying(42),
    "timestamp" integer NOT NULL,
    sender character varying(42) NOT NULL,
    "from" character varying(42) NOT NULL,
    "amount0In" numeric(78,18) NOT NULL,
    "amount1In" numeric(78,18) NOT NULL,
    "amount0Out" numeric(78,18) NOT NULL,
    "amount1Out" numeric(78,18) NOT NULL,
    "to" character varying(42) NOT NULL,
    "logIndex" integer,
    "amountUSD" numeric(78,18) NOT NULL
);
CREATE SEQUENCE xgraph_png.swap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.swap_id_seq OWNED BY xgraph_png.swap.id;
CREATE TABLE xgraph_png.sync (
    id integer NOT NULL,
    transaction_id integer,
    pair_address character varying(42),
    reserve0 numeric(78,18) NOT NULL,
    reserve1 numeric(78,18) NOT NULL,
    "logIndex" integer NOT NULL
);
CREATE SEQUENCE xgraph_png.sync_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.sync_id_seq OWNED BY xgraph_png.sync.id;
CREATE TABLE xgraph_png.token (
    id integer NOT NULL,
    address character varying(42) NOT NULL,
    symbol character varying(16) NOT NULL,
    name character varying(64) NOT NULL,
    decimals smallint NOT NULL,
    "totalSupply" numeric(78,0) NOT NULL,
    "tradeVolume" numeric(78,18) NOT NULL,
    "tradeVolumeUSD" numeric(78,18) NOT NULL,
    "untrackedVolumeUSD" numeric(78,18) NOT NULL,
    "txCount" integer NOT NULL,
    "totalLiquidity" numeric(78,18) NOT NULL,
    "derivedNative" numeric(78,18)
);
CREATE TABLE xgraph_png.token_day_data (
    id integer NOT NULL,
    "dayIndex" integer NOT NULL,
    "dayStartUnix" integer NOT NULL,
    token_address character varying(42),
    "dailyVolumeToken" numeric(78,18) NOT NULL,
    "dailyVolumeNative" numeric(78,18) NOT NULL,
    "dailyVolumeUSD" numeric(78,18) NOT NULL,
    "dailyTxns" integer NOT NULL,
    "totalLiquidityToken" numeric(78,18) NOT NULL,
    "totalLiquidityNative" numeric(78,18) NOT NULL,
    "totalLiquidityUSD" numeric(78,18) NOT NULL,
    "priceUSD" numeric(78,18) NOT NULL,
    CONSTRAINT token_day_data_check CHECK (("dayStartUnix" = ("dayIndex" * 86400)))
);
CREATE SEQUENCE xgraph_png.token_day_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.token_day_data_id_seq OWNED BY xgraph_png.token_day_data.id;
CREATE TABLE xgraph_png.token_hour_data (
    id integer NOT NULL,
    "hourIndex" integer NOT NULL,
    "hourStartUnix" integer NOT NULL,
    token_address character varying(42),
    "hourlyVolumeToken" numeric(78,18) NOT NULL,
    "hourlyVolumeNative" numeric(78,18) NOT NULL,
    "hourlyVolumeUSD" numeric(78,18) NOT NULL,
    "hourlyTxns" integer NOT NULL,
    "totalLiquidityToken" numeric(78,18),
    "totalLiquidityTokenChange" numeric(78,18) NOT NULL,
    "totalLiquidityNative" numeric(78,18),
    "totalLiquidityUSD" numeric(78,18),
    "priceUSD" numeric(78,18) NOT NULL,
    CONSTRAINT token_hour_data_check CHECK (("hourStartUnix" = ("hourIndex" * 3600)))
);
CREATE SEQUENCE xgraph_png.token_hour_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.token_hour_data_id_seq OWNED BY xgraph_png.token_hour_data.id;
CREATE SEQUENCE xgraph_png.token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.token_id_seq OWNED BY xgraph_png.token.id;
CREATE TABLE xgraph_png.transaction (
    id integer NOT NULL,
    hash character varying(66) NOT NULL,
    "from" character varying(42) NOT NULL,
    block_id integer,
    "timestamp" integer NOT NULL
);
CREATE SEQUENCE xgraph_png.transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.transaction_id_seq OWNED BY xgraph_png.transaction.id;
CREATE TABLE xgraph_png.transfer (
    id integer NOT NULL,
    transaction_id integer,
    pair_address character varying(42),
    "from" character varying(42) NOT NULL,
    "to" character varying(42) NOT NULL,
    value numeric(78,18) NOT NULL,
    "logIndex" integer NOT NULL
);
CREATE SEQUENCE xgraph_png.transfer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.transfer_id_seq OWNED BY xgraph_png.transfer.id;
CREATE TABLE xgraph_png."user" (
    id integer NOT NULL,
    address character varying(42) NOT NULL,
    "usdSwapped" numeric(78,18) NOT NULL
);
CREATE SEQUENCE xgraph_png.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_png.user_id_seq OWNED BY xgraph_png."user".id;
CREATE TABLE xgraph_psys.block (
    id integer NOT NULL,
    hash character varying(66) NOT NULL,
    number integer NOT NULL,
    "timestamp" integer NOT NULL
);
CREATE SEQUENCE xgraph_psys.block_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.block_id_seq OWNED BY xgraph_psys.block.id;
CREATE TABLE xgraph_psys.bundle (
    id integer NOT NULL,
    "nativePrice" numeric(78,18) NOT NULL,
    block_id integer,
    "logIndex" integer
);
CREATE SEQUENCE xgraph_psys.bundle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.bundle_id_seq OWNED BY xgraph_psys.bundle.id;
CREATE TABLE xgraph_psys.burn (
    id integer NOT NULL,
    transaction_id integer,
    "timestamp" integer NOT NULL,
    pair_address character varying(42),
    liquidity numeric(78,18) NOT NULL,
    sender character varying(42),
    amount0 numeric(78,18),
    amount1 numeric(78,18),
    "to" character varying(42),
    "logIndex" integer,
    "amountUSD" numeric(78,18),
    "needsComplete" boolean NOT NULL,
    "feeTo" character varying(42),
    "feeLiquidity" numeric(78,18)
);
CREATE SEQUENCE xgraph_psys.burn_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.burn_id_seq OWNED BY xgraph_psys.burn.id;
CREATE TABLE xgraph_psys.exchange_day_data (
    id integer NOT NULL,
    identifier integer NOT NULL,
    date integer NOT NULL,
    "dailyVolumeNative" numeric(78,18) NOT NULL,
    "dailyVolumeUSD" numeric(78,18) NOT NULL,
    "dailyVolumeUntracked" numeric(78,18) NOT NULL,
    "totalVolumeNative" numeric(78,18) NOT NULL,
    "totalLiquidityNative" numeric(78,18) NOT NULL,
    "totalVolumeUSD" numeric(78,18) NOT NULL,
    "totalLiquidityUSD" numeric(78,18) NOT NULL,
    "txCount" integer NOT NULL
);
CREATE SEQUENCE xgraph_psys.exchange_day_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.exchange_day_data_id_seq OWNED BY xgraph_psys.exchange_day_data.id;
CREATE TABLE xgraph_psys.factory (
    id integer NOT NULL,
    address character varying(42) NOT NULL,
    "pairCount" integer NOT NULL,
    "totalVolumeUSD" numeric(78,18) NOT NULL,
    "totalVolumeNative" numeric(78,18) NOT NULL,
    "untrackedVolumeUSD" numeric(78,18) NOT NULL,
    "totalLiquidityUSD" numeric(78,18) NOT NULL,
    "totalLiquidityNative" numeric(78,18) NOT NULL,
    "txCount" integer NOT NULL
);
CREATE SEQUENCE xgraph_psys.factory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.factory_id_seq OWNED BY xgraph_psys.factory.id;
CREATE TABLE xgraph_psys.liquidity_position (
    id integer NOT NULL,
    user_id integer,
    pair_address character varying(42),
    "liquidityTokenBalance" numeric(78,18) NOT NULL
);
CREATE SEQUENCE xgraph_psys.liquidity_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.liquidity_position_id_seq OWNED BY xgraph_psys.liquidity_position.id;
CREATE TABLE xgraph_psys.liquidity_position_snapshot (
    id integer NOT NULL,
    block_id integer,
    "timestamp" integer NOT NULL,
    "blockHeight" integer NOT NULL,
    "liquidityPosition_id" integer,
    user_id integer,
    pair_address character varying(42),
    "token0PriceUSD" numeric(78,18) NOT NULL,
    "token1PriceUSD" numeric(78,18) NOT NULL,
    reserve0 numeric(78,18) NOT NULL,
    reserve1 numeric(78,18) NOT NULL,
    "reserveUSD" numeric(78,18) NOT NULL,
    "liquidityTokenTotalSupply" numeric(78,18) NOT NULL,
    "liquidityTokenBalance" numeric(78,18) NOT NULL
);
CREATE SEQUENCE xgraph_psys.liquidity_position_snapshot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.liquidity_position_snapshot_id_seq OWNED BY xgraph_psys.liquidity_position_snapshot.id;
CREATE TABLE xgraph_psys.mint (
    id integer NOT NULL,
    transaction_id integer,
    pair_address character varying(42),
    "timestamp" integer NOT NULL,
    liquidity numeric(78,18) NOT NULL,
    sender character varying(42),
    amount0 numeric(78,18),
    amount1 numeric(78,18),
    "to" character varying(42) NOT NULL,
    "logIndex" integer,
    "amountUSD" numeric(78,18),
    "feeTo" character varying(42),
    "feeLiquidity" numeric(78,18)
);
CREATE SEQUENCE xgraph_psys.mint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.mint_id_seq OWNED BY xgraph_psys.mint.id;
CREATE TABLE xgraph_psys.pair (
    id integer NOT NULL,
    address character varying(42) NOT NULL,
    token0_address character varying(42),
    token1_address character varying(42),
    reserve0 numeric(78,18) NOT NULL,
    reserve1 numeric(78,18) NOT NULL,
    "totalSupply" numeric(78,18) NOT NULL,
    "reserveNative" numeric(78,18) NOT NULL,
    "reserveUSD" numeric(78,18) NOT NULL,
    "trackedReserveNative" numeric(78,18) NOT NULL,
    "token0Price" numeric(78,18) NOT NULL,
    "token1Price" numeric(78,18) NOT NULL,
    "volumeToken0" numeric(78,18) NOT NULL,
    "volumeToken1" numeric(78,18) NOT NULL,
    "volumeUSD" numeric(78,18) NOT NULL,
    "untrackedVolumeUSD" numeric(78,18) NOT NULL,
    "txCount" integer NOT NULL,
    "createdAtTimestamp" integer NOT NULL,
    "createdAtBlockNumber" integer NOT NULL,
    block_id integer,
    "liquidityProviderCount" integer NOT NULL,
    CONSTRAINT pair_unequal_token_address CHECK (((token0_address)::text <> (token1_address)::text))
);
CREATE TABLE xgraph_psys.pair_day_data (
    id integer NOT NULL,
    "dayIndex" integer NOT NULL,
    "dayStartUnix" integer NOT NULL,
    pair_address character varying(42),
    reserve0 numeric(78,18) NOT NULL,
    reserve1 numeric(78,18) NOT NULL,
    "reserveUSD" numeric(78,18) NOT NULL,
    "totalSupply" numeric(78,18) NOT NULL,
    "dailyVolumeToken0" numeric(78,18) NOT NULL,
    "dailyVolumeToken1" numeric(78,18) NOT NULL,
    "dailyVolumeUSD" numeric(78,18) NOT NULL,
    "dailyTxns" integer NOT NULL,
    CONSTRAINT pair_day_data_check CHECK (("dayStartUnix" = ("dayIndex" * 86400)))
);
CREATE SEQUENCE xgraph_psys.pair_day_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.pair_day_data_id_seq OWNED BY xgraph_psys.pair_day_data.id;
CREATE TABLE xgraph_psys.pair_hour_data (
    id integer NOT NULL,
    "hourIndex" integer NOT NULL,
    "hourStartUnix" integer NOT NULL,
    pair_address character varying(42),
    reserve0 numeric(78,18) NOT NULL,
    reserve1 numeric(78,18) NOT NULL,
    "reserveUSD" numeric(78,18) NOT NULL,
    "totalSupply" numeric(78,18),
    "totalSupplyChange" numeric(78,18) NOT NULL,
    "hourlyVolumeToken0" numeric(78,18) NOT NULL,
    "hourlyVolumeToken1" numeric(78,18) NOT NULL,
    "hourlyVolumeUSD" numeric(78,18) NOT NULL,
    "hourlyTxns" integer NOT NULL,
    CONSTRAINT pair_hour_data_check CHECK (("hourStartUnix" = ("hourIndex" * 3600)))
);
CREATE SEQUENCE xgraph_psys.pair_hour_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.pair_hour_data_id_seq OWNED BY xgraph_psys.pair_hour_data.id;
CREATE SEQUENCE xgraph_psys.pair_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.pair_id_seq OWNED BY xgraph_psys.pair.id;
CREATE TABLE xgraph_psys.state (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    block_number integer,
    block_hash character varying(66),
    finalized integer
);
CREATE SEQUENCE xgraph_psys.state_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.state_id_seq OWNED BY xgraph_psys.state.id;
CREATE TABLE xgraph_psys.swap (
    id integer NOT NULL,
    transaction_id integer,
    pair_address character varying(42),
    "timestamp" integer NOT NULL,
    sender character varying(42) NOT NULL,
    "from" character varying(42) NOT NULL,
    "amount0In" numeric(78,18) NOT NULL,
    "amount1In" numeric(78,18) NOT NULL,
    "amount0Out" numeric(78,18) NOT NULL,
    "amount1Out" numeric(78,18) NOT NULL,
    "to" character varying(42) NOT NULL,
    "logIndex" integer,
    "amountUSD" numeric(78,18) NOT NULL
);
CREATE SEQUENCE xgraph_psys.swap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.swap_id_seq OWNED BY xgraph_psys.swap.id;
CREATE TABLE xgraph_psys.sync (
    id integer NOT NULL,
    transaction_id integer,
    pair_address character varying(42),
    reserve0 numeric(78,18) NOT NULL,
    reserve1 numeric(78,18) NOT NULL,
    "logIndex" integer NOT NULL
);
CREATE SEQUENCE xgraph_psys.sync_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.sync_id_seq OWNED BY xgraph_psys.sync.id;
CREATE TABLE xgraph_psys.token (
    id integer NOT NULL,
    address character varying(42) NOT NULL,
    symbol character varying(16) NOT NULL,
    name character varying(64) NOT NULL,
    decimals smallint NOT NULL,
    "totalSupply" numeric(78,0) NOT NULL,
    "tradeVolume" numeric(78,18) NOT NULL,
    "tradeVolumeUSD" numeric(78,18) NOT NULL,
    "untrackedVolumeUSD" numeric(78,18) NOT NULL,
    "txCount" integer NOT NULL,
    "totalLiquidity" numeric(78,18) NOT NULL,
    "derivedNative" numeric(78,18)
);
CREATE TABLE xgraph_psys.token_day_data (
    id integer NOT NULL,
    "dayIndex" integer NOT NULL,
    "dayStartUnix" integer NOT NULL,
    token_address character varying(42),
    "dailyVolumeToken" numeric(78,18) NOT NULL,
    "dailyVolumeNative" numeric(78,18) NOT NULL,
    "dailyVolumeUSD" numeric(78,18) NOT NULL,
    "dailyTxns" integer NOT NULL,
    "totalLiquidityToken" numeric(78,18) NOT NULL,
    "totalLiquidityNative" numeric(78,18) NOT NULL,
    "totalLiquidityUSD" numeric(78,18) NOT NULL,
    "priceUSD" numeric(78,18) NOT NULL,
    CONSTRAINT token_day_data_check CHECK (("dayStartUnix" = ("dayIndex" * 86400)))
);
CREATE SEQUENCE xgraph_psys.token_day_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.token_day_data_id_seq OWNED BY xgraph_psys.token_day_data.id;
CREATE TABLE xgraph_psys.token_hour_data (
    id integer NOT NULL,
    "hourIndex" integer NOT NULL,
    "hourStartUnix" integer NOT NULL,
    token_address character varying(42),
    "hourlyVolumeToken" numeric(78,18) NOT NULL,
    "hourlyVolumeNative" numeric(78,18) NOT NULL,
    "hourlyVolumeUSD" numeric(78,18) NOT NULL,
    "hourlyTxns" integer NOT NULL,
    "totalLiquidityToken" numeric(78,18),
    "totalLiquidityTokenChange" numeric(78,18) NOT NULL,
    "totalLiquidityNative" numeric(78,18),
    "totalLiquidityUSD" numeric(78,18),
    "priceUSD" numeric(78,18) NOT NULL,
    CONSTRAINT token_hour_data_check CHECK (("hourStartUnix" = ("hourIndex" * 3600)))
);
CREATE SEQUENCE xgraph_psys.token_hour_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.token_hour_data_id_seq OWNED BY xgraph_psys.token_hour_data.id;
CREATE SEQUENCE xgraph_psys.token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.token_id_seq OWNED BY xgraph_psys.token.id;
CREATE TABLE xgraph_psys.transaction (
    id integer NOT NULL,
    hash character varying(66) NOT NULL,
    "from" character varying(42) NOT NULL,
    block_id integer,
    "timestamp" integer NOT NULL
);
CREATE SEQUENCE xgraph_psys.transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.transaction_id_seq OWNED BY xgraph_psys.transaction.id;
CREATE TABLE xgraph_psys.transfer (
    id integer NOT NULL,
    transaction_id integer,
    pair_address character varying(42),
    "from" character varying(42) NOT NULL,
    "to" character varying(42) NOT NULL,
    value numeric(78,18) NOT NULL,
    "logIndex" integer NOT NULL
);
CREATE SEQUENCE xgraph_psys.transfer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.transfer_id_seq OWNED BY xgraph_psys.transfer.id;
CREATE TABLE xgraph_psys."user" (
    id integer NOT NULL,
    address character varying(42) NOT NULL,
    "usdSwapped" numeric(78,18) NOT NULL
);
CREATE SEQUENCE xgraph_psys.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE xgraph_psys.user_id_seq OWNED BY xgraph_psys."user".id;
ALTER TABLE ONLY xgraph_png.block ALTER COLUMN id SET DEFAULT nextval('xgraph_png.block_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.bundle ALTER COLUMN id SET DEFAULT nextval('xgraph_png.bundle_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.burn ALTER COLUMN id SET DEFAULT nextval('xgraph_png.burn_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.exchange_day_data ALTER COLUMN id SET DEFAULT nextval('xgraph_png.exchange_day_data_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.factory ALTER COLUMN id SET DEFAULT nextval('xgraph_png.factory_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.liquidity_position ALTER COLUMN id SET DEFAULT nextval('xgraph_png.liquidity_position_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.liquidity_position_snapshot ALTER COLUMN id SET DEFAULT nextval('xgraph_png.liquidity_position_snapshot_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.mint ALTER COLUMN id SET DEFAULT nextval('xgraph_png.mint_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.pair ALTER COLUMN id SET DEFAULT nextval('xgraph_png.pair_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.pair_day_data ALTER COLUMN id SET DEFAULT nextval('xgraph_png.pair_day_data_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.pair_hour_data ALTER COLUMN id SET DEFAULT nextval('xgraph_png.pair_hour_data_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.state ALTER COLUMN id SET DEFAULT nextval('xgraph_png.state_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.swap ALTER COLUMN id SET DEFAULT nextval('xgraph_png.swap_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.sync ALTER COLUMN id SET DEFAULT nextval('xgraph_png.sync_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.token ALTER COLUMN id SET DEFAULT nextval('xgraph_png.token_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.token_day_data ALTER COLUMN id SET DEFAULT nextval('xgraph_png.token_day_data_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.token_hour_data ALTER COLUMN id SET DEFAULT nextval('xgraph_png.token_hour_data_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.transaction ALTER COLUMN id SET DEFAULT nextval('xgraph_png.transaction_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png.transfer ALTER COLUMN id SET DEFAULT nextval('xgraph_png.transfer_id_seq'::regclass);
ALTER TABLE ONLY xgraph_png."user" ALTER COLUMN id SET DEFAULT nextval('xgraph_png.user_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.block ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.block_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.bundle ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.bundle_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.burn ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.burn_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.exchange_day_data ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.exchange_day_data_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.factory ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.factory_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.liquidity_position ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.liquidity_position_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.liquidity_position_snapshot ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.liquidity_position_snapshot_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.mint ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.mint_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.pair ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.pair_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.pair_day_data ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.pair_day_data_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.pair_hour_data ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.pair_hour_data_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.state ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.state_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.swap ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.swap_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.sync ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.sync_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.token ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.token_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.token_day_data ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.token_day_data_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.token_hour_data ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.token_hour_data_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.transaction ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.transaction_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys.transfer ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.transfer_id_seq'::regclass);
ALTER TABLE ONLY xgraph_psys."user" ALTER COLUMN id SET DEFAULT nextval('xgraph_psys.user_id_seq'::regclass);
ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
ALTER TABLE ONLY xgraph_png.block
    ADD CONSTRAINT block_hash_key UNIQUE (hash);
ALTER TABLE ONLY xgraph_png.block
    ADD CONSTRAINT block_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.bundle
    ADD CONSTRAINT "bundle_block_id_logIndex_key" UNIQUE (block_id, "logIndex");
ALTER TABLE ONLY xgraph_png.bundle
    ADD CONSTRAINT bundle_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.burn
    ADD CONSTRAINT burn_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.exchange_day_data
    ADD CONSTRAINT exchange_day_data_identifier_key UNIQUE (identifier);
ALTER TABLE ONLY xgraph_png.exchange_day_data
    ADD CONSTRAINT exchange_day_data_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.factory
    ADD CONSTRAINT factory_address_key UNIQUE (address);
ALTER TABLE ONLY xgraph_png.factory
    ADD CONSTRAINT factory_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.liquidity_position
    ADD CONSTRAINT liquidity_position_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.liquidity_position_snapshot
    ADD CONSTRAINT liquidity_position_snapshot_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.liquidity_position
    ADD CONSTRAINT liquidity_position_user_id_pair_address_key UNIQUE (user_id, pair_address);
ALTER TABLE ONLY xgraph_png.mint
    ADD CONSTRAINT mint_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.pair
    ADD CONSTRAINT pair_address_key UNIQUE (address);
ALTER TABLE ONLY xgraph_png.pair_day_data
    ADD CONSTRAINT pair_day_data_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.pair_hour_data
    ADD CONSTRAINT pair_hour_data_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.pair
    ADD CONSTRAINT pair_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.pair
    ADD CONSTRAINT pair_token0_address_token1_address_key UNIQUE (token0_address, token1_address);
ALTER TABLE ONLY xgraph_png.state
    ADD CONSTRAINT state_name_key UNIQUE (name);
ALTER TABLE ONLY xgraph_png.state
    ADD CONSTRAINT state_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.swap
    ADD CONSTRAINT swap_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.sync
    ADD CONSTRAINT sync_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.token
    ADD CONSTRAINT token_address_key UNIQUE (address);
ALTER TABLE ONLY xgraph_png.token_day_data
    ADD CONSTRAINT token_day_data_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.token_hour_data
    ADD CONSTRAINT token_hour_data_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.transaction
    ADD CONSTRAINT transaction_hash_key UNIQUE (hash);
ALTER TABLE ONLY xgraph_png.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.transfer
    ADD CONSTRAINT transfer_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png."user"
    ADD CONSTRAINT user_address_key UNIQUE (address);
ALTER TABLE ONLY xgraph_png."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.block
    ADD CONSTRAINT block_hash_key UNIQUE (hash);
ALTER TABLE ONLY xgraph_psys.block
    ADD CONSTRAINT block_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.bundle
    ADD CONSTRAINT "bundle_block_id_logIndex_key" UNIQUE (block_id, "logIndex");
ALTER TABLE ONLY xgraph_psys.bundle
    ADD CONSTRAINT bundle_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.burn
    ADD CONSTRAINT burn_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.exchange_day_data
    ADD CONSTRAINT exchange_day_data_identifier_key UNIQUE (identifier);
ALTER TABLE ONLY xgraph_psys.exchange_day_data
    ADD CONSTRAINT exchange_day_data_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.factory
    ADD CONSTRAINT factory_address_key UNIQUE (address);
ALTER TABLE ONLY xgraph_psys.factory
    ADD CONSTRAINT factory_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.liquidity_position
    ADD CONSTRAINT liquidity_position_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.liquidity_position_snapshot
    ADD CONSTRAINT liquidity_position_snapshot_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.liquidity_position
    ADD CONSTRAINT liquidity_position_user_id_pair_address_key UNIQUE (user_id, pair_address);
ALTER TABLE ONLY xgraph_psys.mint
    ADD CONSTRAINT mint_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.pair
    ADD CONSTRAINT pair_address_key UNIQUE (address);
ALTER TABLE ONLY xgraph_psys.pair_day_data
    ADD CONSTRAINT pair_day_data_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.pair_hour_data
    ADD CONSTRAINT pair_hour_data_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.pair
    ADD CONSTRAINT pair_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.pair
    ADD CONSTRAINT pair_token0_address_token1_address_key UNIQUE (token0_address, token1_address);
ALTER TABLE ONLY xgraph_psys.state
    ADD CONSTRAINT state_name_key UNIQUE (name);
ALTER TABLE ONLY xgraph_psys.state
    ADD CONSTRAINT state_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.swap
    ADD CONSTRAINT swap_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.sync
    ADD CONSTRAINT sync_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.token
    ADD CONSTRAINT token_address_key UNIQUE (address);
ALTER TABLE ONLY xgraph_psys.token_day_data
    ADD CONSTRAINT token_day_data_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.token_hour_data
    ADD CONSTRAINT token_hour_data_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.transaction
    ADD CONSTRAINT transaction_hash_key UNIQUE (hash);
ALTER TABLE ONLY xgraph_psys.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys.transfer
    ADD CONSTRAINT transfer_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_psys."user"
    ADD CONSTRAINT user_address_key UNIQUE (address);
ALTER TABLE ONLY xgraph_psys."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
ALTER TABLE ONLY xgraph_png.bundle
    ADD CONSTRAINT bundle_block_id_fkey FOREIGN KEY (block_id) REFERENCES xgraph_png.block(id);
ALTER TABLE ONLY xgraph_png.burn
    ADD CONSTRAINT burn_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_png.pair(address);
ALTER TABLE ONLY xgraph_png.burn
    ADD CONSTRAINT burn_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES xgraph_png.transaction(id);
ALTER TABLE ONLY xgraph_png.liquidity_position
    ADD CONSTRAINT liquidity_position_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_png.pair(address);
ALTER TABLE ONLY xgraph_png.liquidity_position_snapshot
    ADD CONSTRAINT liquidity_position_snapshot_block_id_fkey FOREIGN KEY (block_id) REFERENCES xgraph_png.block(id);
ALTER TABLE ONLY xgraph_png.liquidity_position_snapshot
    ADD CONSTRAINT "liquidity_position_snapshot_liquidityPosition_id_fkey" FOREIGN KEY ("liquidityPosition_id") REFERENCES xgraph_png.liquidity_position(id);
ALTER TABLE ONLY xgraph_png.liquidity_position_snapshot
    ADD CONSTRAINT liquidity_position_snapshot_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_png.pair(address);
ALTER TABLE ONLY xgraph_png.liquidity_position_snapshot
    ADD CONSTRAINT liquidity_position_snapshot_user_id_fkey FOREIGN KEY (user_id) REFERENCES xgraph_png."user"(id);
ALTER TABLE ONLY xgraph_png.liquidity_position
    ADD CONSTRAINT liquidity_position_user_id_fkey FOREIGN KEY (user_id) REFERENCES xgraph_png."user"(id);
ALTER TABLE ONLY xgraph_png.mint
    ADD CONSTRAINT mint_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_png.pair(address);
ALTER TABLE ONLY xgraph_png.mint
    ADD CONSTRAINT mint_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES xgraph_png.transaction(id);
ALTER TABLE ONLY xgraph_png.pair
    ADD CONSTRAINT pair_block_id_fkey FOREIGN KEY (block_id) REFERENCES xgraph_png.block(id);
ALTER TABLE ONLY xgraph_png.pair_day_data
    ADD CONSTRAINT pair_day_data_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_png.pair(address);
ALTER TABLE ONLY xgraph_png.pair_hour_data
    ADD CONSTRAINT pair_hour_data_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_png.pair(address);
ALTER TABLE ONLY xgraph_png.pair
    ADD CONSTRAINT pair_token0_address_fkey FOREIGN KEY (token0_address) REFERENCES xgraph_png.token(address);
ALTER TABLE ONLY xgraph_png.pair
    ADD CONSTRAINT pair_token1_address_fkey FOREIGN KEY (token1_address) REFERENCES xgraph_png.token(address);
ALTER TABLE ONLY xgraph_png.swap
    ADD CONSTRAINT swap_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_png.pair(address);
ALTER TABLE ONLY xgraph_png.swap
    ADD CONSTRAINT swap_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES xgraph_png.transaction(id);
ALTER TABLE ONLY xgraph_png.sync
    ADD CONSTRAINT sync_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_png.pair(address);
ALTER TABLE ONLY xgraph_png.sync
    ADD CONSTRAINT sync_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES xgraph_png.transaction(id);
ALTER TABLE ONLY xgraph_png.token_day_data
    ADD CONSTRAINT token_day_data_token_address_fkey FOREIGN KEY (token_address) REFERENCES xgraph_png.token(address);
ALTER TABLE ONLY xgraph_png.token_hour_data
    ADD CONSTRAINT token_hour_data_token_address_fkey FOREIGN KEY (token_address) REFERENCES xgraph_png.token(address);
ALTER TABLE ONLY xgraph_png.transaction
    ADD CONSTRAINT transaction_block_id_fkey FOREIGN KEY (block_id) REFERENCES xgraph_png.block(id);
ALTER TABLE ONLY xgraph_png.transfer
    ADD CONSTRAINT transfer_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_png.pair(address);
ALTER TABLE ONLY xgraph_png.transfer
    ADD CONSTRAINT transfer_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES xgraph_png.transaction(id);
ALTER TABLE ONLY xgraph_psys.bundle
    ADD CONSTRAINT bundle_block_id_fkey FOREIGN KEY (block_id) REFERENCES xgraph_psys.block(id);
ALTER TABLE ONLY xgraph_psys.burn
    ADD CONSTRAINT burn_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_psys.pair(address);
ALTER TABLE ONLY xgraph_psys.burn
    ADD CONSTRAINT burn_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES xgraph_psys.transaction(id);
ALTER TABLE ONLY xgraph_psys.liquidity_position
    ADD CONSTRAINT liquidity_position_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_psys.pair(address);
ALTER TABLE ONLY xgraph_psys.liquidity_position_snapshot
    ADD CONSTRAINT liquidity_position_snapshot_block_id_fkey FOREIGN KEY (block_id) REFERENCES xgraph_psys.block(id);
ALTER TABLE ONLY xgraph_psys.liquidity_position_snapshot
    ADD CONSTRAINT "liquidity_position_snapshot_liquidityPosition_id_fkey" FOREIGN KEY ("liquidityPosition_id") REFERENCES xgraph_psys.liquidity_position(id);
ALTER TABLE ONLY xgraph_psys.liquidity_position_snapshot
    ADD CONSTRAINT liquidity_position_snapshot_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_psys.pair(address);
ALTER TABLE ONLY xgraph_psys.liquidity_position_snapshot
    ADD CONSTRAINT liquidity_position_snapshot_user_id_fkey FOREIGN KEY (user_id) REFERENCES xgraph_psys."user"(id);
ALTER TABLE ONLY xgraph_psys.liquidity_position
    ADD CONSTRAINT liquidity_position_user_id_fkey FOREIGN KEY (user_id) REFERENCES xgraph_psys."user"(id);
ALTER TABLE ONLY xgraph_psys.mint
    ADD CONSTRAINT mint_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_psys.pair(address);
ALTER TABLE ONLY xgraph_psys.mint
    ADD CONSTRAINT mint_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES xgraph_psys.transaction(id);
ALTER TABLE ONLY xgraph_psys.pair
    ADD CONSTRAINT pair_block_id_fkey FOREIGN KEY (block_id) REFERENCES xgraph_psys.block(id);
ALTER TABLE ONLY xgraph_psys.pair_day_data
    ADD CONSTRAINT pair_day_data_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_psys.pair(address);
ALTER TABLE ONLY xgraph_psys.pair_hour_data
    ADD CONSTRAINT pair_hour_data_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_psys.pair(address);
ALTER TABLE ONLY xgraph_psys.pair
    ADD CONSTRAINT pair_token0_address_fkey FOREIGN KEY (token0_address) REFERENCES xgraph_psys.token(address);
ALTER TABLE ONLY xgraph_psys.pair
    ADD CONSTRAINT pair_token1_address_fkey FOREIGN KEY (token1_address) REFERENCES xgraph_psys.token(address);
ALTER TABLE ONLY xgraph_psys.swap
    ADD CONSTRAINT swap_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_psys.pair(address);
ALTER TABLE ONLY xgraph_psys.swap
    ADD CONSTRAINT swap_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES xgraph_psys.transaction(id);
ALTER TABLE ONLY xgraph_psys.sync
    ADD CONSTRAINT sync_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_psys.pair(address);
ALTER TABLE ONLY xgraph_psys.sync
    ADD CONSTRAINT sync_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES xgraph_psys.transaction(id);
ALTER TABLE ONLY xgraph_psys.token_day_data
    ADD CONSTRAINT token_day_data_token_address_fkey FOREIGN KEY (token_address) REFERENCES xgraph_psys.token(address);
ALTER TABLE ONLY xgraph_psys.token_hour_data
    ADD CONSTRAINT token_hour_data_token_address_fkey FOREIGN KEY (token_address) REFERENCES xgraph_psys.token(address);
ALTER TABLE ONLY xgraph_psys.transaction
    ADD CONSTRAINT transaction_block_id_fkey FOREIGN KEY (block_id) REFERENCES xgraph_psys.block(id);
ALTER TABLE ONLY xgraph_psys.transfer
    ADD CONSTRAINT transfer_pair_address_fkey FOREIGN KEY (pair_address) REFERENCES xgraph_psys.pair(address);
ALTER TABLE ONLY xgraph_psys.transfer
    ADD CONSTRAINT transfer_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES xgraph_psys.transaction(id);
