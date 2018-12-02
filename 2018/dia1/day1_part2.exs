defmodule Day1 do
  def repeated_frequency(file_stream) do
    file_stream
    |> String.split("\n", trim: true)
    |> Stream.map(fn line ->
      {integer, _leftover} = Integer.parse(line)
      integer
    end)
    |> Stream.cycle()
    |> Enum.reduce_while({0, []}, fn x, {current_frequency, seen_frequencies} ->
      new_frequency = current_frequency + x

      if new_frequency in seen_frequencies do
        {:halt, new_frequency}
      else
        {:cont, {new_frequency, [new_frequency | seen_frequencies]}}
      end
    end)
  end
end

case System.argv() do
  ["--test"] ->
    ExUnit.start()

    defmodule Day1Test do
      use ExUnit.Case

      import Day1

      test "repeated_frequency" do
        assert repeated_frequency("""
               +1
               +1
               +1
               """) == 3
      end
    end

  [input_file] ->
    input_file
    |> File.read!()
    |> Day1.repeated_frequency()
    |> IO.puts()

  _ ->
    IO.puts(:stderr, "We expected --test or an input file")
    System.halt(1)
end
