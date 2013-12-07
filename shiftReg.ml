(** This module allow to communicate with a shift-register **)

(* Source :
   - http://blog.idleman.fr/raspberry-pi-20-creer-un-tableau-de-bord-connect-au-net/
   - http://www.onsemi.com/pub_link/Collateral/MC74HC595A-D.PDF
*)
open WiringPiOcaml
(** reg : (pin_value = p_v, pin_shift = p_s, pin_apply = p_a). It is
    used to contain the informations about connections.
    The invert variable is used in order to revert the mode (false = lighted,
    true = not lighted) **)
type reg = {p_v : int; p_s : int; p_a : int; invert : bool;}


let genReg ?invert:(invert = false) pin_value pin_shift pin_apply =
  {p_v = pin_value; p_s = pin_shift; p_a = pin_apply; invert}

let write pin value = digitalWrite pin (if value then 1 else 0)

(** The first thing to do is setupPhys (). This function put in OUTPUT
    mode the outputs and return back a bool array which represent the output of registers (begining with the first LED of the first shift register) **)
let initReg ?nb_reg:(nb_reg = 1) reg =
  pinMode reg.p_v 1; (* mode output *)
  pinMode reg.p_s 1;
  pinMode reg.p_a 1;
  write reg.p_v false;
  write reg.p_s false;
  write reg.p_a false;
  Array.make (8*nb_reg) false (* return back an array for all pieces *)

(* Functions related to basic action of the register *)
let shift reg value =
    write reg.p_s false;
    write reg.p_v (value <> reg.invert); (* On inverse si besoin *)
    write reg.p_s true
let validate reg =
  write reg.p_a true;
  write reg.p_a false
    
(** This function apply all modifications to the register in the same time **)
let applyReg reg leds =
  write reg.p_a false;
  for i = (Array.length leds) - 1 downto 0 do
    shift reg leds.(i)
  done;
  validate reg
    
let applyRegPulse reg leds ?d_t:(d_t = 3000) time =
  let t = Unix.gettimeofday () in
  let first_time = ref true in
  (* Clear the leds *)
  write reg.p_a false;
  for i = (Array.length leds) - 1 downto 0 do
    shift reg false
  done;
  (* It create a one at the very beginning *)
  shift reg true;
  while !first_time || Unix.gettimeofday () -. t < time do
    for i = 0 to (Array.length leds) - 1 do
      (* We add a zero (we need only one true on the line *)
      if leds.(i) then begin
	(* On valide en attendant un petit coup *)
	validate reg;
	delayMicroseconds d_t;
      end;
      shift reg false;
    done;
    first_time := false;
    shift reg true;
  done
    
(** Don't forget to apply it with applyReg after **)
let clearLeds leds =
  Array.iteri (fun i x -> (leds.(i) <- false)) leds
let lightLeds leds =
  Array.iteri (fun i x -> (leds.(i) <- true)) leds

let printBoolArray t =
  for k = 0 to Array.length t - 1 do
    Printf.printf "%b;" t.(k)
  done;
  Printf.printf "\n%!\n"
    

(** This function is usefull to find a LED in a logarithm time **)
let findLedNumber reg ?time_answer:(time_answer = 3) leds0 =
  let makeIntervalArray leds a b =
    Printf.printf "%d;%d" a b;
    Array.iteri
      (fun i x -> leds.(i) <- ((a <= i) && (i < b)) )
      leds
  in
  let n = Array.length leds0 in
  let leds = Array.make n false in
  let i = ref 0 in
  let j = ref n in
  while !i < (!j - 1) do
    Printf.printf "%d;%d" !i !j;
    let middle = !i + (!j - !i)/2 in
    makeIntervalArray leds !i middle;
    applyReg reg leds;
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
    applyReg reg leds;
    Unix.sleep time_answer
  end

