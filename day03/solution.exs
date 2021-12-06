# input = """
# 00100
# 11110
# 10110
# 10111
# 10101
# 01111
# 00111
# 11100
# 10000
# 11001
# 00010
# 01010
# """

{:ok, input} = File.read("input.txt")
lines = [first_line | _rest] = String.split(input, "\n")

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
  # skip empty string
  "", counts ->
    counts

  # regular logic
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
|> IO.inspect()
|> Enum.reduce({"", ""}, fn %{ones: ones, zeros: zeros}, {gamma, epsilon} ->
  if ones == zeros, do: raise "counts are equal!"

  gamma = if ones > zeros, do: gamma <> "1", else: gamma <> "0"
  epsilon = if zeros > ones, do: epsilon <> "1", else: epsilon <> "0"

  {gamma, epsilon}
end)
|> IO.inspect()
|> then(fn {gamma, epsilon} ->
  String.to_integer(gamma, 2) * String.to_integer(epsilon, 2)
end)
|> IO.inspect()
