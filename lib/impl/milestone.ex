defmodule Timeline.Impl.Milestone do

  alias Timeline.Impl.Step
  alias Timeline.Type

  @type t :: %__MODULE__{
    id: String.t,
    title: String.t,
    start: DateTime.t,
    status: Type.status,
    completion_date: DateTime.t,
    steps: list(Step.t)
  }

  defstruct(
    id: UUID.uuid4(:hex),
    title: "Please update the title for this Milestone",
    start: DateTime.utc_now(),
    status: :not_started,
    completion_date: nil,
    steps: []
  )

  @spec new_milestone(map()) :: t
  def new_milestone(milestone_init) do
    struct(%__MODULE__{}, Map.put(milestone_init, :id, UUID.uuid4(:hex)))
  end

  @spec update_milestone(t, map) :: t
  def update_milestone( milestone, milestone_updates) do
    struct(milestone, milestone_updates)
  end

  @spec add_step(t, pid) :: t
  def add_step(milestone, step) do
    struct(milestone, steps: [step | milestone.steps])
  end

  ##############################PRIVATE FUNCTIONS############################################


end
