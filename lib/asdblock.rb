#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#

require 'asdblock/whois'
require 'asdblock/nft'

require 'netaddr'

module AsdBlock
  def self.gen_conf(asn)
    routes =
      WhoisClient
      .origin_as_lookup(asn)
      .each_line
      .select { |l| l.start_with?('route:', 'route6:') }
      .map { |a| NetAddr::CIDR.create(a.split(' ')[1].strip) }

    # merge IPs twice since we need them sorted first because of the way
    # the merge method works ("Summarization will only occur when the
    # newly created supernets will not result in the 'creation' of new
    # IP space.")
    ips = NetAddr.merge(NetAddr.merge(routes), Objectify: true)

    Nft.gen_conf(asn, ips)
  end
end
