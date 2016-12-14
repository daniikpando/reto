class AddAttachementVideoToProducts < ActiveRecord::Migration
  def change
      add_attachment :products, :video
  end
end
