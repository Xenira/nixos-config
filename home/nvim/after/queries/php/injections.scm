(member_call_expression
  name: (name) @fnName (#match? @fnName "^addSql$")
  arguments: (arguments
    (argument
      (string [(string_content)] @injection.content
        (#set! injection.language "sql")
        (#set! injection.combined)
      )
    )
  )
)
