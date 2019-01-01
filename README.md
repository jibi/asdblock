asdblock
========

ASN based traffic blocker for the lulz.

`asdblock` generates an `nft` configuration which drops all egress traffic to a given AS.

Example usage:
```
$ gem build ./asdblock.gemspec && gem install ./asdblock-0.0.1.gem
$ asdblock AS32934 | sudo nft -f-
$ sudo nft list ruleset
table inet filter {
	set AS32934-set-v4 {
		type ipv4_addr
		flags interval
		elements = { 31.13.24.0/21, 31.13.64.0/18,
			     45.64.40.0/22, 66.220.144.0/20,
			     69.63.176.0/20, 69.171.224.0/19,
			     74.119.76.0/22, 103.4.96.0/22,
			     129.134.0.0/16, 157.240.0.0/16,
			     173.252.64.0/18, 179.60.192.0/22,
			     185.60.216.0/22, 199.201.64.0/22,
			     204.15.20.0/22 }
	}

	set AS32934-set-v6 {
		type ipv6_addr
		flags interval
		elements = { 2401:db00::/32,
			     2620:0:1c00::/40,
			     2803:6080::/32,
			     2a03:2880::/32 }
	}

	chain block-AS32934 {
		ip daddr @AS32934-set-v4 drop
		ip6 daddr @AS32934-set-v6 drop
	}

	chain output {
		type filter hook output priority 0; policy accept;
		jump block-AS32934
	}
}
```
