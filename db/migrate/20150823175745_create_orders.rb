class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_id
      t.string :name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
