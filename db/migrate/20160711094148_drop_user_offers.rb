class DropUserOffers < ActiveRecord::Migration
  def up
    drop_table :user_offers
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
