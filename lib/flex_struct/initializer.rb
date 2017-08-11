class FlexStruct
  # FlexStruct's initializer adds two alternate ways to initialize a Struct
  #
  # This violates :reek:ModuleInitialize because Reek doesn't want a module to
  # be initialized - however here we're specifically including this into the
  # ancestor chain
  module Initializer
    def initialize(*args, **kwargs)
      super(*args)
      kwargs.each { |key, val| self[key] = val }
      yield self if block_given?
    end
  end
end
