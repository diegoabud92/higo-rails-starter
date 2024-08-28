require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_file) { fixture_file_upload('files/valid_invoice.xml', 'text/xml') }
  let(:invalid_file) { fixture_file_upload('files/invalid_invoice.xml', 'text/xml') }

  before do
    sign_in user
  end

  describe "index" do
    it "loads all invoices and renders index" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(assigns(:invoices)).to be_present
    end
  end

  describe "new_upload" do
    it "renders the new upload form" do
      get :new_upload
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST to action upload" do
    context "with valid XML files" do
      it "uses ImportInvoicesJob and redirects with notice" do
        post :upload, params: { files: [valid_file] }
        expect(ImportInvoicesJob).to have_been_enqueued.exactly(:once)
        expect(response).to redirect_to(invoices_path)
        expect(flash[:notice]).to eq("Invoice import jobs have been queued. You will be notified once they are completed.")
      end
    end

    context "with invalid XML files" do
      it "does not enqueue job and redirects with alert" do
        post :upload, params: { files: [invalid_file] }
        expect(ImportInvoicesJob).not_to have_been_enqueued
        expect(response).to redirect_to(new_upload_invoices_path)
        expect(flash[:alert]).to eq("There was an error with the uploaded files.")
      end
    end
  end

  describe "provider_invoices" do
    let(:provider) { create(:provider) }

    context "when provider exists" do
      it "loads provider's invoices and renders view" do
        get :provider_invoices, params: { provider_name: provider.name }
        expect(response).to have_http_status(:ok)
        expect(assigns(:invoices)).to be_present
      end
    end

    context "when provider does not exist" do
      it "redirects to invoices with alert" do
        get :provider_invoices, params: { provider_name: 'Unknown' }
        expect(response).to redirect_to(invoices_path)
        expect(flash[:alert]).to eq("Provider not found.")
      end
    end
  end
end
