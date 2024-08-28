require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:valid_xml) { StringIO.new('<invoice><uuid>123</uuid><amount_cents>1000</amount_cents><currency_code>USD</currency_code><emitted_at>2024-08-28</emitted_at><expires_at>2024-09-28</expires_at><provider><name>Provider 1</name><uuid>provider-uuid-1</uuid></provider></invoice>') }
  let(:invalid_xml) { StringIO.new('<invalid><xml></xml>') }
  let(:user) { create(:user) }

  describe '.import_from_xml' do
    context 'with valid XML data' do
      it 'imports invoice successfully' do
        expect {
          Invoice.import_from_xml(valid_xml, user.id)
        }.to change { Invoice.count }.by(1)
      end
    end

    context 'with invalid XML data' do
      it 'does not import invoice and raises error' do
        errors = Invoice.import_from_xml(invalid_xml, user.id)
        expect(errors).not_to be_empty
        expect(Invoice.count).to eq(0)
      end
    end
  end
end
