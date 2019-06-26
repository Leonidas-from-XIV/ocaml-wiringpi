(** broadcom numbers *)
val setup : unit -> unit

type pin =
 (*  3V3  |  5V   *)
    GPIO2 | (* 5V *)
    GPIO3 | (* GND *)
    GPIO4 | GPIO14
(* GND *) | GPIO15 |
   GPIO17 | GPIO18 |
   GPIO27 | (* GND *)
   GPIO22 | GPIO23
(* 3V3 *) | GPIO24 |
   GPIO10 | (* GND *)
    GPIO9 | GPIO25 |
   GPIO11 | GPIO8 
(* GND *) | GPIO7  |
    GPIO0 | GPIO1  |
    GPIO5 | (* GND *)
    GPIO6 | GPIO12 |
   GPIO13 | (* GND *)
   GPIO19 | GPIO16 |
   GPIO26 | GPIO20

type pin_value = LOW | HIGH

type mode = IN | OUT
type pin_updn = UP | DOWN | OFF
               
val pin_mode : pin -> mode -> unit
val pull_up_dn_control : pin -> pin_updn -> unit
val digital_write : pin -> pin_value -> unit
val digital_read : pin -> pin_value
