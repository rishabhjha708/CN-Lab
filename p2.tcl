set ns [new Simulator]
set tf [open p2.tr w]
$ns trace-all $tf
set nf [ open p2.nam w]
$ns namtrace-all $nf


set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

$n0 label "Node 0"
$n1 label "Node 1"
$n2 label "Router"
$n3 label "Node 3"
$n4 label "Node 4"
$n5 label "Node 5"
$n6 label "Node 6"

$ns duplex-link $n0 $n2 10Mb 300ms DropTail
$ns duplex-link $n1 $n2 10Mb 300ms DropTail
$ns duplex-link $n3 $n2 5Mb 300ms DropTail
$ns duplex-link $n2 $n4 3.0Mb 300ms DropTail
$ns duplex-link $n5 $n2 10Mb 300ms DropTail
$ns duplex-link $n2 $n6 3.0Mb 300ms DropTail

$ns set queue-limit $n0 $n2 10
$ns set queue-limit $n1 $n2 10
$ns set queue-limit $n3 $n2 5
$ns set queue-limit $n4 $n2 5
$ns set queue-limit $n5 $n2 10
$ns set queue-limit $n6 $n2 5

set ping0 [new Agent/Ping]
$ns attach-agent $n0 $ping0
set ping4 [new Agent/Ping]
$ns attach-agent $n4 $ping4
set ping5 [new Agent/Ping]
$ns attach-agent $n5 $ping5
set ping6 [new Agent/Ping]
$ns attach-agent $n6 $ping6

$ping0 set packetSize_ 500

$ping5 set packetSize_ 500

$ns connect $ping0 $ping4
$ns connect $ping6 $ping5

$ns color 1 "white"
$ns color 2 "magenta"

$ping0 set class_ 1
$ping5 set class_ 2

proc SendPingPacket {} {
global ns ping0 ping5
set intervalTime 0.001
set new [$ns now]
$ns at [expr $new+$intervalTime] "$ping0 send"
$ns at [expr $new+$intervalTime-0.00029] "$ping5 send"
$ns at [expr $new+$intervalTime] "SendPingPacket"
}
Agent/Ping instproc recv {from rtt} {
	$self instvar node_
	puts "The node [$node_ id] recieved reply from $from with rtt of $rtt"
}

proc finish {} {
global ns nf tf
$ns flush-trace
exec nam p2.nam &
close $nf
close $tf
exit 0
}

$ns at 0.01 "SendPingPacket"
$ns at 5.0 "finish"
$ns run

