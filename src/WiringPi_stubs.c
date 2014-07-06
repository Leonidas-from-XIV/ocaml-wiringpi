/* ********************************************
   This file make the link between wiringPi
   and wiringPiOcaml
   ******************************************** */

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <stdio.h>
#include <wiringPi.h>
#include <wiringShift.h>

value caml_hello(value unit) {
     CAMLparam1(unit);
     printf("Hello world!\n");
     CAMLreturn(Val_unit);
}

value caml_wiringPiSetup(value unit)
{
     CAMLparam1(unit);
     CAMLreturn(Val_int(wiringPiSetup()));
}

value caml_wiringPiSetupGpio(value unit)
{
     CAMLparam1(unit);
     CAMLreturn(Val_int(wiringPiSetupGpio()));
}

value caml_wiringPiSetupPhys(value unit)
{
     CAMLparam1(unit);
     CAMLreturn(Val_int(wiringPiSetupPhys()));
}

value caml_wiringPiSetupSys(value unit)
{
     CAMLparam1(unit);
     CAMLreturn(Val_int(wiringPiSetupSys()));
}

// Core functions

value caml_pinMode(value pin, value mode)
{
     CAMLparam2(pin, mode);
     pinMode(Int_val(pin), Int_val(mode));
     CAMLreturn(Val_unit);
}

value caml_pullUpDnControl(value pin, value pud)
{
     CAMLparam2(pin, pud);
     pullUpDnControl(Int_val(pin), Int_val(pin));
     CAMLreturn(Val_unit);
}

value caml_digitalWrite(value pin, value value_p)
{
     CAMLparam2(pin, value_p);
     digitalWrite(Int_val(pin), Int_val(value_p));
     CAMLreturn(Val_unit);
}

value caml_pwmWrite(value pin, value value_p)
{
     CAMLparam2(pin, value_p);
     pwmWrite(Int_val(pin), Int_val(value_p));
     CAMLreturn(Val_unit);
}

value caml_digitalRead(value pin)
{
     CAMLparam1(pin);
     CAMLreturn(Val_int(digitalRead(Int_val(pin))));
}

// AnalogRead and AnalogWrite needs to be added (module must be added)

// Raspberry Pi Specifics

value caml_digitalWriteByte(value value_p)
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
value caml_millis(value unit)
{
     CAMLparam1(unit);
     CAMLreturn(Val_int(millis()));
}

/* This returns a number representing the number of microseconds since your
 * program called one of the wiringPiSetup functions. */
value caml_micros(value unit)
{
     CAMLparam1(unit);
     CAMLreturn(Val_int(micros()));
}

/* This causes program execution to pause for at least howLong milliseconds.
 * Due to the multi-tasking nature of Linux it could be longer. */
value caml_delay(value howLong)
{
     CAMLparam1(howLong);
     delay(Int_val(howLong));
     CAMLreturn(Val_unit);
}

/* This causes program execution to pause for at least howLong microseconds.
 * Due to the multi-tasking nature of Linux it could be longer. Delays under
 * 100 microseconds are timed using a hard-coded loop continually polling the
 * system time, Delays over 100 microseconds are done using the system
 * nanosleep() function – You may need to consider the implications of very
 * short delays on the overall performance of the system, especially if using
 * threads. */
value caml_delayMicroseconds(value howLong)
{
     CAMLparam1(howLong);
     delayMicroseconds(Int_val(howLong));
     CAMLreturn(Val_unit);
}
