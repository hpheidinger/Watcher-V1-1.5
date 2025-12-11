function is_ip4 (addr,	i,x) {

	x=split(addr,parts,".")
	if (x != 4) { return 0 } # Nope! 
	for (i=1; i<=x; i++) {
		if ( parts[i] < 0 || parts[i] >255 ) { return 0 }  # Nope!
	}
	return 1 # "IP4"
}


#
# Return decimal value of an IPv4 addr
#
#function ip2dec (addr) {
#	num=0
#        x=split(addr,parts,".")
#        for (i=1; i<=4; i++) {
#                pot=256^(4-i)
#		num=num+(pot*parts[i])
#        }
#	return num
#}
function ip2dec(addr, i, parts) {
	split(addr, parts, ".")
	return (parts[1] * 16777216) + (parts[2] * 65536) + (parts[3] * 256) + parts[4]
}

#
# Return binary representation of a decimal number
# With 'len' specified the bin-string is padded with
# zeroes on the left
#
function num2bin (num,len,	bitstr) {
	bitstr=""
	while (num >0 ) {
		bitstr=num%2 bitstr
		num=rshift(num,1)
		len--
	}

	while (len-- > 0) {bitstr="0" bitstr}

	return bitstr
}

function num2ip (number) {

	mask=0xFF000000
	part[1]=rshift(and(number, mask), 24) 
	mask=rshift(mask,8)
	part[2]=rshift(and(number, mask), 16)
	mask=rshift(mask,8)
	part[3]=rshift(and(number, mask), 8) 
	mask=rshift(mask,8)
	part[4]=and(number, mask)

	ipstr=part[1]
	for (i=2; i<=4; i++) { ipstr=ipstr "." part[i] }

	return ipstr
}


#
# Return an IP v4 addr in 32-bit binary representation
#
function ip2bin (addr) {
	return num2bin(ip2dec(addr),32) 
}

function bin2dec (binstr,	len) {
	number=0
	p=len=length(binstr)
	for (i=0; i<len; i++) {
		pot=2^i
		digit=substr(binstr,p--,1)
		number=number+(pot*digit)
	}	
	return number
}

#
# Flip bits in a binary string
#
function complement (bitstr,	str,len) {
	p=l=length(bitstr)
	for (i=0; i<l; i++) {
		digit=substr(bitstr,p--,1)
		# Flip digit
		digit=xor(digit,1)
		str=digit str
	}
	return str
}

#########################################################
# CIDR match
# Return 1 if the ip addr matches the CIDR mask
# For IPs outside the network a value of <>0 is returned
# Examples: 	cidrmatch (223.243.87.96, 223.240.0.0/14)
#		... will match (return 1)
# 	 	cidrmatch (223.244.87.96, 223.240.0.0/14)
#		... will fail (return 0)
#########################################################
function cidrmatch (ipaddr,cidrmask,	cnet,cmsk,mask) {
	split(cidrmask,parts,"/")
	cnet=parts[1]
	cmsk=int(parts[2])

	if ( (cmsk < 8) || (cmsk >32) ) 
		return 0
	else	mask=2^(32-cmsk)-1

	# Turn to decimals for the sake of handling
	decip  = ip2dec(ipaddr)			# Decimal client address
	decnet = ip2dec(cnet)			# Decimal CIDR network
	bcast=decnet+mask			# Decimal broadcast address

	# Catch Point-2-Point on broadcast addr
	# i.e. verify '<='
	if ( (decip > decnet) && (decip <= bcast) ) 
		return 1
	else	return 0
}

# Precompute CIDR ranges
function preprocess_cidrs(cidr_list, result) {
    for (i in cidr_list) {
        split(cidr_list[i], parts, "/")
        cnet = ip2dec(parts[1])
        cmsk = int(parts[2])
        mask = 2^(32-cmsk) - 1
        bcast = cnet + mask
        result[i] = cnet " " bcast
    }
}

# Match using precomputed ranges for mass cidr matching
# Call 'preprocess_cidrs' 
function mass_cidrmatch(ipaddr, precomputed_ranges, cnet, bcast) {
    decip = ip2dec(ipaddr)
    for (i in precomputed_ranges) {
        split(precomputed_ranges[i], range, " ")
        cnet = range[1]
        bcast = range[2]
        if (decip >= cnet && decip <= bcast) {
            return 1
        }
    }
    return 0
}
	

############################################################################
# CIDR
# Return CIDR for a given network and broadcast address
# e.g. from whois ('NetRange:' [ARIN] or 'inetnum:' [other providers]
############################################################################
function cidr (net,bcast,	n,b,i,prefix) {
	n=ip2bin(net)
	b=ip2bin(bcast)
	#print n, length(n)
	#print b, length(b)

	# Careful, awk's substr uses a 1-based index
	# this takes a counter (here 'prefix') that counts from '0'
	prefix=0
	for ( i=1; i<=32; i++) { 
		if ( substr(n,i,1) != substr(b,i,1)) break;
		prefix++
	}

	if ( i > 32 ) 
		print ""
	else	print net "/" prefix
}

function cidr2(net,bcast,	n,b,i,prefix) {
	n=ip2bin(net)
	b=ip2bin(bcast)
	prefix=0

	for ( i=1; i<=32; i++) { 
		if ( substr(n,i,1) != substr(b,i,1)) break;
		prefix++
	}

	if ( i > 32 ) 
		print ""
	else	print net "/" prefix > "/dev/stdout"
}
