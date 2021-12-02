{:ok, input} = File.read("input.txt")
lines = String.split(input, "\n")

%{depth: depth, horizontal: horizontal} =
  Enum.reduce(lines, %{depth: 0, horizontal: 0}, fn curr_str,
                                                    %{depth: depth, horizontal: horizontal} =
                                                      state ->
    [command, number_str] = String.split(curr_str)
    {number, ""} = Integer.parse(number_str)

    case command do
      "forward" -> %{state | horizontal: horizontal + number}
      "up" -> %{state | depth: depth - number}
      "down" -> %{state | depth: depth + number}
    end
  end)
  |> IO.inspect()

IO.inspect(depth * horizontal)
