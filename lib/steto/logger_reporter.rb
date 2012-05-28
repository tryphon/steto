module Steto
  class LoggerReporter
    attr_accessor :logger

    def logger
      @logger ||= Logger.new($stderr)
    end

    def report(checks)
      checks.each do |check|
        level = 
          case check.status
          when "warning"
            :warn 
          when /critical|unknown/
            :error
          else
            :debug
          end

        message = "#{check.name} is #{check.status}"
        message += ": #{check.text}" if check.text

        logger.send level, message
      end
    end
  end
end
