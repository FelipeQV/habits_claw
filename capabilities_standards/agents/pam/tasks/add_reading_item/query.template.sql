CREATE TABLE IF NOT EXISTS pam_reading_items (
  reading_id VARCHAR PRIMARY KEY,
  url VARCHAR NOT NULL,
  description VARCHAR NOT NULL,
  status VARCHAR NOT NULL,
  categories VARCHAR[] NOT NULL,
  source VARCHAR,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);

INSERT INTO pam_reading_items (
  reading_id, url, description, status, categories, source, created_at, updated_at
)
VALUES (
  COALESCE({{reading_id}}, uuid()),
  {{url}},
  {{description}},
  'unread',
  {{categories}},
  {{source}},
  COALESCE({{captured_at}}, now()),
  COALESCE({{captured_at}}, now())
)
RETURNING reading_id, url, description, status, categories, source, created_at, updated_at;
