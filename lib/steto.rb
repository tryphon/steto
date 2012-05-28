require "steto/version"

module Steto

  def self.default_engine
    @default_engine ||= Engine.new
  end

  def self.config(&block)
    default_engine.config(&block)
  end
end

require 'steto/cocaine_ext'

require 'steto/status'
require 'steto/base_check'
require 'steto/nagios_check'
require 'steto/proc_check'

require 'steto/proc_reporter'
require 'steto/logger_reporter'
require 'steto/beep_reporter'

require 'steto/engine'
require 'steto/config'
