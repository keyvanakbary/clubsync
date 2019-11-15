defmodule Clubsync.Store.Model.DateTime do
  def normalize(nil), do: nil

  def normalize(datetime), do: DateTime.truncate(datetime, :second)
end
