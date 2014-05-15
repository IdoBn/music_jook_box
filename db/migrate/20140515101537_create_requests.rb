class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :author
      t.integer :party_id
      t.boolean :played, default: :false
      t.string :thumbnail
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
