require 'rails_helper'

RSpec.describe "Providers", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/providers/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/providers/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/providers/show"
      expect(response).to have_http_status(:success)
    end
  end

end
