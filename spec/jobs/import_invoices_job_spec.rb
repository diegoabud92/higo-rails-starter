require 'rails_helper'

RSpec.describe ImportInvoicesJob, type: :job do
  let(:user) { create(:user) }
  let(:file_path) { Rails.root.join('tmp', 'test_invoice.xml') }

  before do
    File.write(file_path, file_fixture('valid_invoice.xml').read)
  end

  after do
    File.delete(file_path) if File.exist?(file_path)
  end

  it "processes invoice file successfully" do
    expect { ImportInvoicesJob.perform_now(file_path, user.id) }.to change(Invoice, :count).by(1)
  end

  it "handles errors without raising exception" do
    allow(Invoice).to receive(:import_from_xml).and_raise(StandardError)
    expect { ImportInvoicesJob.perform_now(file_path, user.id) }.not_to raise_error
  end
end
