class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :stars
      t.text :post
      t.datetime :datetime
      t.integer :user_id
      t.integer :doctor_id
    end
  end
end
