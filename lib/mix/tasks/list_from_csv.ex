defmodule Mix.Tasks.ListFromCsv do
  use Mix.Task

  @shortdoc "Run task that lists transactions from csv"
  def run(_) do
    Budget.list_transactions
  end
end
