module Steto
  class BaseCheck
    attr_accessor :name

    def attributes=(attributes = {})
      attributes.each { |k,v| send "#{k}=", v }
    end

    def check_if_needed
      check unless @status
    end

    def status
      check_if_needed
      @status
    end

    def status=(status)
      @status = Status.new status
    end

    attr_accessor :text
    def text
      check_if_needed
      @text
    end
  end
end
