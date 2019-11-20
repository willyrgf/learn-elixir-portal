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
