class Stock < ActiveRecord::Base
  has_many :price_points, inverse_of: :stock
end
