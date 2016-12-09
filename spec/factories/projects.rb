FactoryGirl.define do
  factory :project do
    sequence(:name)  { |n| "Project #{n}" }
    client "Tabajara"
    description "MyText"
  end
end
