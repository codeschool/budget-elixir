defmodule Budget do

  alias NimbleCSV.RFC4180, as: CSV

  def list_transactions do
    case File.read("lib/transactions-jan.csv") do
      {:ok, content} -> parse(content) 
        |> filter
        |> normalize
        |> sort
        |> print
      {:error, _ } -> IO.puts "Error reading file"
    end
  end

  defp parse(string) do
    CSV.parse_string(string)
  end

  # ignores first row since we don't need it
  defp filter(rows) do
    Stream.map(rows, fn(row) -> Enum.slice(row, 1, 3) end)
  end

  defp normalize(rows) do
    Stream.map(rows, &(parse_amount(&1)))
  end

  defp parse_amount([date, description, amount]) do
    [date, description, parse_to_number(amount)]
  end

  # converts amount in weird string
  # format used by the bank to number
  defp parse_to_number(string) do
    Float.parse(string)
    |> elem(0)
    |> abs
  end

  defp sort(rows) do
    Enum.sort(rows, &order_asc_by_amount/2)
  end
  
  defp order_asc_by_amount([_, _, prev], [_, _, next]) do
    prev < next
  end

  defp print(rows) do
    IO.puts "\nTransactions:"
    Stream.map(rows, &row_to_string/1)
    |> Enum.to_list
  end

  defp row_to_string([date, description, amount]) do
    # using :erlang.float_to_binary to convert 1.0e3 to 1000.00
    IO.puts "#{date} #{description} $#{:erlang.float_to_binary(amount, decimals: 2)}"
  end
end
