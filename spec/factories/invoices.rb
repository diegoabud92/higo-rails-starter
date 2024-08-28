FactoryBot.define do
  factory :invoice do
    uuid { "MyString" }
    amount { "9.99" }
    provider_name { "MyString" }
    issue_date { "2024-08-24" }
    due_date { "2024-08-24" }
  end
end
