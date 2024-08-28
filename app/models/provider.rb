class Provider < ApplicationRecord
	has_many :invoices, dependent: :destroy
	
end
