require 'activerecord-records_on_load'

module ActiveRecord
  module PreloadBlock
    def preload(*args, &block)
      check_if_method_has_arguments!(:preload, args) unless block
      spawn.preload!(*args, &block)
    end

    def preload!(*args, &block)
      self.preload_values += args if args.present?

      if block
        on_load! do |records|
          ActiveRecord::Associations::Preloader.new.instance_exec(records, &block)
        end
      end

      self
    end
  end
end
