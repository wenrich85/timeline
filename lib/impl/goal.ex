defmodule Timeline.Impl.Goal do

  alias Timeline.Type
  alias Timeline.Impl.Milestone

  @type t :: %__MODULE__{
    id: String.t,
    title: String.t,
    start: DateTime.t,
    status: Type.status,
    completion_date: DateTime.t,
    milestones: list(Milestone.t)
  }

  defstruct(
    id: UUID.uuid4(:hex),
    title: "Please update the title for this Goal",
    start: nil,
    status: :not_started,
    completion_date: nil,
    milestones: []
  )

  @spec new_goal(map()) :: t
  def new_goal(goal_init) do
    struct(%__MODULE__{}, goal_init)
  end

  @spec update_goal(t, map()) :: t
  def update_goal(goal, goal_updates) do
    struct(goal, goal_updates)
  end

  @spec start_goal(t, DateTime.t) :: t
  def start_goal(goal, start_date \\ DateTime.utc_now()) do
    struct(goal, %{start: start_date, status: :in_progress})
  end


  @spec add_milestone(t, pid) :: t
  def add_milestone(goal, milestone) do
    struct(goal, milestones: add_to_milestones(goal.milestones, milestone))
  end

  # def add_step(goal, {milestone, step}) do

  #   struct(goal, )

  #   # update_in(get_milestone_by_id(goal, milestone),fn x -> x end ))
  # end

  @spec delete_milestone(t, Milestone.t) :: t
  def delete_milestone(goal, milestone) do
    struct(goal, milestones: List.delete(goal.milestones, milestone))
  end

  @spec get_milestone_by_id(t, Milestone.t) :: Milestone.t
  def get_milestone_by_id(timeline, milestone_id) do
    Enum.find(timeline.milestones, fn x -> x.id == milestone_id end)
  end

  ##############################PRIVATE FUNCTIONS############################################

  defp add_to_milestones(milestone_list, milestone) do
    [milestone | milestone_list]
  end
end
