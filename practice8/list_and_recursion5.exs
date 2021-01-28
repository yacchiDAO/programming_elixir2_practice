defmodule ListAndRecursion5 do
  def all?([], _func), do: true
  def all?([head | tail], func), do: func.(head) && all?(tail, func)
  def each([], _func), do: :ok
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end
  # NOTE:できなかった...
  # def filter(list, func) do
  #def split
  #def take
end
