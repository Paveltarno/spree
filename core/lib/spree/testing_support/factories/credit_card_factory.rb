FactoryGirl.define do
  factory :credit_card, class: Spree::CreditCard do
    verification_value 123
    month 12
    year { 1.year.from_now.year }
    number '4111111111111111'
    name 'Spree Commerce'
  end
end
