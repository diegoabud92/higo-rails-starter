require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #provider_invoices" do
    it "returns invoices for the specified provider" do
      provider = "Provider A"
      invoice = Invoice.create!(uuid: "12345", amount: 1000.0, provider_name: provider, issue_date: "2023-01-01", due_date: "2023-02-01")
      get :provider_invoices, params: { provider_name: provider }
      expect(assigns(:invoices)).to eq([invoice])
    end
  end
end