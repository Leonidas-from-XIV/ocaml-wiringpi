(** Typed interface for WiritngPi.
 Missing:
 - modes PWM_OUTPUT and GPIO_GLOCK
 - pwm_write
 - digital_write_byte
 - analog_read
 - analog_write
 - delay, delay_microseconds (?)
 *)
open WiringPi

let setup () = ignore (setup_gpio ())

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

let int_of_pin = function
  | GPIO2 -> 2
  | GPIO3 -> 3
  | GPIO4 -> 4
  | GPIO14 -> 14
  | GPIO15 -> 15
  | GPIO17 -> 17
  | GPIO18 -> 18
  | GPIO27 -> 27
  | GPIO22 -> 22
  | GPIO23 -> 23
  | GPIO24 -> 24
  | GPIO10 -> 10
  | GPIO9 -> 9
  | GPIO25 -> 25
  | GPIO11 -> 11
  | GPIO8 -> 8
  | GPIO7 -> 7
  | GPIO0 -> 0
  | GPIO1 -> 1
  | GPIO5 -> 5
  | GPIO6 -> 6
  | GPIO12 -> 12
  | GPIO13 -> 13
  | GPIO19 -> 19
  | GPIO16 -> 16
  | GPIO26 -> 26
  | GPIO20 -> 20

(* What is not supported: PWM_OUTPUT and GPIO_GLOCK *)
type mode = IN | OUT

(** [pin_mode] sets the mode of the pin to either input or output
   (other modes not supported at this moment). *)
let pin_mode (p : pin) (m : mode) =
  match m with
  | IN -> WiringPi.pin_mode (int_of_pin p) 0
  | OUT -> WiringPi.pin_mode (int_of_pin p) 1

type pin_updn = UP | DOWN | OFF

(** [pull_up_dn_control] sets the pull-up or pull-down resistor mode on
   the given pin, which should be set as an input. *)
let pull_up_dn_control (p : pin) = function
  | UP -> WiringPi.pull_up_dn_control (int_of_pin p) 2
  | DOWN -> WiringPi.pull_up_dn_control (int_of_pin p) 1
  | OFF -> WiringPi.pull_up_dn_control (int_of_pin p) 0

type pin_value = LOW | HIGH

(** [digital_write] the value HIGH or LOW to the given pin which must
   have been previously set as an output. *)
let digital_write (p : pin) (v : pin_value) =
  match v with
  | LOW -> WiringPi.digital_write (int_of_pin p) 0
  | HIGH -> WiringPi.digital_write (int_of_pin p) 1

let digital_read (p : pin) : pin_value =
  match WiringPi.digital_read (int_of_pin p) with
  | 0 -> LOW
  | _ -> HIGH
