class Customer < ApplicationRecord
  self.primary_key = 'customer_id'
  has_many :invoices, primary_key: :customer_id
end
