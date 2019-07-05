class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :customer_id
      t.string :customer_name
      t.string :group_id
      t.string :city
      t.string :state
      t.string :postcode
      t.string :pricelist
      t.date :start_date
      t.timestamps
    end
  end
end
