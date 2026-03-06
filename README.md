# CompsAnalytics Backend (FastAPI)

This repository has been migrated to a Python FastAPI backend that mirrors the original Rails API surface for users, sessions, properties, valuation, accounts, transactions, and notifications.

## Run locally

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python run.py
```

API will be available at `http://localhost:8000` and docs at `http://localhost:8000/docs`.

## Notes

- Uses SQLite (`comps_analytics.db`) for local development.
- Session-based login uses Starlette `SessionMiddleware` and a cookie-backed `user_id` similar to previous behavior.
