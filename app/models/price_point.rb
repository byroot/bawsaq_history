class PricePoint < ActiveRecord::Base
  belongs_to :stock, inverse_of: :price_points

  def self.most_recent
    where(id: select('MAX(id) as id').group(:stock_id).map(&:id))
  end

  def self.import(stocks)
    previous_prices = most_recent.includes(:stock).index_by{ |pp| pp.stock.company_code }
    stocks.each do |remote_stock|
      previous = previous_prices[remote_stock.company_code]
      if !previous || (remote_stock.current_price && previous.price != remote_stock.current_price)
        import_price!(remote_stock, previous.try(:stock))
      end
    end
  end

  def self.import_price!(remote_stock, stock=nil)
    stock ||= Stock.find_by_company_code!(remote_stock.company_code)
    stock.price_points.create!(price: remote_stock.current_price)
  end

end
