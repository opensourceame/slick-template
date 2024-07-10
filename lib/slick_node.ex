require IEx


defmodule SlickNode do
  @doc """
  A node in the Slick template.
  """
  defstruct [:name, :children, :line, :tag, :text, :attrs, :ws_pre, :ws_post]

  def new(opts \\ []) do
    struct(__MODULE__, opts ++ [children: [], attrs: %{}])
  end

  def parse(line) do
    parts = String.split(line, ~r/\s+/)

    tp = hd(parts)
    {tag, classes, id} = parse_tag_part(tp)

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

  defp parse_tag_part(tag_part) do
    classes      = []
    id           = nil
    # [tag | rest] = tag_part

    # Enum.each(Enum.with_index(rest), fn {item, index} ->
    #   if item == "." do
    #     classes = classes ++ [rest[index + 1]]
    #   end

    #   if item == "#" do
    #     id = rest[index + 1]
    #   end
    # end)

    [tag | rest] = String.split(tag_part, ~r/[.#]/)

    Enum.reduce(rest, {tag, classes, id}, fn part, {tag, classes, id} ->
      case String.first(tag_part, part) do
        "." -> {tag, [part | classes], id}
        "#" -> {tag, classes, part}
        _ -> {tag, classes, id}
      end
    end)

    # {tag, classes, id}
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
