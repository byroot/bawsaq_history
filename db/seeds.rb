require 'yaml'

stocks = YAML.load_file(Rails.root.join('spec', 'fixtures', 'stocks.yml'))
Stock.create(stocks.values)
