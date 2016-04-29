# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'ActiveRecorder'
  spec.version       = '0.1.2'
  spec.authors       = ['Goh Chin Loong']
  spec.email         = ['gohchinloong@gmail.com']

  spec.summary       = 'A Ruby gem which visualizes ActiveRecord tables and rows for Rails apps.'
  spec.description   = 'The gem creates a view, controller and routes to allow Rails developers to see their ActiveRecord tables.'
  spec.homepage      = 'https://rubygems.org/gems/ActiveRecorder'
  spec.license       = 'MIT'
  spec.files         = ['lib/active_recorder.rb',
                        'lib/active_recorder/filewriter.rb',
                        'lib/active_recorder/filereader.rb',
                        'lib/active_recorder/record.rb']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
