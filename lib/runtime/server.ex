defmodule Timeline.Runtime.Server do
  alias Timeline.Impl.Goal
  alias Timeline.Impl.Milestone
  alias Timeline.Impl.Step
  use GenServer
  use Agent

  #### client #####
  def start_link(initial_data) do
    GenServer.start_link(__MODULE__, initial_data)
  end

  #### server ####
  def init(initial_data) do
    {:ok, Goal.new_goal(initial_data)}
  end

  def handle_cast({:add_step, {milestone, step_to_add}}, timeline) do
    {:ok, step} = Agent.start_link(fn -> Step.new(step_to_add) end)
    Agent.update(milestone, fn state -> Milestone.add_step(state, step) end )
    {:noreply, timeline }
  end

  def handle_call(:start_goal, _from, timeline) do
    new_goal = Goal.start_goal(timeline)
    {:reply, new_goal, new_goal}
  end

  def handle_call({:start_goal, date}, _from, timeline) do
    new_goal = Goal.start_goal(timeline, date)
    {:reply, new_goal, new_goal}
  end

  def handle_call({:add_milestone, milestone_info}, _from, timeline) do
    {:ok, milestone } = Agent.start_link(fn -> Milestone.new_milestone(milestone_info) end)
    updated_goal = Goal.add_milestone(timeline, milestone)
    {:reply, updated_goal, updated_goal}
  end
end
