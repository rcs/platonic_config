require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end if ENV['COVERAGE']

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'platonic_config'
