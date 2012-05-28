module Steto
  class ProcReporter
    def initialize(&block)
      @block = block
    end

    def report(checks)
      @block.call checks
    end
  end
end
