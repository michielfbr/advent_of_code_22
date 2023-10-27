defmodule RangesFullyOverlap do
  @moduledoc false

  def run do
    input_to_data("./input.txt")
    |> filter_overlapping_ranges()
    |> length()
    |> IO.inspect()

    IO.puts(IO.ANSI.format([:red_background, "Done!"]))
  end

  defp input_to_data(file) do
    File.stream!(file)
    # Get each line
    |> Enum.map(fn line ->
      line
      # Trim string
      |> String.trim_trailing("\n")
      # Split string at `,`
      |> String.split(",")
      # Get range of each member of pair
      |> Enum.map(fn range ->
        # Convert range to list of numbers (section to clean)
        [range_start | range_end] =
          range
          |> String.split("-")

        range_start = range_start |> to_string() |> String.to_integer()
        range_end = range_end |> to_string() |> String.to_integer()

        Range.new(range_start, range_end, 1)
      end)
      |> List.to_tuple()
    end)
  end

  defp filter_overlapping_ranges(ranges) do
    # Remove numbers present in both members of pair
    # Count empty lists
    Enum.map(ranges, fn {range1, range2} = range ->
      if (range1.first <= range2.first && range1.last >= range2.last) or
           (range1.first >= range2.first && range1.last <= range2.last) do
        range
      else
        []
      end
    end)
    |> List.flatten()
  end
end

RangesFullyOverlap.run()
