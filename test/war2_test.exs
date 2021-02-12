defmodule War2Test do
  use ExUnit.Case
  doctest War2

  test "greets the world" do
    assert War2.hello() == :world
  end
end
