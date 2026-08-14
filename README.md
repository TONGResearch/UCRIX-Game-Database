# UCRIX Game Database

Independent PostgreSQL database source for the EcoResist Taiyuan game. This repository is intentionally separate from the Vite/Phaser game repository, so schema work can be reviewed and released without changing frontend or backend code.

## Contents

```text
UCRIX-Game-Database/
├── schema/                 # consolidated schema for review
├── migrations/             # ordered production migrations
├── seed/                   # non-sensitive reference data
├── queries/                # documented backend query patterns
├── tests/                  # SQL smoke tests
├── docs/                   # data dictionary and integration contract
├── .env.example            # local variable names; no real secrets
└── compose.yml             # optional local PostgreSQL 18 environment
```

## Local verification

```bash
cp .env.example .env
docker compose up -d
docker compose exec -T postgres psql -U ecoresist -d ecoresist \
  -f /database/migrations/V1__initial_game_schema.sql
docker compose exec -T postgres psql -U ecoresist -d ecoresist \
  -f /database/seed/reference_rules.sql
docker compose exec -T postgres psql -U ecoresist -d ecoresist \
  -f /database/tests/schema_smoke.sql
```

The example password is for an isolated local container only. Production credentials, `.env` files, database dumps, wallets, certificates and player data must never be committed.

## Integration boundary

The browser must not connect to PostgreSQL directly. A backend service should apply `migrations/`, hold the database credentials, and expose authenticated or rate-limited HTTPS endpoints. See `docs/integration-contract.md` for the expected API boundary.
