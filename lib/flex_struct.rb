# A drop-in replacement for Struct which adds a more flexible initialize method
class FlexStruct
  autoload :VERSION, "flex_struct/version"

  def self.new(*args, &block)
    Struct.new(*args) do
      module_eval(&block) if block

      def initialize(*args, **kwargs)
        super(*args)
        kwargs.each { |key, val| self[key] = val }
        yield self if block_given?
      end
    end
  end
end
