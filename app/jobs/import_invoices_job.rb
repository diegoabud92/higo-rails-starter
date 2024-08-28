class ImportInvoicesJob < ApplicationJob
  queue_as :default

  def perform(file_path, user_id)
    File.open(file_path, 'r') do |file|
      Invoice.import_from_xml(file, user_id)
    end

    File.delete(file_path) if File.exist?(file_path)
  end
end
