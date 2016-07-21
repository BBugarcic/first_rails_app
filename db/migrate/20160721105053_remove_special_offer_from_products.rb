class RemoveSpecialOfferFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :special_offer, :boolean
  end
end
