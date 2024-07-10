Code.require_file("./slick_template.exs")

require IEx

# import SlickTemplate

template = """
html
  head
    title My HTML title
  body
    h1 {greeting}
    ul
      - for user <- users do
        li {user.name}
"""

vars = %{
  greeting: "Hello, World!",
  users: [%{name: "Alice"}, %{name: "Bob"}]
}

t = SlickTemplate.new(template, vars, pretty: true)

SlickTemplate.render(t)
|> IO.puts()
