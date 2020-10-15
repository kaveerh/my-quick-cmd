LLDP:
diagnose sniffer packet port1 'ether proto 0x88cc' 4 1 a
 
CDP:
diagnose sniffer packet port1 'ether[20:2] == 0x2000' 6 1 a
