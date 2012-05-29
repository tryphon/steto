require 'logger'
require 'parallel'

module Steto
  class Engine
    attr_reader :checks, :reporters

    def initialize
      @checks = []
      @reporters = []
    end

    def config(&block)
      @config ||= Config.new(self)
      @config.configure(&block) if block_given?
      @config
    end

    def check
      Parallel.each(checks, :in_threads => 4) do |check|
        begin
          check.check
        rescue => e
          check.status = :unknown
          check.text = e.to_s
        end
      end
      self
    end

    def report(reporter = nil)
      if reporter
        reporter.report(checks)
      else
        reporters.each do |reporter|
          report reporter
        end
      end
      self
    end
  end
end
