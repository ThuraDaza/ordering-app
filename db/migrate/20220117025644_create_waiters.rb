class CreateWaiters < ActiveRecord::Migration[6.1]
  def change
    create_table :waiters do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.text :address
      t.date :birthday

      t.timestamps
    end
  end
end
