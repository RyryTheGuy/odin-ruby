# Stock Picker Mini-Project

def stock_picker(stocks)
  days_to_buy = [stocks[0], nil]
  max_profit = 0

  # Loop through the stocks array for the min price
  stocks.each_with_index do |min_price, min_index|
    # Only continue if the next price is the new lowest
    if min_price <= days_to_buy[0]
      # Loop through the stocks array again to find the max price 
      stocks.each_with_index do |max_price, max_index|
        # Make sure the "max price" is ahead of the min price
        if max_index > min_index
          # Calculate the profit
          profit = max_price - min_price
          # Only keep the days of the best profit
          if profit > max_profit
            max_profit = profit
            days_to_buy = [min_index, max_index]
          end
        end
      end
    end
  end
  # Return the days to buy array
  days_to_buy
end

p stock_picker([17,3,6,9,15,8,6,3,10])