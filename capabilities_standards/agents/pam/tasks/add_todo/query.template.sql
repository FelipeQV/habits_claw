CREATE TABLE IF NOT EXISTS pam_todos (
  todo_id VARCHAR PRIMARY KEY,
  title VARCHAR NOT NULL,
  status VARCHAR NOT NULL,
  priority_label VARCHAR,
  priority_rank INTEGER,
  due_date DATE,
  notes VARCHAR,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);

INSERT INTO pam_todos (
  todo_id, title, status, priority_label, priority_rank, due_date, notes, created_at, updated_at
)
VALUES (
  COALESCE({{todo_id}}, uuid()),
  {{title}},
  'active',
  {{priority_label}},
  {{priority_rank}},
  {{due_date}},
  {{notes}},
  now(),
  now()
)
RETURNING todo_id, title, status, priority_label, priority_rank, due_date, created_at, updated_at;
