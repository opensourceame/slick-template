require IEx

defmodule SlickNode do
  @doc """
  A node in the Slick template.
  """
  defstruct [:name, :children, :line, :tag, :text, :attrs, :ws_pre, :ws_post]

  def new(opts \\ []) do
    struct(__MODULE__, opts ++ [children: [], attrs: %{}])
  end

  def parse(raw_line) do
    line      = String.trim(raw_line)
    line_type = determine_line_type(line)

    case line_type do
      :empty        -> {:ok, nil}
      :comment      -> {:ok, nil}
      :html_comment -> {:ok, html_comment(line)}
      :tag          -> {:ok, parsed_line(line)}
      _ -> IEx.pry
      # _             -> {:error, "Unknown line type"}
    end
  end

  def determine_line_type(line) do
    cond do
      line == ""                      -> :empty
      String.starts_with?(line, "/!") -> :html_comment
      String.starts_with?(line, "/")  -> :comment
      true                            -> :tag
    end
  end

  def parsed_line(line) do
    parts      = String.split(line, ~r/\s+/)
    tp         = hd(parts)
    attributes = []

    {tag, classes, id} = parse_tag_part(tp)

    Enum.each(Enum.with_index(tl(parts), 1), fn {part, index} ->
      IO.puts("Processing part #{index}: #{part}")

      if String.contains?(part, "=") do
        attributes.push process_attribute(part)
      end
    end)

    IEx.pry
    # Regex to match tag, classes, and id
    # regex = ~r/^\s*(\w+)((?:\.[^#\s]+)*)(#[^.\s]+)?/

    # case Regex.run(regex, line) do
    #   [full_match, tag, classes_str, id_str | _] ->
    #     classes = parse_classes(classes_str)
    #     id = parse_id(id_str)
    #     rest = String.trim_leading(line, full_match)
    #     {tag, classes, id, rest}
    #   _ ->
    #     {nil, [], nil, line}
    # end
  end

  defp process_attribute(str) do
    [key, value] = String.split(str, "=")
    {key, value}
  end

  defp html_comment(line) do
    "<!-- #{String.trim_leading(line, "/! ")} -->"
  end

  defp parse_tag_part(tag_part) do
    classes      = []
    id           = nil
    [tag | rest] = String.split(tag_part, ~r/(?=[.#])/)

    Enum.reduce(rest, {tag, classes, id}, fn part, {tag, classes, id} ->
      case String.first(part) do
        "." -> {tag, [String.slice(part, 1..-1//-1) | classes], id}
        "#" -> {tag, classes, String.slice(part, 1..-1//-1)}
        _   -> {tag, classes, id}
      end
    end)
  end

  # defp parse_classes(""), do: []
  # defp parse_classes(classes_str) do
  #   classes_strtag = tag_part.split(tag_part, ~r/\.|#/)
  #   |> String.split(".")
  #   |> Enum.filter(&(&1 != ""))
  # end

  # defp parse_id(nil), do: nil
  # defp parse_id(id_str), do: String.trim_leading(id_str, "#")

end
