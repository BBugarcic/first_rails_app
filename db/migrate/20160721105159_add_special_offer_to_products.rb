class AddSpecialOfferToProducts < ActiveRecord::Migration
  def change
    add_column :products, :special_offer, :boolean, default: false, null: false
  end
end
