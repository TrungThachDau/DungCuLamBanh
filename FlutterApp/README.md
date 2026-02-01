# whiskflourish

A new Flutter project.

## API environment configuration

API, account, and web base URLs are configured through `--dart-define` values:

- `API_BASE_URL`: base for REST endpoints (default `http://localhost:5000`)
- `ACCOUNT_BASE_URL`: base for account-related pages (default `API_BASE_URL`)
- `WEB_BASE_URL`: base for web/share URLs (default `API_BASE_URL`)

Run with custom values:

```bash
flutter run \
  --dart-define=API_BASE_URL=http://10.0.2.2:5000 \
  --dart-define=ACCOUNT_BASE_URL=https://example.com \
  --dart-define=WEB_BASE_URL=https://example.com
```
