require "platonic_config/version"


module PlatonicConfig

  # Give the options defined on the instance merged with the class-level defaults
  def options
    self.class.options.merge instance_options
  end

  # return just the options set on the instance
  def instance_options
    @options ||= {}
  end

  # convenience method to allow for block level configuration
  def configure
    yield self
    self
  end
  alias config configure

  # Set up configuration methodss on the base class
  def self.included(base)
    base.extend ClassMethods
  end

  # Allow calls directly on the object to configuration keys
  # Ex: define_options :foo => bar
  # instance.foo
  def method_missing(sym,*args,&block)
    if self.class.options.has_key? sym
      if args.length == 1
        instance_options[sym] = args[0]
      end
      options[sym]
    else
      super
    end
  end

  # Let respond_to? answer for symbols defined in the options
  def respond_to?(sym)
    if self.class.options.has_key? sym
      true
    else
      super
    end
  end

  # Reset all config values set on the instance
  def reset_defaults
    @options = {}
  end

  module ClassMethods
    # Define the options and defaults for this coniguration
    def define_options(options = {})
      @default_options = options
      reset_defaults
    end

    # return the set of configured options
    def options
      @options
    end

    # set all configured options back to their default values
    def reset_defaults
      @options = @default_options.dup
    end

    # Allow calls directly on the object to configuration keys
    # Ex: define_options :foo => bar
    # Class.foo
    def method_missing(sym,*args,&block)
      if @options.has_key? sym
        if args.length == 1
          @options[sym] = args[0]
        end
        @options[sym]
      else
        super
      end
    end

    # Let respond_to? answer for symbols defined in the options
    def respond_to?(sym)
      if @options.has_key? sym
        true
      else
        super
      end
    end

    # convenience method to allow for block level configuration
    def configure
      yield self
      self
    end
    alias config configure
  end
end
