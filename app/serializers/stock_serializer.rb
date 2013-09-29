class StockSerializer < ActiveModel::Serializer

  attributes :name, :company_name, :company_code, :summary, :lower_price, :higher_price, :absolute_growth, :max_growth, :evolution

end
