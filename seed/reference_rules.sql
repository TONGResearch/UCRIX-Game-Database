INSERT INTO game_rule_versions (rule_version, description, active)
VALUES ('2026.1', 'Initial transparent Taiyuan educational simulation rules', TRUE)
ON CONFLICT (rule_version) DO UPDATE
SET description = EXCLUDED.description,
    active = EXCLUDED.active;
