class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :invoice_id
      t.string :customer_id
      t.string :order_id
      t.string :item_id
      t.integer :order_qty
      t.integer :backorder_qty
      t.integer :shipped_qty
      t.decimal :unit_price, precision: 8, scale: 2
      t.decimal :invoice_price, precision: 8, scale: 2
      t.integer :fiscal_year
      t.integer :fiscal_month
      t.date :invoice_date
      t.string :sales_person_id
      t.timestamps
    end
  end
end
