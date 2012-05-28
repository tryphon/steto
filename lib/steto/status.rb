module Steto
  class Status < String

    def initialize(value)
      super value.to_s
    end

    %w{ok warning critical unknown}.each do |state|
      define_method("#{state}?") do 
        to_s == state
      end
    end

    def nok?
      not ok?
    end

  end
end
