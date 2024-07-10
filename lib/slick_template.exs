defmodule SlickTemplate do
  defstruct [:template, :vars, :options]

  def new(template, vars \\ %{}, options \\ []) do
    %__MODULE__{
      template: template,
      vars:     vars,
      options:  options
    }
  end

  def render(trim) do
    IO.inspect(trim)
    # IEx.pry()
    # 1. Parse the template
    # 2. Generate HTML
    # 3. Beautify HTML if option is set
  end

  defp parse_template(template) do
    # split the template into lines
    # String.split(template, "\n")
    # |>Enum.map(lines, &parse_line/1)
    template
  end

  defp parse_line(line) do
    # parse the line
    line
  end

  defp generate_html(parsed_template, vars) do
    # Implement HTML generation
  end

  defp beautify_html(html) do
    # Implement HTML beautification
  end
end
