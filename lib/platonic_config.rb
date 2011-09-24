require "platonic_config/version"

module PlatonicConfig
  OPTIONS = [:color, :size]

  attr_writer *OPTIONS

  OPTIONS.each do |opt|
    define_method opt do
      instance_variable_get("@#{opt}") || self.class.send(opt)
    end
  end

  def options
    options = {}
    OPTIONS.each{ |k| options[k] = send(k) || self.class.send(k) }
    options
  end

  def configure
    yield self
    self
  end
  alias config configure

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessor *OPTIONS

    def options
      options = {}
      OPTIONS.each{ |k| options[k] = send(k) }
      options
    end

    def configure
      yield self
      self
    end
    alias config configure
  end
end
