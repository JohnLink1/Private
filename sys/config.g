; Prusa i3 config file for dc42 Duet firmware

; Prologue and  comms section
M111 S0                             ; Debug off
M550 Link Printr				; Machine name (can be anything you like)
M551 root                        ; Machine password
;*** If you have more than one Duet on your network, they must all have different MAC addresses, so change the last digits
M540 P0xBE:0xEF:0xDE:0xAD:0xFE:0xED ; MAC Address
;*** ;*** Wifi Networking
;M552 S1			; Enable WiFi

M555 P2                             ; Set output to look like Marlin
M575 P1 B57600 S1					; Comms parameters for PanelDue

; Movement section
M569 P0 S1                          ; Drive 0 goes forwards (change to S0 to reverse it)
M569 P1 S1                          ; Drive 1 goes forwards
M569 P2 S1                          ; Drive 2 goes forwards
M569 P3 S1                          ; Drive 3 goes forwards
M569 P4 S1                          ; Drive 4 goes forwards
M574 X1 Y1 Z0 S1			; set endstop configuration (X and Y endstops only, at low end, active high)
M906 X800 Y800 Z800 E1000           ; Set motor currents (mA)
M201 X800 Y800 Z15 E1000            ; Accelerations (mm/s^2)
M203 X15000 Y15000 Z100 E3600       ; Maximum speeds (mm/min)
M566 X600 Y600 Z30 E20              ; Minimum speeds mm/minute
M208 X200 Y200 Z200					; set axis maxima (adjust to suit your machine)
M208 X0 Y0 Z-0.2 S1					; set axis minimum (adjust to make X=0 and Y=0 the edge of the bed)
M350 X16 Y16 E16 I1  		  ; Set 16x microstepping with interpolation
M92 X80 Y80 Z2560			; Set axis steps/mm
M92 E420:420                       	; Set extruder steps per mm
G21                                 ; Work in millimetres
G90                                 ; Send absolute coordinates...
M83                                 ; ...but relative extruder moves

; Z probe section
M558 P1 X0 Y0 Z1 H3 F200 T5000		; Smart IR Z probe, used for homing Z axis, dive height 3mm, probe speed 200mm/min, travel speed 5000mm/min
G31 X11.0 Y0.5 Z1.20 P500           ; Set the probe height and threshold (put your own values here)

; Heater and thermistor section
;*** If you have a Duet board with 1K thermistor series resistors, change R4700 to R1000 to the following M305 commands
M305 P0 R4700 H0 L0					; Put your own H and/or L values here to set the bed thermistor ADC correction
M305 P1 R4700 H0 L0					; Put your own H and/or L values here to set the first nozzle thermistor ADC correction
M305 P2 R4700 H0 L0					; Put your own H and/or L values here to set the second nozzle thermistor ADC correction
M301 H1 P10 I0.10 D100 T0.50 S1.0	; PID settings for extruder 0
M301 H2 P10 I0.10 D100 T0.50 S1.0	; PID settings for extruder 1
M570 S120							; Increase to allow extra heating time if needed

; Tool definition section
M563 P0 D0 H1                       ; Define tool 0 to use extruder drive 0 and heater 1
G10 P0 S0 R0                        ; Set tool 0 operating and standby temperatures
;*** If you have a dual-nozzle build, un-comment the following 2 lines
;M563 P1 D1 H2                      ; Define tool 1
;G10 P1 S0 R0                       ; Set tool 1 operating and standby temperatures

; Bed probe section (not needed if you use a bed.g file)
;*** Adjust the XY coordinates in the following M557 commands to suit your build and the position of your Z probe
M557 P0 X60 Y0                      ; Four... 
M557 P1 X60 Y165                    ; ...probe points...
M557 P2 X200 Y165                   ; ...for bed...
M557 P3 X200 Y0                     ; ...levelling
;M557 P4 X141 Y82.5                 ; 5th probe point for levelling (un-comment this to get a 5th point at the centre of the bed)

; Epilogue
;*** If you are using axis compensation, put the figures in the following command
M556 S78 X0 Y0 Z0                   ; Axis compensation here
T0									; select first hot end
