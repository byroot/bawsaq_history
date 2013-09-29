class StockSerializer < ActiveModel::Serializer

  attributes :name, :company_name, :company_code, :summary, :lower_price, :higher_price, :relative_price, :evolution

end
