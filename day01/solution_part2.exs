{:ok, input} = File.read("input.txt")
lines = String.split(input, "\n")

IO.inspect(lines)
IO.puts("lines: #{inspect(length(lines))}")

Enum.reduce(lines, %{previous_lines: [], times_increased: 0}, fn curr_str,
                                                                 %{
                                                                   previous_lines: previous_lines,
                                                                   times_increased:
                                                                     times_increased
                                                                 } ->
  {curr_num, ""} = Integer.parse(curr_str)

  case previous_lines do
    [prev1, prev2, prev3] ->
      prev3_sum = prev1 + prev2 + prev3
      curr3_sum = prev2 + prev3 + curr_num

      %{
        previous_lines: [prev2, prev3, curr_num],
        times_increased: if(curr3_sum > prev3_sum, do: times_increased + 1, else: times_increased)
      }

    _ ->
      %{
        previous_lines: previous_lines ++ [curr_num],
        times_increased: times_increased
      }
  end
end)
|> IO.inspect()
