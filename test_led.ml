open WiringPiOcaml;;
open ShiftReg;;

let test reg leds =
  lightLeds leds;
  (* Pour montrer la différence entre les deux modes *)
  Printf.printf "The pulse mode...\n%!";
  applyRegPulse reg leds 2.;
  
  Printf.printf "The classic mode...\n%!";
  applyRegAll reg leds;
  Unix.sleep 2;

  Printf.printf "Only one led :\n%!";
  clearLeds leds;
  leds.(1) <- true;
  Printf.printf "The pulse mode...\n%!";
  applyRegPulse reg leds 2.;

  Printf.printf "The classic mode...\n%!";
  applyRegAll reg leds;
  Unix.sleep 2

let _ =
  let what = Sys.argv.(1) in
  Printf.printf "%s\n" Sys.argv.(1);
  ignore(setupPhys ());
  let reg = genReg 11 13 15 ~invert:false in
  let leds = initReg reg ~nb_reg:2 in
  let t = true
  and f = false in
  clearLeds leds;
  if what = "g" then begin
    let make_t n k =
      clearLeds leds;
      for k = 0 to Array.length leds - 1 do
	if k mod 3 = 0 then
	  leds.(k) <- t;
      done
    in
    make_t 3 0;
    let t1 = Array.copy leds in
    make_t 3 1;
    let t2 = Array.copy leds in
    make_t 3 2;
    let t3 = Array.copy leds in
    let t = [|t1;t2;t3|] in
    while true do
      applyReg reg t1 0.5;
      applyReg reg t2 0.5;
      applyReg reg t3 0.5;
    done    
  end
  else if what = "a" then begin
    lightLeds leds;
    while true do
      applyReg reg leds 10.;
    done;
  end
  else if what = "e" then begin
    clearLeds leds;
    while true do
      applyReg reg leds 10.;
    done;
  end
  else if what = "f" then begin
    findLedNumber reg leds;
  end
  else if what = "obo" then begin
    clearLeds leds;
    leds.(int_of_string Sys.argv.(2)) <- t;
    applyReg reg leds 10.;
  end

    
    
(*
  9 -> saute la 7e (première du nvx)
  15 --> réagit légèrement
*)
