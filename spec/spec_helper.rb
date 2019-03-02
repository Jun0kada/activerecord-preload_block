$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'

Bundler.require

require 'active_record'

ActiveRecord::Base.configurations[:test] = {
  adapter: 'sqlite3',
  database: ':memory:'
}

ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[:test])

class User < ActiveRecord::Base
  has_many :comments
  has_many :posts

  def odd_id?
    id.odd?
  end

  def even_id?
    !odd_id?
  end
end

class Comment < ActiveRecord::Base
  belongs_to :user
end

class Post < ActiveRecord::Base
  belongs_to :user
end

ActiveRecord::Migration.verbose = false
ActiveRecord::MigrationContext.new(File.expand_path("../db/migrate", __FILE__)).up
