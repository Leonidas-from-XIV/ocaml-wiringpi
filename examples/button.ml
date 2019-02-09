open Gpio3

(* Set up the pins the following way: *)
(* pin 3 (pull-up) -> btn -> resistor -> gnd *)

let setup () =
  Gpio3.setup ();
  pin_mode GPIO3 IN;
  pull_up_dn_control GPIO3 UP

let rec loop () =
  (match digital_read GPIO3 with
   | LOW -> print_endline "-- LOW"
   | HIGH -> print_endline "++ HIGH");
  Unix.sleepf 0.5;
  loop ()


let _ =
  setup ();
  loop ();

