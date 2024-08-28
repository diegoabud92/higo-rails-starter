class Invoice < ApplicationRecord
  belongs_to :provider
  belongs_to :user

  def amount
    amount_cents / 100.0
  end

  def self.import_from_xml(file, user_id)
    errors = []

    begin
      invoices_data = Hash.from_xml(file.read)
      file_name = file.respond_to?(:original_filename) ? file.original_filename : "unknown"

      if invoices_data && invoices_data["invoice"]
        invoice_data = invoices_data["invoice"]
        
        invoice = Invoice.new(
          uuid: invoice_data["uuid"],
          amount_cents: invoice_data["amount_cents"],
          currency_code: invoice_data["currency_code"],
          emitted_at: invoice_data["emitted_at"],
          expires_at: invoice_data["expires_at"],
          user_id: user_id
        )

        provider_data = invoice_data["provider"]
        provider = Provider.find_or_create_by(
          name: provider_data["name"],
          uuid: provider_data["uuid"]
        )

        invoice.provider = provider

        unless invoice.save
          errors << "Invoice with UUID #{invoice_data['uuid']} failed: #{invoice.errors.full_messages.join(', ')}"
        end
      else
        errors << "File #{file_name} does not contain valid invoice data or is missing required nodes."
      end
    rescue StandardError => e
      errors << "Error processing file #{file_name}: #{e.message}"
    end

    errors
  end  
end
