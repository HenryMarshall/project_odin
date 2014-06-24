def stock_picker prices
  results = prices.each_with_index.inject(Hash.new(0)) do |best_choice, (iter_buy, idx)|
    max_after_buy = prices[idx..-1].each_with_index.max
    profit = max_after_buy[0] - iter_buy

    if profit > best_choice[:profit]
      {profit: profit, buy_day: idx, sell_day: max_after_buy[1]+idx}
    else
      best_choice
    end
  end

  if results[:profit] == 0
    # should raise error
    "do_not_buy"
  else
    [results[:buy_day],results[:sell_day]]
  end
end

puts stock_picker [20,10,30,10]