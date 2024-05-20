;; extends

; ----------------------------------------------------------------
; SQL injection for Rust - sqlx, diesel, rusqlite, tokio-postgres, etc.
; ----------------------------------------------------------------

; sqlx macros: query!(), query_as!(), query_scalar!(), query_as_unchecked!()
((macro_invocation
  macro: (identifier) @_macro
  (token_tree
    (string_literal
      (string_content) @injection.content)))
  (#any-of? @_macro "query" "query_as" "query_scalar" "query_as_unchecked" "query_unchecked")
  (#set! injection.language "sql"))

; sqlx macros with raw strings: query!(r#"SELECT..."#)
((macro_invocation
  macro: (identifier) @_macro
  (token_tree
    (raw_string_literal
      (string_content) @injection.content)))
  (#any-of? @_macro "query" "query_as" "query_scalar" "query_as_unchecked" "query_unchecked")
  (#set! injection.language "sql"))

; sqlx scoped macros: sqlx::query!(), sqlx::query_as!()
((macro_invocation
  macro: (scoped_identifier
    path: (identifier) @_path
    name: (identifier) @_macro)
  (token_tree
    (string_literal
      (string_content) @injection.content)))
  (#eq? @_path "sqlx")
  (#any-of? @_macro "query" "query_as" "query_scalar" "query_as_unchecked" "query_unchecked")
  (#set! injection.language "sql"))

; sqlx scoped macros with raw strings
((macro_invocation
  macro: (scoped_identifier
    path: (identifier) @_path
    name: (identifier) @_macro)
  (token_tree
    (raw_string_literal
      (string_content) @injection.content)))
  (#eq? @_path "sqlx")
  (#any-of? @_macro "query" "query_as" "query_scalar" "query_as_unchecked" "query_unchecked")
  (#set! injection.language "sql"))

; ----------------------------------------------------------------
; Method call based injection (rusqlite, tokio-postgres, etc.)
; e.g., conn.execute("SELECT...", params)
; ----------------------------------------------------------------

((call_expression
  function: (field_expression
    field: (field_identifier) @_method)
  arguments: (arguments
    (string_literal
      (string_content) @injection.content)))
  (#any-of? @_method "execute" "execute_batch" "query" "query_row" "query_map"
                     "prepare" "prepare_cached" "query_one" "query_opt" "query_all"
                     "query_typed" "query_raw" "execute_raw" "simple_query")
  (#set! injection.language "sql"))

; Method calls with raw strings
((call_expression
  function: (field_expression
    field: (field_identifier) @_method)
  arguments: (arguments
    (raw_string_literal
      (string_content) @injection.content)))
  (#any-of? @_method "execute" "execute_batch" "query" "query_row" "query_map"
                     "prepare" "prepare_cached" "query_one" "query_opt" "query_all"
                     "query_typed" "query_raw" "execute_raw" "simple_query")
  (#set! injection.language "sql"))

; ----------------------------------------------------------------
; Keyword-based pattern matching (fallback for any string)
; ----------------------------------------------------------------

; SELECT ... FROM
((string_content) @injection.content
 (#match? @injection.content "(SELECT|select|Select).+(FROM|from|From)")
 (#set! injection.language "sql"))

((raw_string_literal
  (string_content) @injection.content)
 (#match? @injection.content "(SELECT|select|Select).+(FROM|from|From)")
 (#set! injection.language "sql"))

; INSERT INTO
((string_content) @injection.content
 (#match? @injection.content "(INSERT|insert|Insert).+(INTO|into|Into)")
 (#set! injection.language "sql"))

((raw_string_literal
  (string_content) @injection.content)
 (#match? @injection.content "(INSERT|insert|Insert).+(INTO|into|Into)")
 (#set! injection.language "sql"))

; UPDATE ... SET
((string_content) @injection.content
 (#match? @injection.content "(UPDATE|update|Update).+(SET|set|Set)")
 (#set! injection.language "sql"))

((raw_string_literal
  (string_content) @injection.content)
 (#match? @injection.content "(UPDATE|update|Update).+(SET|set|Set)")
 (#set! injection.language "sql"))

; DELETE FROM
((string_content) @injection.content
 (#match? @injection.content "(DELETE|delete|Delete).+(FROM|from|From)")
 (#set! injection.language "sql"))

((raw_string_literal
  (string_content) @injection.content)
 (#match? @injection.content "(DELETE|delete|Delete).+(FROM|from|From)")
 (#set! injection.language "sql"))

; CREATE TABLE
((string_content) @injection.content
 (#match? @injection.content "(CREATE|create|Create).+(TABLE|table|Table)")
 (#set! injection.language "sql"))

((raw_string_literal
  (string_content) @injection.content)
 (#match? @injection.content "(CREATE|create|Create).+(TABLE|table|Table)")
 (#set! injection.language "sql"))

; ALTER TABLE
((string_content) @injection.content
 (#match? @injection.content "(ALTER|alter|Alter).+(TABLE|table|Table)")
 (#set! injection.language "sql"))

((raw_string_literal
  (string_content) @injection.content)
 (#match? @injection.content "(ALTER|alter|Alter).+(TABLE|table|Table)")
 (#set! injection.language "sql"))

; DROP TABLE
((string_content) @injection.content
 (#match? @injection.content "(DROP|drop|Drop).+(TABLE|table|Table)")
 (#set! injection.language "sql"))

((raw_string_literal
  (string_content) @injection.content)
 (#match? @injection.content "(DROP|drop|Drop).+(TABLE|table|Table)")
 (#set! injection.language "sql"))

; CREATE INDEX
((string_content) @injection.content
 (#match? @injection.content "(CREATE|create|Create).+(INDEX|index|Index)")
 (#set! injection.language "sql"))

((raw_string_literal
  (string_content) @injection.content)
 (#match? @injection.content "(CREATE|create|Create).+(INDEX|index|Index)")
 (#set! injection.language "sql"))

; WITH ... AS (CTEs)
((string_content) @injection.content
 (#match? @injection.content "(WITH|with|With).+(AS|as|As)")
 (#set! injection.language "sql"))

((raw_string_literal
  (string_content) @injection.content)
 (#match? @injection.content "(WITH|with|With).+(AS|as|As)")
 (#set! injection.language "sql"))

; ----------------------------------------------------------------
; Comment hint based injection (-- sql or --sql)
; ----------------------------------------------------------------

((string_content) @injection.content
 (#contains? @injection.content "-- sql" "--sql")
 (#set! injection.language "sql"))

((raw_string_literal
  (string_content) @injection.content)
 (#contains? @injection.content "-- sql" "--sql")
 (#set! injection.language "sql"))

; ----------------------------------------------------------------
; Multi-keyword fallback for complex statements
; ----------------------------------------------------------------

((string_content) @injection.content
 (#contains? @injection.content "GROUP BY" "group by" "ORDER BY" "order by"
                                "LEFT JOIN" "left join" "RIGHT JOIN" "right join"
                                "INNER JOIN" "inner join" "OUTER JOIN" "outer join"
                                "PRIMARY KEY" "primary key" "FOREIGN KEY" "foreign key"
                                "NOT NULL" "not null" "REFERENCES" "references"
                                "RETURNING" "returning" "ON CONFLICT" "on conflict")
 (#set! injection.language "sql"))

((raw_string_literal
  (string_content) @injection.content)
 (#contains? @injection.content "GROUP BY" "group by" "ORDER BY" "order by"
                                "LEFT JOIN" "left join" "RIGHT JOIN" "right join"
                                "INNER JOIN" "inner join" "OUTER JOIN" "outer join"
                                "PRIMARY KEY" "primary key" "FOREIGN KEY" "foreign key"
                                "NOT NULL" "not null" "REFERENCES" "references"
                                "RETURNING" "returning" "ON CONFLICT" "on conflict")
 (#set! injection.language "sql"))
