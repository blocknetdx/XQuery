#!/bin/bash

# sleep here for a different amount of time than other xq-engine containers.
# Running alembic setup in multiple containers simultanesously, with each container accessing the same db,
# creates non-unique key conflicts in the db.
sleep $ALEMBIC_SLEEP

if grep -iq $DEX /app/xq-engine/alembic/versions/*.py; then
  echo "Alembic migration already exists; skipping creation of alembic migration for ${DEX}..."
else
  echo "Alembic migration does not exist; creating alembic migration for ${DEX}..."
  alembic -n default -c alembic/alembic.ini revision --autogenerate -m "creating schema for ${DEX}"
fi

alembic -n default -c alembic/alembic.ini upgrade head

# Update hasura/graphql metadata to track all tables/views
cd hasura_project
mv config.yaml{,.template}
awk -v ip=$HASURA_IP "/HASURA_IP/{sub(/HASURA_IP/, ip)};{print}" config.yaml.template > config.yaml
hasura metadata apply
