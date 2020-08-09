EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "5 Switch Column"
Date "2020-08-03"
Rev "01"
Comp ""
Comment1 ""
Comment2 "https://www.gnu.org/licenses/gpl-3.0.html"
Comment3 "License: GPL v3"
Comment4 "Author: Justin Frahm"
$EndDescr
Wire Wire Line
	4900 5900 4900 5800
Wire Wire Line
	4900 4700 4900 4600
Wire Wire Line
	4900 4100 4900 4000
Wire Wire Line
	4900 3500 4900 3400
Wire Wire Line
	4900 5550 5050 5550
Wire Wire Line
	5050 5550 5050 4950
Wire Wire Line
	5050 3150 4900 3150
Wire Wire Line
	4900 3750 5050 3750
Connection ~ 5050 3750
Wire Wire Line
	5050 3750 5050 3150
Wire Wire Line
	4900 4350 5050 4350
Connection ~ 5050 4350
Wire Wire Line
	5050 4350 5050 3750
Wire Wire Line
	4900 4950 5050 4950
Connection ~ 5050 4950
Wire Wire Line
	5050 4950 5050 4350
Wire Wire Line
	5050 3150 5050 3000
Wire Wire Line
	5050 3000 4000 3000
Connection ~ 5050 3150
Wire Wire Line
	4500 3500 4500 3050
Wire Wire Line
	4500 3050 4000 3050
Wire Wire Line
	4000 3100 4450 3100
Wire Wire Line
	4450 3100 4450 4100
Wire Wire Line
	4450 4100 4500 4100
Wire Wire Line
	4000 3150 4400 3150
Wire Wire Line
	4400 3150 4400 4700
Wire Wire Line
	4400 4700 4500 4700
Wire Wire Line
	4000 3200 4350 3200
Wire Wire Line
	4350 3200 4350 5300
Wire Wire Line
	4350 5300 4500 5300
Wire Wire Line
	4000 3250 4300 3250
Wire Wire Line
	4300 3250 4300 5900
Wire Wire Line
	4300 5900 4500 5900
$Comp
L symbols:CherryMXDiode S1
U 1 1 5F2D8ACD
P 4700 3450
F 0 "S1" H 4988 3599 50  0000 L CNN
F 1 "CherryMXDiode" H 4988 3508 50  0000 L CNN
F 2 "footprints:SW_Cherry_MX_1.00u_PCB" H 4700 3450 50  0001 C CNN
F 3 "" H 4700 3450 50  0001 C CNN
	1    4700 3450
	1    0    0    -1  
$EndComp
$Comp
L symbols:CherryMXDiode S2
U 1 1 5F27C6D7
P 4700 4050
F 0 "S2" H 4988 4199 50  0000 L CNN
F 1 "CherryMXDiode" H 4988 4108 50  0000 L CNN
F 2 "footprints:SW_Cherry_MX_1.00u_PCB" H 4700 4050 50  0001 C CNN
F 3 "" H 4700 4050 50  0001 C CNN
	1    4700 4050
	1    0    0    -1  
$EndComp
$Comp
L symbols:CherryMXDiode S3
U 1 1 5F27CC87
P 4700 4650
F 0 "S3" H 4988 4799 50  0000 L CNN
F 1 "CherryMXDiode" H 4988 4708 50  0000 L CNN
F 2 "footprints:SW_Cherry_MX_1.00u_PCB" H 4700 4650 50  0001 C CNN
F 3 "" H 4700 4650 50  0001 C CNN
	1    4700 4650
	1    0    0    -1  
$EndComp
$Comp
L symbols:CherryMXDiode S4
U 1 1 5F27D1C8
P 4700 5250
F 0 "S4" H 4988 5399 50  0000 L CNN
F 1 "CherryMXDiode" H 4988 5308 50  0000 L CNN
F 2 "footprints:SW_Cherry_MX_1.00u_PCB" H 4700 5250 50  0001 C CNN
F 3 "" H 4700 5250 50  0001 C CNN
	1    4700 5250
	1    0    0    -1  
$EndComp
$Comp
L symbols:CherryMXDiode S5
U 1 1 5F27D70F
P 4700 5850
F 0 "S5" H 4988 5999 50  0000 L CNN
F 1 "CherryMXDiode" H 4988 5908 50  0000 L CNN
F 2 "footprints:SW_Cherry_MX_1.00u_PCB" H 4700 5850 50  0001 C CNN
F 3 "" H 4700 5850 50  0001 C CNN
	1    4700 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 5200 4900 5300
$Comp
L symbols:6PinHeader U1
U 1 1 5F27F443
P 4000 3000
F 0 "U1" H 3957 3203 50  0000 C CNN
F 1 "6PinHeader" H 3957 3112 50  0000 C CNN
F 2 "footprints:6PinHeader" H 3900 2800 50  0001 C CNN
F 3 "" H 3900 2800 50  0001 C CNN
	1    4000 3000
	1    0    0    -1  
$EndComp
$EndSCHEMATC
