# Create a single plan
plan_attributes = {
  starting_hour: Date.today.beginning_of_day + 7.hours,
  ending_hour: Date.today.beginning_of_day + 17.hours,
  order_limit: 25,
}

single_plan = Spree::ShipmentTimeSlotSinglePlan.create!(plan_attributes)

# Create a day plan
plan_attributes = {
  name: "יום חול"
}

day_plan = Spree::TimeSlotDayPlan.new(plan_attributes)
day_plan.shipment_time_slot_single_plans << single_plan
day_plan.save!

# Creates plans for each day of the week
for i in 0..5
  plan = Spree::RegularPlan.find_or_create_by(day: i)
  plan.time_slot_day_plan = day_plan
  plan.save!
end