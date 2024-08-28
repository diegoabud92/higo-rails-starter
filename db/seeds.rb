# Destroy existent data
Invoice.destroy_all
Provider.destroy_all

# Creates providers
provider1 = Provider.create!(
  uuid: SecureRandom.hex(8),
  name: 'Provider 1'
)

provider2 = Provider.create!(
  uuid: SecureRandom.hex(8),
  name: 'Provider 2'
)

# Creates Invoices linked to the previous providers
Invoice.create!(
  uuid: SecureRandom.hex(8),
  amount_cents: 50000,
  currency_code: 'USD',
  emitted_at: Date.today - 10,
  expires_at: Date.today + 20,
  provider_id: provider1.id
)

Invoice.create!(
  uuid: SecureRandom.hex(8),
  amount_cents: 75000,
  currency_code: 'EUR',
  emitted_at: Date.today - 5,
  expires_at: Date.today + 15,
  provider_id: provider2.id
)

Invoice.create!(
  uuid: SecureRandom.hex(8),
  amount_cents: 100000,
  currency_code: 'MXN',
  emitted_at: Date.today - 2,
  expires_at: Date.today + 30,
  provider_id: provider1.id
)

puts "Seed data created successfully."
