class AddColumnSelleingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :selleing, :string, default: 'selling' 
  end
end
