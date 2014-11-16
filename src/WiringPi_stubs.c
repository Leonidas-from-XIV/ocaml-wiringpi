/* ********************************************
   This file make the link between wiringPi
   and wiringPiOcaml
   ******************************************** */

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <stdio.h>
#include <wiringPi.h>
#include <wiringShift.h>

value ocamlwiring_setup(value unit)
{
  CAMLparam1(unit);
  CAMLreturn(Val_int(wiringPiSetup()));
}

value ocamlwiring_setup_gpio(value unit)
{
  CAMLparam1(unit);
  CAMLreturn(Val_int(wiringPiSetupGpio()));
}

value ocamlwiring_setup_phys(value unit)
{
  CAMLparam1(unit);
  CAMLreturn(Val_int(wiringPiSetupPhys()));
}

value ocamlwiring_setup_sys(value unit)
{
  CAMLparam1(unit);
  CAMLreturn(Val_int(wiringPiSetupSys()));
}

// Core functions

value ocamlwiring_pin_mode(value pin, value mode)
{
  CAMLparam2(pin, mode);
  pinMode(Int_val(pin), Int_val(mode));
  CAMLreturn(Val_unit);
}

value ocamlwiring_pull_up_dn_control(value pin, value pud)
{
  CAMLparam2(pin, pud);
  pullUpDnControl(Int_val(pin), Int_val(pin));
  CAMLreturn(Val_unit);
}

value ocamlwiring_digital_write(value pin, value value_p)
{
  CAMLparam2(pin, value_p);
  digitalWrite(Int_val(pin), Int_val(value_p));
  CAMLreturn(Val_unit);
}

value ocamlwiring_pwm_write(value pin, value value_p)
{
  CAMLparam2(pin, value_p);
  pwmWrite(Int_val(pin), Int_val(value_p));
  CAMLreturn(Val_unit);
}

value ocamlwiring_digital_read(value pin)
{
  CAMLparam1(pin);
  CAMLreturn(Val_int(digitalRead(Int_val(pin))));
}

value ocamlwiring_analog_read(value pin)
{
  CAMLparam1(pin);
  CAMLreturn(Val_int(analogRead(Int_val(pin))));
}

value ocamlwiring_analog_write(value pin, value value_p)
{
  CAMLparam2(pin, value_p);
  analogWrite(Int_val(pin), Int_val(value_p));
  CAMLreturn(Val_unit);
}

// Raspberry Pi Specifics

value ocamlwiring_digital_write_byte(value value_p)
{
  CAMLparam1(value_p);
  digitalWriteByte(Int_val(value_p));
  CAMLreturn(Val_unit);
}

// Others can be added...

// Shift Library

// Timing

/* This returns a number representing the number if milliseconds since your
 * program called one of the wiringPiSetup functions. */
value ocamlwiring_millis(value unit)
{
  CAMLparam1(unit);
  CAMLreturn(Val_int(millis()));
}

/* This returns a number representing the number of microseconds since your
 * program called one of the wiringPiSetup functions. */
value ocamlwiring_micros(value unit)
{
  CAMLparam1(unit);
  CAMLreturn(Val_int(micros()));
}

/* This causes program execution to pause for at least howLong milliseconds.
 * Due to the multi-tasking nature of Linux it could be longer. */
value ocamlwiring_delay(value how_long)
{
  CAMLparam1(how_long);
  delay(Int_val(how_long));
  CAMLreturn(Val_unit);
}

/* This causes program execution to pause for at least howLong microseconds.
 * Due to the multi-tasking nature of Linux it could be longer. Delays under
 * 100 microseconds are timed using a hard-coded loop continually polling the
 * system time, Delays over 100 microseconds are done using the system
 * nanosleep() function – You may need to consider the implications of very
 * short delays on the overall performance of the system, especially if using
 * threads. */
value ocamlwiring_delay_microseconds(value how_long)
{
  CAMLparam1(how_long);
  delayMicroseconds(Int_val(how_long));
  CAMLreturn(Val_unit);
}
