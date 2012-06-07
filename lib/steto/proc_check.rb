module Steto
  class ProcCheck < BaseCheck

    attr_accessor :block

    def initialize(attributes = {}, &block)
      self.attributes = attributes
      self.block = block
    end

    def check
      self.status = status_from_response(block.call)
    end

    def status_from_response(response)
      case response
      when Steto::Status
        response
      when Symbol
        Status.new(response)
      when true
        Status.new(:ok)
      when false
        Status.new(:critical)
      when nil
        Status.new(:unknown)
      end
    end

  end
end
