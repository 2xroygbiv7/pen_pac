class Invoice < ApplicationRecord
  # self.primary_key = 'invoice_id' #can't be primary as not unique
  belongs_to :customer, class_name: 'Customer', foreign_key: 'customer_id'

  # scope :by_customer, ->(customer_id) { where("customer_id = ?", customer_id }
end
