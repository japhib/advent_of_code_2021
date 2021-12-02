{:ok, input} = File.read("input.txt")
lines = String.split(input, "\n")

IO.inspect(lines)
IO.puts("lines: #{inspect(length(lines))}")

Enum.reduce(lines, %{previous: 99999, times_increased: 0}, fn curr_str,
                                                              %{
                                                                previous: previous,
                                                                times_increased: times_increased
                                                              } ->
  {curr_num, ""} = Integer.parse(curr_str)

  %{
    previous: curr_num,
    times_increased: if(curr_num > previous, do: times_increased + 1, else: times_increased)
  }
end)
|> IO.inspect()
