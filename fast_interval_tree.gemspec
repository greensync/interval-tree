# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative 'lib/interval_tree/version'

Gem::Specification.new do |s|
  s.name        = 'fast_interval_tree'
  s.version     = IntervalTree::VERSION
  s.summary     = 'A Ruby implementation of the Centered Interval Tree data structure'
  s.description = <<-END.gsub(/^ {4}/, '')
    A Ruby implementation of the Centered Interval Tree data structure.
    See also: http://en.wikipedia.org/wiki/Interval_tree
  END
  s.authors     = ['Hiroyuki Mishima', 'Simeon Simeonov', 'Carlos Alonso', 'Sam Davies', 'Brendan Weibrecht', 'Chris Nankervis', 'Thomas van der Pol']
  s.email       = ['brendan@weibrecht.net.au']
  s.files       = ['lib/interval_tree.rb']
  s.homepage    = 'https://github.com/greensync/interval-tree'
  s.metadata['source_code_uri'] = 'https://github.com/greensync/interval-tree'
  s.license     = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir.glob('{bin,lib}/**/*') + %w[README.md Gemfile Rakefile fast_interval_tree.gemspec]
  end
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec', '~> 3.10'
  s.add_development_dependency 'rake', '~> 13.0.1'
end
