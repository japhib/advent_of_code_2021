defmodule SolutionPart2 do
  def run() do
    # input =
    #   """
    #   00100
    #   11110
    #   10110
    #   10111
    #   10101
    #   01111
    #   00111
    #   11100
    #   10000
    #   11001
    #   00010
    #   01010
    #   """
    #   |> String.trim()

    {:ok, input} = File.read("input.txt")

    lines = String.split(input, "\n")

    oxygen =
      find_oxygen_rating(lines) |> IO.inspect(label: "oxygen")

    co2 =
      find_co2_rating(lines) |> IO.inspect(label: "co2")

    (String.to_integer(oxygen, 2) * String.to_integer(co2, 2)) |> IO.inspect(label: "answer")
  end

  defp find_oxygen_rating(lines) do
    filter_while(lines, 0, fn ones, zeros -> if ones >= zeros, do: "1", else: "0" end)
  end

  defp find_co2_rating(lines) do
    filter_while(lines, 0, fn ones, zeros -> if zeros <= ones, do: "0", else: "1" end)
  end

  defp filter_while([line], _digit, _filter_fun), do: line

  defp filter_while([_ | _] = lines, digit, filter_fun) do
    counts = get_counts(lines)
    %{ones: ones, zeros: zeros} = Enum.at(counts, digit)
    match_value = filter_fun.(ones, zeros)

    lines
    |> Enum.filter(fn line -> String.at(line, digit) == match_value end)
    |> filter_while(digit + 1, filter_fun)
  end

  defp get_counts([first_line | _rest] = lines) do
    starting_counts =
      first_line
      |> String.graphemes()
      |> Enum.map(fn _ ->
        %{
          ones: 0,
          zeros: 0
        }
      end)

    Enum.reduce(lines, starting_counts, fn
      line, counts ->
        line
        |> String.graphemes()
        |> Enum.zip(counts)
        |> Enum.map(fn
          {"0", %{zeros: zeros} = counts} ->
            %{counts | zeros: zeros + 1}

          {"1", %{ones: ones} = counts} ->
            %{counts | ones: ones + 1}
        end)
    end)
  end
end

SolutionPart2.run()
