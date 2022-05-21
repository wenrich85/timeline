defmodule Timeline do

  alias Timeline.Runtime.Server


  def new_goal(initial_data) do
    {:ok, pid } = Server.start_link(initial_data)
    pid
  end

  def start_goal(game) do
    GenServer.call(game, :start_goal)
  end

  def start_goal(timeline, date) do
    GenServer.call(timeline, {:start_goal, date})
  end

  def add_milestone(timeline, initial_info) do
    GenServer.call(timeline, {:add_milestone, initial_info})
  end


end
