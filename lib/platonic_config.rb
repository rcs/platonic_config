require "platonic_config/version"

module PlatonicConfig
  def options
    self.class.options.merge instance_options
  end

  def instance_options
    @options ||= {}
  end

  def configure
    yield self
    self
  end
  alias config configure

  def self.included(base)
    base.extend ClassMethods
  end

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

  def respond_to?(sym)
    if self.class.options.has_key? sym
      true
    else
      super
    end
  end

  def reset_defaults
    @options = {}
  end

  module ClassMethods
    def define_options(options = {})
      @default_options = options
      reset_defaults
    end

    def options
      @options
    end

    def reset_defaults
      @options = @default_options.dup
    end

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

    def respond_to?(sym)
      if @options.has_key? sym
        true
      else
        super
      end
    end

    def configure
      yield self
      self
    end
    alias config configure
  end
end
