defmodule PlantMonitor.RandomTest do
  use PlantMonitor.DataCase
  alias PlantMonitor.Random

  # RANDOM KEY

  test "[RANDOM_KEY] Check default length" do
    key = Random.random_key()
    assert String.length(key) == 20
  end

  test "[RANDOM_KEY] Custom length" do
    n = 30
    key = Random.random_key(n)
    assert String.length(key) == n
  end

end
