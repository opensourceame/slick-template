defmodule SlickNodeTest do
  use ExUnit.Case
  doctest SlickNode

  test "parse simple tag" do
    node = SlickNode.parse("div Hello")
    assert node.tag  == "div"
    assert node.text == "Hello"
  end

  test "parse tag with attributes" do
    node = SlickNode.parse("div style='width: 100px;' Content")

    assert node.tag   == "div"
    assert node.attrs == %{style: "width: 100px;"}
    assert node.text  == "Content"
  end

  test "parse tag with classes and id" do
    node = SlickNode.parse("div.class-a.class-b#my-id Some text")

    assert node.tag   == "div"
    assert node.attrs == %{class: ["class-a", "class-b"], id: "my-id"}
    assert node.text  == "Some text"
  end

  test "parse with whitespace" do
    node = SlickNode.parse("  p   Text  ")

    assert node.tag  == "p"
    assert node.text == "Text"
  end

  test "parse text-only line" do
    node = SlickNode.parse("Just some text")

    assert node.tag  == nil
    assert node.text == "Just some text"
  end

  test "parse a line starting with just a dot" do
    node = SlickNode.parse(". Some text")

    assert node.tag  == "div"
    assert node.text == "Some text"
  end

  test "parse a line with . class and a class='x' attribute" do
    node = SlickNode.parse("div#my-id.class-a class='class-b' Some text")

    assert node.tag   == "div"
    assert node.attrs == %{class: ["class-a", "class-b"], id: "my-id"}
    assert node.text  == "Some text"
  end
end
