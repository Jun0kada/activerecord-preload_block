require 'activerecord-records_on_load'

module ActiveRecord
  module PreloadBlock
    def preload(*args, &block)
      if block
        on_load do |records|
          ActiveRecord::Associations::Preloader.new.instance_exec(records, &block)
        end
      else
        check_if_method_has_arguments!(:preload, args)
      end

      if args.present?
        super(*args)
      else
        clone
      end
    end
  end
end
