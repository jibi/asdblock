#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#

require 'socket'

module WhoisClient
  WHOIS_HOST = 'whois.radb.net'
  WHOIS_PORT = 43

  def self.origin_as_lookup(asn)
    s = TCPSocket.open(WHOIS_HOST, WHOIS_PORT)
    s.puts("-i origin #{asn}")
    s.read
  end
end
