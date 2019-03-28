EESchema Schematic File Version 4
LIBS:led-panel-connector-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L agg-kicad:CONN_02x04 J1
U 1 1 5C992D80
P 3250 1400
F 0 "J1" H 3200 1615 50  0000 C CNN
F 1 "+5V" H 3200 1524 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x04_P2.54mm_Vertical" H 3250 1400 50  0001 C CNN
F 3 "" H 3250 1400 50  0001 C CNN
	1    3250 1400
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:CONN_02x04 J3
U 1 1 5C992DF6
P 3250 2850
F 0 "J3" H 3200 3065 50  0000 C CNN
F 1 "GND" H 3200 2974 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x04_P2.54mm_Vertical" H 3250 2850 50  0001 C CNN
F 3 "" H 3250 2850 50  0001 C CNN
	1    3250 2850
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:CONN_02x04 J2
U 1 1 5C992EB7
P 3250 2150
F 0 "J2" H 3200 2365 50  0000 C CNN
F 1 "DATA" H 3200 2274 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x04_P2.54mm_Vertical" H 3250 2150 50  0001 C CNN
F 3 "" H 3250 2150 50  0001 C CNN
	1    3250 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 1400 3450 1400
Wire Wire Line
	3450 1400 3450 1500
Wire Wire Line
	3450 1500 3350 1500
Wire Wire Line
	3450 1500 3450 1600
Wire Wire Line
	3450 1600 3350 1600
Connection ~ 3450 1500
Wire Wire Line
	3450 1600 3450 1700
Wire Wire Line
	3450 1700 3350 1700
Connection ~ 3450 1600
Wire Wire Line
	3050 1400 2950 1400
Wire Wire Line
	2950 1400 2950 1500
Wire Wire Line
	2950 1500 3050 1500
Wire Wire Line
	2950 1500 2950 1600
Wire Wire Line
	2950 1600 3050 1600
Connection ~ 2950 1500
Wire Wire Line
	2950 1600 2950 1700
Wire Wire Line
	2950 1700 3050 1700
Connection ~ 2950 1600
Wire Wire Line
	3050 2850 2950 2850
Wire Wire Line
	2950 2850 2950 2950
Wire Wire Line
	2950 2950 3050 2950
Wire Wire Line
	2950 2950 2950 3050
Wire Wire Line
	2950 3050 3050 3050
Connection ~ 2950 2950
Wire Wire Line
	2950 3050 2950 3150
Connection ~ 2950 3050
Wire Wire Line
	3350 2850 3450 2850
Wire Wire Line
	3450 2850 3450 2950
Wire Wire Line
	3450 2950 3350 2950
Wire Wire Line
	3450 2950 3450 3050
Wire Wire Line
	3450 3050 3350 3050
Connection ~ 3450 2950
Wire Wire Line
	3450 3050 3450 3150
Wire Wire Line
	3450 3150 3350 3150
Connection ~ 3450 3050
$Comp
L agg-kicad:5v #PWR01
U 1 1 5C994082
P 2750 1350
F 0 "#PWR01" H 2750 1460 50  0001 L CNN
F 1 "5v" H 2750 1474 50  0000 C CNN
F 2 "" H 2750 1350 50  0001 C CNN
F 3 "" H 2750 1350 50  0001 C CNN
	1    2750 1350
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:5v #PWR04
U 1 1 5C994132
P 3650 1350
F 0 "#PWR04" H 3650 1460 50  0001 L CNN
F 1 "5v" H 3650 1474 50  0000 C CNN
F 2 "" H 3650 1350 50  0001 C CNN
F 3 "" H 3650 1350 50  0001 C CNN
	1    3650 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 1400 3650 1400
Wire Wire Line
	3650 1400 3650 1350
Connection ~ 3450 1400
Wire Wire Line
	2950 1400 2750 1400
Wire Wire Line
	2750 1400 2750 1350
Connection ~ 2950 1400
$Comp
L agg-kicad:GND #PWR03
U 1 1 5C994978
P 3600 3200
F 0 "#PWR03" H 3470 3240 50  0001 L CNN
F 1 "GND" H 3600 3100 50  0000 C CNN
F 2 "" H 3600 3200 50  0001 C CNN
F 3 "" H 3600 3200 50  0001 C CNN
	1    3600 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 3150 3600 3150
Wire Wire Line
	3600 3150 3600 3200
Connection ~ 3450 3150
$Comp
L agg-kicad:GND #PWR02
U 1 1 5C994FDE
P 2750 3200
F 0 "#PWR02" H 2620 3240 50  0001 L CNN
F 1 "GND" H 2750 3100 50  0000 C CNN
F 2 "" H 2750 3200 50  0001 C CNN
F 3 "" H 2750 3200 50  0001 C CNN
	1    2750 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 3150 3050 3150
Wire Wire Line
	2950 3150 2750 3150
Wire Wire Line
	2750 3150 2750 3200
