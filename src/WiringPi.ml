(** This module is useful to communicate with the GPIO ports of a Raspberry Pi.
    It uses the WiringPi library: http://wiringpi.com/ **)

(* Test function *)
external test_hello_world : unit -> unit = "caml_hello"

(* Use it at the very beginning to choose the numeroting mode *)
external setup : unit -> int = "caml_wiringPiSetup"
external setupGio : unit -> int = "caml_wiringPiSetupGpio"
external setupPhys : unit -> int = "caml_wiringPiSetupPhys"
external setupSys : unit -> int = "caml_wiringPiSetupSys"

(* ##########  Write on the device ########## *)
(* This sets the mode of a pin to either INPUT (= 0), OUTPUT (= 1),
 * PWM_OUTPUT (= 2) or GPIO_CLOCK (= 3).
 * Note that only wiringPi pin 1 (BCM_GPIO 18) supports PWM output and only
 * wiringPi pin 7 (BCM_GPIO 4) supports CLOCK output modes. *)
external pinMode : int -> int -> unit = "caml_pinMode"

(* This sets the pull-up or pull-down resistor mode on the given pin, which
 * should be set as an input. *)
external pullUpDnControl : int -> int -> unit = "caml_pullUpDnControl"

(* Writes the value HIGH or LOW (1 or 0) to the given pin which must have
 * been previously set as an output. *)
external digitalWrite : int -> int -> unit = "caml_digitalWrite"

(* Writes the value to the PWM register for the given pin.
 * The Raspberry Pi has one on-board PWM pin, pin 1 (BMC_GPIO 18, Phys 12) and
 * the range is 0-1024. Other PWM devices may have other PWM ranges *)
external pwmWrite : int -> int -> unit = "caml_pwmWrite"

(* This function returns the value read at the given pin. It will be HIGH
 * or LOW (1 or 0) depending on the logic level at the pin. *)
external digitalRead : int -> int = "caml_digitalRead"
external digitalWriteByte : int -> unit = "caml_digitalWriteByte"

external analogRead: int -> int = "caml_analogRead"
external analogWrite: int -> int -> unit = "caml_analogWrite"


(* ##########  Timing ########## *)
(* Use it to wait a few ms or µs. If you want to wait for several
   secondes, use Unix.sleep. *)
(* wait n ms *)
external delay : int -> unit = "caml_delay"
(* wait n µs *)
external delayMicroseconds : int -> unit = "caml_delayMicroseconds"

(* This returns a number representing the number if ms/µs since your program
 * called one of the wiringPiSetup functions. *)
external millis : unit -> int = "caml_millis"
external micros : unit -> int = "caml_micros"


(* ################# Name of pins : ################# *)
(* +----------+-Rev2-+------+--------+------+-------+ *)
(* | wiringPi | GPIO | Phys | Name   | Mode | Value | *)
(* +----------+------+------+--------+------+-------+ *)
(* |      0   |  17  |  11  | GPIO 0 | IN   | Low   | *)
(* |      1   |  18  |  12  | GPIO 1 | IN   | High  | *)
(* |      2   |  27  |  13  | GPIO 2 | IN   | High  | *)
(* |      3   |  22  |  15  | GPIO 3 | IN   | High  | *)
(* |      4   |  23  |  16  | GPIO 4 | IN   | Low   | *)
(* |      5   |  24  |  18  | GPIO 5 | IN   | Low   | *)
(* |      6   |  25  |  22  | GPIO 6 | IN   | High  | *)
(* |      7   |   4  |   7  | GPIO 7 | IN   | High  | *)
(* |      8   |   2  |   3  | SDA    | IN   | High  | *)
(* |      9   |   3  |   5  | SCL    | IN   | High  | *)
(* |     10   |   8  |  24  | CE0    | IN   | High  | *)
(* |     11   |   7  |  26  | CE1    | IN   | Low   | *)
(* |     12   |  10  |  19  | MOSI   | IN   | High  | *)
(* |     13   |   9  |  21  | MISO   | IN   | High  | *)
(* |     14   |  11  |  23  | SCLK   | IN   | High  | *)
(* |     15   |  14  |   8  | TxD    | ALT0 | High  | *)
(* |     16   |  15  |  10  | RxD    | ALT0 | High  | *)
(* |     17   |  28  |   3  | GPIO 8 | OUT  | High  | *)
(* |     18   |  29  |   4  | GPIO 9 | IN   | Low   | *)
(* |     19   |  30  |   5  | GPIO10 | IN   | Low   | *)
(* |     20   |  31  |   6  | GPIO11 | IN   | Low   | *)
(* +----------+------+------+--------+------+-------+ *)
