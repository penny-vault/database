# Database

PostgreSQL migrations for Penny Vault Database

# Usage

Create a super user called `pennyvault` and an associated database
also called `pennyvault`

run go migrate:

```bash
migrate -path migrations -database "postgresql://pennyvault@localhost:5432/pennyvault?sslmode=disable" up
```