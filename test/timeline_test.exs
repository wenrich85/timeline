defmodule TimelineTest do
  use ExUnit.Case
  doctest Timeline

  alias Timeline.Impl.Step

  test "Step.new returns a step struct" do
    step = Step.new(%{})
    assert is_binary(step.title)
    assert is_binary(step.description)
    assert step.status == :not_started
    assert step.order == 0
  end

  test "Map merges correctly with step struct" do
    step = Step.new(%{
      title: "Test",
      description: "Description of the test",
      status: :in_progress,
      order: 1
      })

    assert step.title == "Test"
    assert step.description == "Description of the test"
    assert step.status == :in_progress
    assert step.order == 1
  end
end
