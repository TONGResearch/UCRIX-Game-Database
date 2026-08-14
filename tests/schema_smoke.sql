\set ON_ERROR_STOP on

BEGIN;

INSERT INTO game_sessions (
    session_id, state_version, rule_version, language, phase,
    current_round, max_rounds, failures, state_payload
) VALUES (
    'eco-schema-test', 1, '2026.1', 'zh', 'game',
    1, 8, 0, '{"version":1,"sessionId":"eco-schema-test"}'::jsonb
);

INSERT INTO round_records (
    session_id, round_number, rule_version, event_id, action_id, district,
    before_metrics, after_metrics, supply_breakdown, risk_breakdown, round_payload
) VALUES (
    'eco-schema-test', 1, '2026.1', 'flood', 'flood-inspection', 'yingze',
    '{"stability":76}'::jsonb,
    '{"stability":80}'::jsonb,
    '{"unserved":0}'::jsonb,
    '{"impactRisk":0.1}'::jsonb,
    '{"round":1,"eventId":"flood"}'::jsonb
);

INSERT INTO anonymous_events (session_id, event_name, round_number, crisis_event_id, action_id)
VALUES ('eco-schema-test', 'decision_confirmed', 1, 'flood', 'flood-inspection');

DO $$
BEGIN
    IF (SELECT COUNT(*) FROM game_sessions WHERE session_id = 'eco-schema-test') <> 1 THEN
        RAISE EXCEPTION 'game session insert failed';
    END IF;
    IF (SELECT COUNT(*) FROM round_records WHERE session_id = 'eco-schema-test') <> 1 THEN
        RAISE EXCEPTION 'round record insert failed';
    END IF;
END;
$$;

DELETE FROM game_sessions WHERE session_id = 'eco-schema-test';

DO $$
BEGIN
    IF (SELECT COUNT(*) FROM round_records WHERE session_id = 'eco-schema-test') <> 0 THEN
        RAISE EXCEPTION 'round cascade delete failed';
    END IF;
    IF (SELECT COUNT(*) FROM anonymous_events WHERE session_id = 'eco-schema-test') <> 0 THEN
        RAISE EXCEPTION 'event cascade delete failed';
    END IF;
END;
$$;

ROLLBACK;
