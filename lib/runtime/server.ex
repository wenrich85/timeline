defmodule Timeline.Runtime.Server do
  alias Timeline.Impl.Goal
  alias Timeline.Impl.Milestone
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

  def handle_call(:start_goal, _from, timeline) do
    new_goal = Goal.start_goal(timeline)
    {:reply, new_goal, new_goal}
  end

  def handle_call({:start_goal, date}, _from, timeline) do
    new_goal = Goal.start_goal(timeline, date)
    {:reply, new_goal, new_goal}
  end

  def handle_call({:add_milestone, milestone_info}, _from, timeline) do
    ms = Milestone.new_milestone(milestone_info)
    updated_goal = Goal.add_milestone(timeline, ms)
    {:reply, updated_goal, updated_goal}
  end

  def handle_call({:add_step, milestone_info}, _from, timeline) do
    ug = Goal.add_step(timeline, milestone_info)
    {:reply, ug, ug }
  end

end
