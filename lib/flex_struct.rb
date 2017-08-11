# A drop-in replacement for Struct which adds a more flexible initialize method
class FlexStruct
  autoload :VERSION, "flex_struct/version"
  autoload :Frozen, "flex_struct/frozen"
  autoload :Initializer, "flex_struct/initializer"

  def self.new(*args, &block)
    Struct.new(*args) do
      module_eval(&block) if block

      # Insert our `initialize` method into the ancestors chain so it can be
      # overridden by `block` if necessary
      include Initializer
    end
  end
end
