lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "asdblock/version"

Gem::Specification.new {|s|
  s.name        = 'asdblock'
  s.version     = AsdBlock::VERSION
  s.licenses    = ['WTFPL']
  s.author      = 'jibi'
  s.email       = 'me@jibi.io'
  s.homepage    = 'http://github.com/jibi/asdblock'
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'Generate an nft configuration to drop all egress traffic to a given AS'
  s.description = '.'
  s.files       = Dir['lib/**/*.rb']
  s.executables = ['asdblock']

  s.add_dependency 'netaddr', '~> 2.0', '>= 2.0.4'
}
