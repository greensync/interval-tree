# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'augmented_interval_tree'
  s.version     = '0.1.0'
  s.summary     = "A Ruby implementation of the Augmented Interval Tree data structure"
  s.description = <<-END.gsub(/^ {4}/, '')
    A Ruby implementation of the Augmented Interval Tree data structure.
    See also: http://en.wikipedia.org/wiki/Interval_tree
  END
  s.authors     = ["Hiroyuki Mishima", "Simeon Simeonov", "Carlos Alonso"]
  s.email       = ['missy@be.to', 'info@mrcalonso.com']
  s.files       = ["lib/interval_tree.rb"]
  s.homepage    = 'https://github.com/misshie/interval-tree'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec', '~> 2.11'
end
