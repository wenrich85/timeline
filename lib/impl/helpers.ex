defmodule Timeline.Impl.Helpers do

  def get_single_state(pid) do
    Agent.get(pid, fn state -> state end)
  end

  def get_list_of_states(list_of_pids) do
    Enum.map(list_of_pids, &get_single_state/1)
  end

  def expand_milestone_steps(list_of_milestones) do
    get_list_of_states(list_of_milestones)
    |>Enum.map(fn ms ->
      struct(ms, steps: get_list_of_states(ms.steps) )
    end)
  end

end
