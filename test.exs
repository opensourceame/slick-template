require IEx

Code.require_file("lib/slick_node.ex")
# Code.require_file("./slick_template.exs")


# import SlickTemplate

# template = """
# html
#   head
#     title My HTML title
#   body
#     h1 {greeting}
#     ul
#       - for user <- users do
#         li {user.name}
# """

# vars = %{
#   greeting: "Hello, World!",
#   users: [%{name: "Alice"}, %{name: "Bob"}]
# }

# t = SlickTemplate.new(template, vars, pretty: true)

# SlickTemplate.render(t)
# |> IO.puts()

line = "div.container#main class='something' data-something='else' Content"

SlickNode.parse(line)
|> IO.inspect()
