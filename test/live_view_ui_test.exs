defmodule LiveViewUITest do
  use ExUnit.Case

  doctest LiveViewUI

  test "greets the world" do
    assert LiveViewUI.hello() == :world
  end
end
