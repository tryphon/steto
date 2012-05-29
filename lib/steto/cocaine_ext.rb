require 'cocaine/command_line'

module Cocaine
  class CommandLine

    attr_reader :exit_status

    alias_method :run_without_exit_status, :run
    def run_with_exit_status
      begin
        run_without_exit_status
      ensure
        @exit_status = $?.exitstatus if $?
      end
    end
    alias_method :run, :run_with_exit_status

  end
end
