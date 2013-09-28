class StockSerializer < ActiveModel::Serializer

  attributes :name, :company_name, :company_code, :summary, :evolution, :lower_price, :higher_price

end
