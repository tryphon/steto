Steto::config do
  register :proc, NagiosCheck, :plugin => "/usr/lib/nagios/plugins/check_procs" do |attributes|
    { :warning => "1:1", :critical => "1:1" }.merge attributes
  end 

  check :proc, :command => "caed"
  check :proc, :command => "rdcatchd"
  check :proc, :command => "ripcd"

  notifier :beep, :if => Proc.new { |set| set.any? { |c| c.status.nok? } } do |checkers|
    system "beep -d 1000 -r 15" 
  end
  notifier :email, EmailNotifier, :to => "root@...", :if => &:critical?
  notifier :syslog, SyslogNotifier
end

