module Steto
  class Config
    attr_accessor :engine

    def initialize(engine)
      @engine = engine
    end

    def configure(&block)
      instance_eval &block
    end

    def check(name, check_class = nil, attributes = {}, &block)
      name = name.to_sym
      check =
        if check_class
          check_class.new attributes.merge(:name => name)
        else
          ProcCheck.new :name => name, &block
        end
      engine.checks << check
    end

    def nagios(name, command, options = {})
      check name, Steto::NagiosCheck, :command => "/usr/lib/nagios/plugins/#{command}", :options => options
    end

    def report(reporter_class = nil, &block)
      reporter =
        if reporter_class
          reporter_class.new
        else
          ProcReporter.new &block
        end
      engine.reporters << reporter
    end
    
  end
end
