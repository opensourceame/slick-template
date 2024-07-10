defmodule SlickNodeTest do
  use ExUnit.Case
  doctest SlickNode

  test "parse simple tag" do
    node = SlickNode.parse("div Hello")
    assert node.tag  == "div"
    assert node.text == "Hello"
  end

  test "parse tag with attributes" do
    node = SlickNode.parse("div.container#main Content")

    assert node.tag   == "div"
    assert node.attrs == %{class: "container", id: "main"}
    assert node.text  == "Content"
  end

  test "parse with whitespace" do
    node = SlickNode.parse("  p   Text  ")

    assert node.ws_pre  == "  "
    assert node.tag     == "p"
    assert node.text    == "Text"
    assert node.ws_post == "  "
  end

  test "parse text-only line" do
    node = SlickNode.parse("Just some text")

    assert node.tag  == nil
    assert node.text == "Just some text"
  end
end
