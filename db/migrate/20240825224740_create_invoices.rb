class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.string :uuid
      t.integer :amount_cents
      t.string :currency_code
      t.date :emitted_at
      t.date :expires_at
      t.references :provider, foreign_key: true

      t.timestamps
    end
  end
end