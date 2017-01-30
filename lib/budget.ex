defmodule Budget do

  alias NimbleCSV.RFC4180, as: CSV

  def list_transactions do
    case File.read("lib/transactions-jan.csv") do
      {:ok, content} -> parse(content) 
        |> filter
        |> normalize
        |> sort
      {:error, _ } -> IO.puts "Error reading file"
    end
  end

  defp parse(string) do
    CSV.parse_string(string)
  end

  defp filter(rows) do
    Enum.map(rows, fn(row) -> Enum.slice(row, 1, 3) end)
  end

  defp normalize(rows) do
    Enum.map(rows, &(parse_amount(&1)))
  end

  defp parse_amount([date, description, amount]) do
    [date, description, parse_to_number(amount)]
  end

  defp parse_to_number(string) do
    Float.parse(string)
    |> elem(0)
    |> abs
  end

  defp sort(rows) do
    Enum.sort(rows, &order_asc_by_amount/2)
  end
  
  defp order_asc_by_amount(prev, next) do
    Enum.at(prev, 2) < Enum.at(next, 2)
  end
end
