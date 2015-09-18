Bundler.setup
Bundler.require :test

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'interval_tree'
