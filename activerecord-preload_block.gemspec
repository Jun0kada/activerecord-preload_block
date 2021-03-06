lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord/preload_block/version'

Gem::Specification.new do |spec|
  spec.name          = 'activerecord-preload_block'
  spec.version       = Activerecord::PreloadBlock::VERSION
  spec.authors       = ['Jun0kada']
  spec.email         = ['jun.0kada.dev@gmail.com']

  spec.summary       = 'ActiveRecord::QueryMethods#preload blockable extenstion'
  spec.description   = 'You can use for STI, polymorphic and custom preload'
  spec.homepage      = 'https://github.com/Jun0kada/activerecord-preload_block'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 4.1.0'
  spec.add_dependency 'activerecord-records_on_load', '>= 0.1.6'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3.6'
end
