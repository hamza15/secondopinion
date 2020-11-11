class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :speciality

      t.timestamps null: false
    end
  end
end
