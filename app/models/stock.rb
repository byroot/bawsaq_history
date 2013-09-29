class Stock < ActiveRecord::Base
  has_many :price_points, inverse_of: :stock, order: 'id asc'

  class Snapshot

    attr_reader :price_point, :previous

    def initialize(price_point, previous=nil)
      @price_point = price_point
      @previous = previous
    end

    delegate :price, :stock, to: :price_point
    delegate :lower_price, :higher_price, to: :stock, prefix: true

    def growth
      return 0 unless previous
      diff = price - previous.price
      diff / previous.price * 100.0
    end

    def absolute_growth
      diff = price - stock_lower_price
      diff / stock_lower_price * 100.0
    end

    def as_json
      {
        at: price_point.created_at,
        price: price,
        growth: growth,
        absolute_growth: absolute_growth
      }
    end

  end

  def evolution
    snapshots = []
    price_points.each_with_object(snapshots) do |price_point, list|
      list << Snapshot.new(price_point, list.last)
    end
    snapshots.map(&:as_json)
  end

  def absolute_growth
    diff = higher_price - lower_price
    diff / lower_price * 100.0
  end

  def max_growth
    Snapshot.new(price_points.last).absolute_growth
  end

  def lower_price
    @lower_price ||= price_points.map(&:price).min
  end

  def higher_price
    @higher_price ||= price_points.map(&:price).max
  end

end
