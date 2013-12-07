(** This module allow to communicate with a shift-register **)

(* Source :
   - http://blog.idleman.fr/raspberry-pi-20-creer-un-tableau-de-bord-connect-au-net/
   - http://www.onsemi.com/pub_link/Collateral/MC74HC595A-D.PDF
*)
open WiringPiOcaml
(** reg : (pin_value = p_v, pin_shift = p_s, pin_apply = p_a). It is
    used to contain the needed input **)
type reg = int * int * int;;

(** The first thing to do is setupPhys (). This function put in OUTPUT
    mode the outputs and return back a bool array which represent the output of registers (begining with the first LED of the first shift register) **)
let initReg ?nb_reg:(nb_reg = 1) reg =
  let (p_v, p_s, p_a) = reg in
  pinMode p_v 1; (* mode output *)
  pinMode p_s 1;
  pinMode p_a 1;
  Array.make (8*nb_reg) false (* return back an array for all pieces *)

let write pin value = digitalWrite pin (if value then 1 else 0)

(** This function apply all modifications to the register **)
let applyReg reg leds =
  let (p_v, p_s, p_a) = reg in
  write p_a false;
  for i = (Array.length leds) - 1 downto 0 do
    write p_s false;
    write p_v leds.(i);
    write p_s true;
  done;
  write p_a true


(** Don't forget to apply it with applyReg after **)
let clearLeds leds =
  Array.iteri (fun i x -> (leds.(i) <- false)) leds
let lightLeds leds =
  Array.iteri (fun i x -> (leds.(i) <- true)) leds

(** This function is usefull to find a LED in a logarithm time **)
let makeIntervalArray leds a b =
  Printf.printf "%d;%d" a b;
  Array.iteri
    (fun i x -> leds.(i) <- ((a <= i) && (i < b)) )
    leds

let printArray t =
  for k = 0 to Array.length t - 1 do
    Printf.printf "%b;" t.(k)
  done;
  Printf.printf "\n%!\n"
    
let findLedNumber reg ?time_answer:(time_answer = 3) leds0 =
  let n = Array.length leds0 in
  let leds = Array.make n false in
  let i = ref 0 in
  let j = ref n in
  while !i < (!j - 1) do
    Printf.printf "%d;%d" !i !j;
    let middle = !i + (!j - !i)/2 in
    makeIntervalArray leds !i middle;
    applyReg reg leds;
    printArray leds;
    Printf.printf "\nLighted ? (1 = Yes, other = no) %!";
    let res = input_line stdin in
    if res = "1" then
      j := middle
    else
      i := middle;
    Printf.printf "%d;%d" !i !j;
  done;
  if time_answer > 0 then begin
    Printf.printf "\nI think it's this LED : %d.\n%!" !i;
    clearLeds leds;
    leds.(!i) <- true;
    printArray leds;
    applyReg reg leds;
    Unix.sleep time_answer
  end

