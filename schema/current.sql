-- Convenience entry point for a fresh PostgreSQL database.
-- psql resolves \ir relative to this file.
\set ON_ERROR_STOP on
\ir ../migrations/V1__initial_game_schema.sql
