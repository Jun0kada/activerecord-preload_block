class CreatePostsTable < (ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration)
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :body
    end
  end
end
