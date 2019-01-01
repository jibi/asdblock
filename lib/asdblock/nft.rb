#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#

module Nft
  def self.gen_conf(asn, ips)
    ips4 = ips.select { |i| i.version == 4 }
    ips6 = ips.select { |i| i.version == 6 }
           .map { |i| i.to_s(Short: true) }

    <<~HEREDOC
	#!/usr/sbin/nft -f

	# Generated with asdblock

	table inet filter {
		set #{asn}-set-v4 {
			type ipv4_addr
			flags interval
			elements = {
                                #{ips4.join(",\n\t\t\t")}
			}
		}

		set #{asn}-set-v6 {
			type ipv6_addr
			flags interval
			elements = {
                                #{ips6.join(",\n\t\t\t")}
			}
		}

		chain block-#{asn} {
			ip daddr @#{asn}-set-v4 drop
			ip6 daddr @#{asn}-set-v6 drop
		}

		chain output {
			type filter hook output priority 0
			jump block-#{asn}
		}
	}
    HEREDOC
  end
end
