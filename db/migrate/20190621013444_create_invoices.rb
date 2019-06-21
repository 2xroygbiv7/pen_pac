class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :invoice_id
      t.string :customer_id
      t.string :order_id
      t.string :item_id
      t.string :order_qty
      t.string :backorder_qty
      t.string :shipped_qty
      t.string :unit_price
      t.string :invoice_price
      t.string :fiscal_year
      t.string :fiscal_month
      t.string :invoice_date
      t.string :sales_person_id
      t.timestamps
    end
  end
end
