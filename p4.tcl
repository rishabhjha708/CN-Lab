set ns [new Simulator]
set tf [open p4.tr w]
$ns trace-all $tf
set topo [new Topography]
$topo load_flatgrid 1000 1000

set nf [open p5.nam w]
$ns namtrace-all-wireless $nf 1000 1000
$ns node-config -adhocRouting DSDV\
		-llType LL\
		-macType Mac/802_11\
		-ifqType Queue/DropTail\
		-ifqLen 50\
		-phyType Phy/WirelessPhy\
		-channelType Channel/WirelessChannel\
		-propType Propagation/TwoRayGround\
		-antType Antenna/OmniAntenna\
		-topoInstance $topo\
		-agentTrace ON\
		-routerTrace ON

create-god 3
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$n0 label "Node 0"
$n1 label "Node 1"
$n2 label "Node 2"

$n0 set x_ 50
$n0 set y_ 50
$n0 set z_ 0

$n1 set x_ 100
$n1 set y_ 100
$n1 set z_ 0

$n2 set x_ 600
$n2 set y_ 600
$n2 set z_ 0

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1

set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2

$ns connect $tcp0 $sink1
$ns connect $tcp1 $sink2

$ns color 1 "white"
$ns color 2 "magenta"

$tcp0 set class_ 1
$tcp1 set class_ 2

$ns at 0.1 "$n0 setdest 50 50 15"
$ns at 0.1 "$n1 setdest 100 100 25"
$ns at 0.1 "$n2 setdest 600 600 25"

proc finish {} {
	global ns nf tf
	$ns flush-trace
	exec nam p4.nam &
	close $nf
	close $tf
	exit 0
}

$ns at 5.0 "$ftp0 start"
$ns at 5.0 "$ftp1 start"

$ns at 190 "$n1 setdest 500 500 15"
$ns at 300 "$n1 setdest 450 450 15"

$ns at 400 "$n1 setdest 600 600 15"

$ns at 300 "$n2 setdest 700 700 15"


$ns at 500 "finish"
$ns run
