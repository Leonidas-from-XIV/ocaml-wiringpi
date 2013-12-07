open WiringPiOcaml;;
open ShiftReg;;

let _ =
  (* On choisit le mode d'affichage Phys *)
  setupPhys ();
  (* reg : pin_value = p_v, pin_shift = p_s, pin_apply = p_a *)
  (* On crée le register *)
  let reg = genReg 11 13 15 ~invert:true in
  (* On initialise *)
  let leds = initReg reg ~nb_reg:1 in
  (* On boucle pour afficher les leds unes par unes *)

  Printf.printf "début\n%!";
  findLedNumber reg leds;
  while true do
    
    for k = 0 to (Array.length leds) - 1 do
      leds.(k) <- true;
      applyReg reg leds;
      delay 100;
      leds.(k) <- false
    done;
    for k = (Array.length leds) - 2 downto 0 do
      leds.(k) <- true;
      applyReg reg leds;
      delay 100;
      leds.(k) <- false
    done;
    lightLeds leds;
    applyReg reg leds;
    Unix.sleep 1;
    clearLeds leds;
  done

;;
