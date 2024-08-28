class Invoice < ApplicationRecord
  belongs_to :provider

  def amount
    amount_cents / 100.0
  end

  def self.import_from_xml(files)
    processed_count = 0
    invoices_imported = 0
    errors = []
  
    files.each do |file|
      begin
        invoices_data = Hash.from_xml(file.read)
        
        if invoices_data && invoices_data["invoice"]
          invoice_data = invoices_data["invoice"]
  
          if invoice_data.is_a?(Hash) && invoice_data["uuid"].present? && invoice_data["amount_cents"].present?
            invoice = Invoice.new(
              uuid: invoice_data["uuid"],
              amount_cents: invoice_data["amount_cents"],
              currency_code: invoice_data["currency_code"],
              emitted_at: invoice_data["emitted_at"],
              expires_at: invoice_data["expires_at"]
            )
  
            provider_data = invoice_data["provider"]
            if provider_data.is_a?(Hash) && provider_data["name"].present? && provider_data["uuid"].present?
              provider = Provider.find_or_create_by(
                name: provider_data["name"],
                uuid: provider_data["uuid"]
              )
              invoice.provider = provider
  
              if invoice.save
                invoices_imported += 1
              else
                errors << "Invoice with UUID #{invoice_data['uuid']} failed: #{invoice.errors.full_messages.join(', ')}"
              end
            else
              errors << "Invalid provider data in file #{file.original_filename}"
            end
          else
            errors << "Invalid invoice data in file #{file.original_filename}"
          end
        else
          errors << "File #{file.original_filename} does not contain valid invoice data or is missing required nodes."
        end
  
        processed_count += 1
      rescue StandardError => e
        errors << "Error processing file #{file.original_filename}: #{e.message}"
      end
    end
  
    { imported: invoices_imported, processed: processed_count, errors: errors }
  end
end
