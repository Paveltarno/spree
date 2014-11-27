Spree::Sample.load_sample("variants")

location = Spree::StockLocation.any? ? Spree::StockLocation.first : Spree::StockLocation.new(name: 'סניף ראשי')
location.active = true
location.country = Spree::Country.where(iso: 'IL').first
location.zone = Spree::Zone.first
location.save!

location2 = Spree::StockLocation.new(name: 'סניף משני')
location2.active = true
location2.country = Spree::Country.where(iso: 'IL').first
location2.zone = Spree::Zone.last
location2.save!

Spree::Variant.all.each do |variant|
  variant.stock_items.each do |stock_item|
    Spree::StockMovement.create(:quantity => 10, :stock_item => stock_item)
  end
end
