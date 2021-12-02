{:ok, input} = File.read("input.txt")
lines = String.split(input, "\n")

%{depth: depth, horizontal: horizontal} =
  Enum.reduce(lines, %{depth: 0, horizontal: 0, aim: 0}, fn curr_str,
                                                            %{
                                                              depth: depth,
                                                              horizontal: horizontal,
                                                              aim: aim
                                                            } = state ->
    [command, number_str] = String.split(curr_str)
    {number, ""} = Integer.parse(number_str)

    case command do
      "forward" -> %{state | horizontal: horizontal + number, depth: depth + number * aim}
      "up" -> %{state | aim: aim - number}
      "down" -> %{state | aim: aim + number}
    end
  end)
  |> IO.inspect()

IO.inspect(depth * horizontal)
