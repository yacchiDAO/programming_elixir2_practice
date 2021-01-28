defmodule ListAndRecursion8 do
  defp total_amount(net_amount, tax_rate) when tax_rate == nil, do: net_amount
  defp total_amount(net_amount, tax_rate), do: net_amount * (1.0 + tax_rate)

  def calc_total_amount(orders, tax_rates) do
    for x <- orders,
      do: x ++ [ total_amount: total_amount(x[:net_amount], tax_rates[x[:ship_to]]) ]
  end
end

tax_rates = [ NC: 0.075, TX: 0.08 ]

orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount: 35.50 ],
  [ id: 125, ship_to: :TX, net_amount: 24.00 ],
  [ id: 126, ship_to: :TX, net_amount: 44.00 ],
  [ id: 127, ship_to: :NC, net_amount: 25.00 ],
  [ id: 128, ship_to: :MA, net_amount: 10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 130, ship_to: :NC, net_amount: 50.00 ],
]

ListAndRecursion8.calc_total_amount(orders, tax_rates)
