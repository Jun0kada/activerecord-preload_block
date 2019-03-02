class CreateCommentsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string :body
    end
  end
end
