defmodule Portal do
  defstruct [:left, :right]

  @doc """
  Starts tranfering `data` from `left` to `right`.
  """
  def transfer(left, right, data) do
    # First add all data to the portal on left
    for item <- data do
      Portal.Door.push(left, item)
    end

    # Returns a portal struct we will use
    %Portal{left: left, right: right}
  end

  @doc """
  Pushes data to the right in given `portal`.
  """
  def push_right(portal) do
    # Check if we can pop data from left.
    # if so, push the popped data to the right
    # or do nothing
    case Portal.Door.pop(portal.left) do
      :error -> :ok
      {:ok, h} -> Portal.Door.push(portal.right, h)
    end
    # Return the portal itself
    portal
  end
end

defimpl Inspect, for: Portal do
  def inspect(%Portal{left: left, right: right}, _) do
    left_door = inspect(left)
    right_door = inspect(right)

    left_data = inspect(Enum.reverse(Portal.Door.get(left)))
    right_data = inspect((Portal.Door.get(right)))

    max = max(String.length(left_door), String.length(left_data))

    """
    #Portal<
      #{String.pad_leading(left_door, max)} <=> #{right_door}
      #{String.pad_leading(left_data, max)} <=> #{right_data}
    >
    """
  end
end
