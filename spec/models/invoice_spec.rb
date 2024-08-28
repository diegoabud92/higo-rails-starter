require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it "is valid with valid attributes" do
    invoice = Invoice.new(uuid: "12345", amount: 1000.0, provider_name: "Provider A", issue_date: "2023-01-01", due_date: "2023-02-01")
    expect(invoice).to be_valid
  end

  it "is not valid without a UUID" do
    invoice = Invoice.new(amount: 1000.0, provider_name: "Provider A", issue_date: "2023-01-01", due_date: "2023-02-01")
    expect(invoice).to_not be_valid
  end
end
