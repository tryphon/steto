require 'cocaine'

module Steto
  class NagiosCheck < BaseCheck

    attr_accessor :command, :options
    
    def initialize(attributes = {})
      self.command = ""
      self.options = {}
      self.attributes = attributes
    end

    def check
      self.text = command_line.run.chomp
      self.status = status_from_command_line
    end

    def command_line
      # => "--critical=:critical --warning=:warning"
      params = options.map do |option, value| 
        unless option.to_s.size == 1
          cli_option = option.to_s.gsub("_","-")
          unless value == true
            "--#{cli_option}=:#{option}"
          else
            "--#{cli_option}"
          end
        else
          unless value == true
            "-#{option} :#{option}"
          else
            "-#{option}"
          end
        end
      end.sort.join(' ')

      command_options = Hash[options.map { |k,v| [ k, v.to_s ] }]

      @command_line ||= Cocaine::CommandLine.new(command, params, command_options.merge(:expected_outcodes => [0, 1, 2, 3]))
    end

    def status_from_command_line
      case command_line.exit_status
      when 0
        :ok
      when 1
        :warning
      when 2
        :critical
      else
        :unknown
      end
    end

  end
end
