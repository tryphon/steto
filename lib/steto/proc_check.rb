module Steto
  class ProcCheck < BaseCheck

    def initialize(attributes = {}, &block)
      self.attributes = attributes
      @block = block
    end

    def check
      self.status = @block.call
    end
  end
end
