class CreateUserOffers < ActiveRecord::Migration
  def change
    create_table :user_offers do |t|
      t.string :name
      t.string :category
      t.text :description
      t.string :color
      t.float :price

      t.timestamps null: false
    end
  end
end
