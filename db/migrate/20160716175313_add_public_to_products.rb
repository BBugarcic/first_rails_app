class AddPublicToProducts < ActiveRecord::Migration
  def change
    add_column :products, :public, :boolean, default: false, null: false
  end
end
