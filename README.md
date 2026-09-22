# samyang — API

GraphQL API for **samyang**, a dating application: user profiles, photo management,
swipe/match mechanics, and messaging between matched users.

Built solo on **Ruby on Rails 8** as part of ChatGenie's developer evaluation — their
process was to teach a stack, then have candidates ship a real project on it. I learned
Rails and GraphQL for this build and came out of that process onto the team.

The Vue client lives in **[samyang-front](https://github.com/Darkify19/samyang-front)**.
More of my work: **[portfolio](https://darkify19.github.io/carl-janzell-portfolio/)**.

> **Status:** source-available reference. The hosted demo on Render is retired, so the
> public GraphQL endpoint no longer answers — run it locally with the steps below.

## Stack

| | |
|---|---|
| Language | Ruby 3.3.5 |
| Framework | Rails 8.0 (API) |
| API | GraphQL (`graphql-ruby`) |
| Database | PostgreSQL |
| Auth | `bcrypt` / `has_secure_password` with session-backed context |
| Cross-origin | `rack-cors` |
| Deploy | Render (`render.yaml`), Docker image included |

## Domain model

- **User** — profile fields (name, birthdate, gender, orientation, gender interest, location, bio) with a `password_digest`
- **Photo** — a user's photo set, with one flagged primary
- **Match** — a directed `user → liked_user` like; a mutual pair is a match
- **Message** — messaging between matched users

## GraphQL surface

Mutations in [`app/graphql/mutations`](app/graphql/mutations):

| Mutation | Purpose |
|---|---|
| `register_user` / `login_user` | Account creation and session login |
| `update_user` / `delete_user` | Profile maintenance and account removal |
| `upload_photo` / `delete_photo` / `set_primary_photo` | Photo set management |
| `create_match` / `skip_user` | Swipe right / swipe left |
| `remove_match` | Unmatch |

## Running locally

Requires Ruby 3.3.5 and a running PostgreSQL.

```bash
bundle install
bin/rails db:create db:schema:load
bin/rails server
```

The API is then at `http://localhost:3000/graphql`, which is the endpoint
`samyang-front` targets in development.

## Configuration

| Variable | Used by | Notes |
|---|---|---|
| `DATABASE_URL` | production | Or the discrete `DATABASE_NAME` / `DATABASE_USERNAME` / `DATABASE_PASSWORD` / `DATABASE_HOST` |
| `RAILS_MASTER_KEY` | production | Decrypts `config/credentials.yml.enc` |
| `CORS_ORIGINS` | all | Comma-separated origins allowed to call the API. Defaults to `http://localhost:8080`, the Vue dev server |
| `RAILS_MAX_THREADS` | all | Connection pool size, default 5 |

Databases are `samyang_development` and `samyang_test` locally — see
[`config/database.yml`](config/database.yml). [`render.yaml`](render.yaml) describes a free-tier
Render deployment of the API plus its PostgreSQL instance.

## Tests

```bash
bin/rails test
```

## Notes

Photo binaries are uploaded client-side to Cloudinary by the front end; this API stores the
resulting references. Active Storage tables are present in the schema but the live upload
path goes through Cloudinary's widget.
