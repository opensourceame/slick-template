defmodule SlickNode do
  defstruct [:name, :children, :line, :tag, :text, :attrs, :ws_pre, :ws_post]

  def new(opts \\ []) do
    struct(__MODULE__, opts ++ [children: [], attrs: %{}])
  end

  defp parse_tag(str) do
    case Regex.run(~r/^(\w+)/, str) do
      [tag, _] -> {tag, String.trim_leading(str, tag)}
      nil -> {nil, str}
    end
  end

  defp parse_attributes(str) do
    case Regex.run(~r/^\s*\{([^}]+)\}/, str) do
      [full_match, attrs_str] ->
        attrs = String.split(attrs_str, ",")
        |> Enum.map(&String.split(&1, "="))
        |> Enum.map(fn [k, v] -> {String.to_atom(String.trim(k)), String.trim(v)} end)
        |> Map.new()
        {attrs, String.trim_leading(str, full_match)}
      nil -> {%{}, str}
    end
  end

  defp parse_text(str) do
    str = String.trim(str)
    if String.length(str) > 0 do
      {str, ""}
    else
      {nil, str}
    end
  end
end
