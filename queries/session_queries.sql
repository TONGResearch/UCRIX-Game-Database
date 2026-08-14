-- Query patterns for the backend repository layer. Parameters are positional.

PREPARE load_game_session(VARCHAR) AS
SELECT state_payload
FROM game_sessions
WHERE session_id = $1;

PREPARE load_round_history(VARCHAR) AS
SELECT round_payload
FROM round_records
WHERE session_id = $1
ORDER BY round_number;

PREPARE delete_game_session(VARCHAR) AS
DELETE FROM game_sessions
WHERE session_id = $1;

-- Session and round writes should run in one backend-managed transaction.
-- Use INSERT ... ON CONFLICT (session_id) DO UPDATE for session saves and
-- ON CONFLICT (session_id, round_number) DO UPDATE for round records.
