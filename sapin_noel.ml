open WiringPiOcaml;;
open ShiftReg;;

let _ =
  (* On choisit le mode d'affichage Phys *)
  ignore(setupPhys ());
  (* reg : pin_value = p_v, pin_shift = p_s, pin_apply = p_a *)
  (* On crée le register *)
  let reg = genReg 11 13 15 in
  (* On initialise *)
  let leds = initReg reg ~nb_reg:1 in
  (* On boucle pour afficher les leds unes par unes *)

  Printf.printf "début\n%!";
  (* On remplit le tableau avec true *)
  lightLeds leds;
  (* Pour montrer la différence entre les deux modes *)
  (* The pulse mode... *)
  applyRegPulse reg leds 2.;
  (* The classic mode... *)
  applyReg reg leds;
  Unix.sleep 2;
  (* Only one led : *)
  clearLeds leds;
  leds.(1) <- true;
  (* Pulse *)
  applyRegPulse reg leds 2.;
  (* classic *)
  applyReg reg leds;
  Unix.sleep 2;
  (* And a pretty animation *)
  for i = 0 to 6 do
    clearLeds leds;
    for k = 0 to (Array.length leds) - 1 do
      leds.(k) <- true;
      applyReg reg leds;
      delay 100;
      leds.(k) <- false
    done;
    for k = (Array.length leds) - 2 downto 0 do
      leds.(k) <- true;
      applyRegPulse reg leds 0.1;
      (* applyReg reg leds; *)
      (* delay 100; *)
      leds.(k) <- false
    done;
    lightLeds leds;
    (* applyRegPulse reg leds 1.; *)
    applyReg reg leds;
    Unix.sleep 1;
  done;
  findLedNumber reg leds;

;;
