class AddSurnameInMessages < ActiveRecord::Migration
  def change
    add_column :messages, :surname, :string
  end
end
