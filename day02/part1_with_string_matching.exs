defmodule Part1WithStringMatching do
  @moduledoc """
  A much cleaner solution to part 1
  """

  def run() do
    {:ok, input} = File.read("input.txt")

    %{depth: depth, horizontal: horizontal} =
      input
      |> String.split("\n")
      |> solve()
      |> IO.inspect()

    IO.inspect(depth * horizontal)
  end

  defp solve(lines) do
    Enum.reduce(lines, %{depth: 0, horizontal: 0}, fn curr_str, %{depth: depth, horizontal: horizontal} = state ->
      case curr_str do
        "forward " <> num -> %{state | horizontal: horizontal + parse(num)}
        "up " <> num -> %{state | depth: depth - parse(num)}
        "down " <> num -> %{state | depth: depth + parse(num)}
      end
    end)
  end

  @doc """
  Parses a string to an integer.
  """
  defp parse(str) do
    {number, ""} = Integer.parse(str)
    number
  end
end

Part1WithStringMatching.run()
