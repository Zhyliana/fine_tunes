class AddBodyColumn < ActiveRecord::Migration
  def change
    add_column :notes, :body, :text
  end
end
