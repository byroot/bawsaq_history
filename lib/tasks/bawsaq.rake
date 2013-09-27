require 'bawsaq'

namespace :bawsaq do
  task fetch: :environment do
    PricePoint.import(BAWSAQ.fetch)
  end
end
