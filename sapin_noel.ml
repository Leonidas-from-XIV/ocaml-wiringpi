open WiringPiOcaml;;
open ShiftReg;;

(* Ici on utilise des fonctions plus souples mais moins agréables pour les tests. Pour voir les fonctions classiques, cf anim_01 *)
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

(* S'inspirer de ce schéma pour les animations *)
let anim_01 reg leds n =
  for i = 0 to n do
    clearLeds leds;
    for k = 0 to (Array.length leds) - 1 do
      leds.(k) <- true;
      applyReg reg leds 0.2;
      leds.(k) <- false
    done;
    for k = (Array.length leds) - 2 downto 0 do
      leds.(k) <- true;
      applyReg reg leds 0.2;
      leds.(k) <- false
    done;
    lightLeds leds;
    applyReg reg leds 1.;
  done

let anim_02 reg leds n =
  let t = ref 1. in
  for i = 0 to n do
    clearLeds leds;
    for k = 0 to (Array.length leds) - 1 do
      leds.(k) <- true;
      applyReg reg leds (!t /. 10.);
      leds.(k) <- false
    done;
    for k = (Array.length leds) - 2 downto 0 do
      leds.(k) <- true;
      applyReg reg leds (!t /. 10.);
      leds.(k) <- false
    done;
    lightLeds leds;
    applyReg reg leds !t;
    t := !t /. 1.2;
  done

let _ =
  (* On choisit le mode d'affichage Phys *)
  ignore(setupPhys ());
  (* reg : pin_value = p_v, pin_shift = p_s, pin_apply = p_a *)
  (* On crée le register *)
  (* En mode pulse : *)
  (* let reg = genReg 11 13 15 ~pulse:true in *)
  let reg = genReg 11 13 15 ~invert:false in
  (* On initialise *)
  let leds = initReg reg ~nb_reg:2 in
  let t = true
  and f = false in
  Printf.printf "Début\n%!";
  (* And a pretty animation *)
  anim_01 reg leds max_int;
  (* findLedNumber reg leds *)
