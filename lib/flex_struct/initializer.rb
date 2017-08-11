class FlexStruct
  # FlexStruct's initializer adds two alternate ways to initialize a Struct
  module Initializer
    def initialize(*args, **kwargs)
      super(*args)
      kwargs.each { |key, val| self[key] = val }
      yield self if block_given?
    end
  end
end
