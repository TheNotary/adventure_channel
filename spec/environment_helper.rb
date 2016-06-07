
require 'colorize'
require 'socket'
require 'timeout'

def port_open?(ip, port)
  begin
    Timeout::timeout(1) do
      begin
        s = TCPSocket.new(ip, port)
        s.close
        return true
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        return false
      end
    end
  rescue Timeout::Error
  end

  return false
end


def check_test_environment!
  $IsIRCServerListening = port_open?(ENV['irc_server'], ENV['irc_port'])

  if !$IsIRCServerListening
    puts "#{"Warning:".yellow}  IRC Server not listening on #{ENV['irc_server']}:#{ENV['irc_port']}, full integration tests will not be run."
    puts " " * 10 + "proceeding"
  end

  if !port_open?(ENV['redis_host'], ENV['redis_port'])
    puts
    puts "#{"Fatal:".red}    Redis Server not listening on redis://#{ENV['redis_host']}:#{ENV['redis_port']}"
    puts " " * 10 + "Can't continue with most of the tests so aborting!"
    puts
    exit!
  end
end
