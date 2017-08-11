class FlexStruct
  # Wraps a FlexStruct initializer to freeze the struct instance after creation.
  module Frozen
    def initialize(*)
      super
      freeze
    end
  end
end