Connection ~ 2950 3150
Text GLabel 2900 2150 0    50   Input ~ 0
D2
Text GLabel 2900 2250 0    50   Input ~ 0
OE
Text GLabel 2900 2350 0    50   Input ~ 0
A0
Text GLabel 2900 2450 0    50   Input ~ 0
CLK
Text GLabel 3500 2150 2    50   Input ~ 0
D1
Text GLabel 3500 2250 2    50   Input ~ 0
LAT
Text GLabel 3500 2350 2    50   Input ~ 0
A1
NoConn ~ 3350 2450
Wire Wire Line
	3350 2350 3500 2350
Wire Wire Line
	3350 2250 3500 2250
Wire Wire Line
	3350 2150 3500 2150
Wire Wire Line
	3050 2150 2900 2150
Wire Wire Line
	3050 2250 2900 2250
Wire Wire Line
	3050 2350 2900 2350
Wire Wire Line
	3050 2450 2900 2450
$Comp
L agg-kicad:CONN_01x02 J4
U 1 1 5C99B3F7
P 5650 1450
F 0 "J4" H 5681 1665 50  0000 C CNN
F 1 "POWER" H 5681 1574 50  0000 C CNN
F 2 "Connector_JST:JST_VH_B2P-VH_1x02_P3.96mm_Vertical" H 5650 1450 50  0001 C CNN
F 3 "" H 5650 1450 50  0001 C CNN
	1    5650 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 1450 6050 1450
$Comp
L agg-kicad:PWR #FLG01
U 1 1 5C99C10E
P 6050 1350
F 0 "#FLG01" H 6050 1510 50  0001 C CNN
F 1 "PWR" H 6050 1484 50  0000 C CNN
F 2 "" H 6050 1350 50  0001 C CNN
F 3 "" H 6050 1350 50  0001 C CNN
	1    6050 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 1350 6050 1450
Connection ~ 6050 1450
Wire Wire Line
	6050 1450 6200 1450
$Comp
L agg-kicad:GND #PWR06
U 1 1 5C99CB6A
P 6200 1300
F 0 "#PWR06" H 6070 1340 50  0001 L CNN
F 1 "GND" H 6200 1200 50  0000 C CNN
F 2 "" H 6200 1300 50  0001 C CNN
F 3 "" H 6200 1300 50  0001 C CNN
	1    6200 1300
	-1   0    0    1   
$EndComp
Wire Wire Line
	5750 1550 6050 1550
Wire Wire Line
	6200 1550 6200 1700
$Comp
L agg-kicad:PWR #FLG02
U 1 1 5C99D73C
P 6050 1650
F 0 "#FLG02" H 6050 1810 50  0001 C CNN
F 1 "PWR" H 6050 1783 50  0000 C CNN
F 2 "" H 6050 1650 50  0001 C CNN
F 3 "" H 6050 1650 50  0001 C CNN
	1    6050 1650
	-1   0    0    1   
$EndComp
Wire Wire Line
	6050 1650 6050 1550
Connection ~ 6050 1550
Wire Wire Line
	6050 1550 6200 1550
$Comp
L agg-kicad:CONN_01x08 J5
U 1 1 5C99FFDF
P 5750 2500
F 0 "J5" H 5781 2715 50  0000 C CNN
F 1 "DATA" H 5781 2624 50  0000 C CNN
F 2 "Connector_JST:JST_PH_S8B-PH-K_1x08_P2.00mm_Horizontal" H 5750 2500 50  0001 C CNN
F 3 "" H 5750 2500 50  0001 C CNN
	1    5750 2500
	1    0    0    -1  
$EndComp
Text GLabel 6000 2500 2    50   Output ~ 0
D1
Text GLabel 6000 2600 2    50   Output ~ 0
D2
Text GLabel 6000 2800 2    50   Output ~ 0
A1
Text GLabel 6000 2700 2    50   Output ~ 0
A0
Text GLabel 6000 2900 2    50   Output ~ 0
OE
Text GLabel 6000 3000 2    50   Output ~ 0
LAT
Text GLabel 6000 3100 2    50   Output ~ 0
CLK
Wire Wire Line
	5850 2500 6000 2500
Wire Wire Line
	5850 2600 6000 2600
Wire Wire Line
	5850 2700 6000 2700
Wire Wire Line
	5850 2800 6000 2800
Wire Wire Line
	5850 2900 6000 2900
Wire Wire Line
	5850 3000 6000 3000
Wire Wire Line
	5850 3100 6000 3100
$Comp
L agg-kicad:GND #PWR0101
U 1 1 5C9B8BCF
P 6000 3300
F 0 "#PWR0101" H 5870 3340 50  0001 L CNN
F 1 "GND" H 6000 3150 50  0000 C CNN
F 2 "" H 6000 3300 50  0001 C CNN
F 3 "" H 6000 3300 50  0001 C CNN
	1    6000 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 3200 6000 3200
Wire Wire Line
	6000 3200 6000 3300
Wire Wire Line
	6200 1450 6200 1300
$Comp
L agg-kicad:5v #PWR05
U 1 1 5C99B54A
P 6200 1700
F 0 "#PWR05" H 6200 1810 50  0001 L CNN
F 1 "5v" H 6200 1824 50  0000 C CNN
F 2 "" H 6200 1700 50  0001 C CNN
F 3 "" H 6200 1700 50  0001 C CNN
	1    6200 1700
	-1   0    0    1   
$EndComp
$EndSCHEMATC
