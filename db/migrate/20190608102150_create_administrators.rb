class CreateAdministrators < ActiveRecord::Migration[5.2]
  def change
    create_table :administrators do |t|
      t.string :email
      t.string :email_for_index, unique: true
      t.string :hashed_password
      t.boolean :suspended

      t.timestamps
    end
  end
end
