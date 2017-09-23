class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.integer :amount
      t.integer :expiration_month
      t.integer :expiration_year
      t.integer :user_id

      t.timestamps
    end
  end
end
