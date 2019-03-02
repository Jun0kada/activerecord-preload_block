require 'activerecord/preload_block/version'
require 'active_record'
require 'active_record/preload_block'

module ActiveRecord
  class Relation
    prepend ActiveRecord::PreloadBlock
  end
end
