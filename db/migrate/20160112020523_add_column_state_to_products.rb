class AddColumnStateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :state, :string,default: 'in_draft'
  end
end
