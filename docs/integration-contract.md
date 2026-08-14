# Backend integration contract

The database is isolated from the browser. A backend service owns credentials and maps these HTTP operations to parameterized SQL or a repository layer:

```text
GET    /api/game-sessions/{anonymousSessionId}
PUT    /api/game-sessions/{anonymousSessionId}
DELETE /api/game-sessions/{anonymousSessionId}
GET    /api/game-sessions/{anonymousSessionId}/rounds
POST   /api/anonymous-events
```

Requirements for the backend:

- verify that the path session ID matches the payload;
- accept only the documented anonymous fields;
- use transactions for session and round upserts;
- apply rate limits and a strict CORS allowlist;
- never return database credentials to the frontend;
- use TLS in deployed environments;
- run migrations before accepting traffic;
- preserve `state_version` and `rule_version` for compatibility.

The game can continue using IndexedDB while the backend is unavailable. Connecting the two repositories later requires a separately reviewed frontend/backend change; this database repository alone cannot alter game behavior.
