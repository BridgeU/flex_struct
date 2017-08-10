require "spec_helper"

RSpec.describe FlexStruct do
  it "has a version number" do
    expect(FlexStruct::VERSION).not_to be nil
  end

  describe ".new" do
    it "returns a class that can be instantiated" do
      klass = described_class.new(:foo, :bar)

      klass.new
    end
  end

  describe "instance" do
    subject do
      # Returns a class object created by Struct
      described_class.new(:foo, :bar, :baz)
    end

    it "can be instantiated with no arguments" do
      struct = subject.new

      expect(struct.foo).to be_nil
      expect(struct.bar).to be_nil
    end

    it "can be initialized with positional arguments" do
      struct = subject.new(123, 456)

      expect(struct.foo).to eq(123)
      expect(struct.bar).to eq(456)
      expect(struct.baz).to be_nil
    end

    it "can be initialized with keyword arguments" do
      struct = subject.new(bar: 456, foo: 123)

      expect(struct.foo).to eq(123)
      expect(struct.bar).to eq(456)
      expect(struct.baz).to be_nil
    end

    it "can be initialized with a block" do
      struct = subject.new do |obj|
        obj.foo = 123
        obj.bar = 456
      end

      expect(struct.foo).to eq(123)
      expect(struct.bar).to eq(456)
      expect(struct.baz).to be_nil
    end

    it "can be initialized with a combination of methods" do
      # but why would you ever do this?
      struct = subject.new(123, bar: 456) do |obj|
        obj.baz = 789
      end

      expect(struct.foo).to eq(123)
      expect(struct.bar).to eq(456)
      expect(struct.baz).to eq(789)
    end
  end
end
