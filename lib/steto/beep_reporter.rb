module Steto
  class BeepReporter
    def report(checks)
      if checks.any? { |c| c.status.critical? }
        beep 2
      elsif checks.any? { |c| c.status.warning? }
        beep
      end
    end

    def beep(count = 1)
      system "beep -r #{count}"
    end
  end
end
