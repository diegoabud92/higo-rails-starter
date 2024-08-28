class InvoiceImportJob
  include Sidekiq::Worker

  def perform(file_paths)
    file_paths.each do |file_path|
      file = File.open(file_path)
      Invoice.import_from_xml([file])
      file.close
    end
  end
end