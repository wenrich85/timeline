defmodule Timeline.Impl.Step do

  alias Timeline.Type

  @type t :: %__MODULE__{
    id: String.t,
    title: String.t,
    description: String.t,
    notes: String.t,
    status: Type.status(),
    order: integer
  }

  defstruct(
    id: UUID.uuid4(:hex),
    title: "Please update your title",
    description: "Please describe what you need to accomplish",
    notes: "",
    status: :not_started,
    order: 0
  )

  @spec new(map()) :: t
  def new(item_init) do
    struct(%__MODULE__{}, item_init)
  end

  @spec update(t, map()) :: t
  def update(step, updates) do
    struct(step, updates)
  end

end
