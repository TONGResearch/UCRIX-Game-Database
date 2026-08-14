# Data dictionary

## `game_rule_versions`

Tracks the calculation-rule version used to explain historical results. A partial unique index permits only one active rule version.

## `game_sessions`

One anonymous game save per `session_id`. Frequently queried routing fields are relational columns; `state_payload` preserves the complete versioned game state as JSONB.

No name, email, student number, IP address, account password or precise location is stored.

## `round_records`

One immutable logical record per session and round. The unique `(session_id, round_number)` constraint supports idempotent backend upserts. Metrics, supply and risk objects remain JSONB because their versioned shape belongs to the game rules.

## `anonymous_events`

Minimal product events with a strict event-name whitelist. These records are intended for aggregate learning analysis, not user tracking.
