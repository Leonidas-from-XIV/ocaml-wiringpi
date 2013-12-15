CC=ocamlc
OPT=-custom

MAIN=sapin_noel.ml
SOURCES=wiringPiOcaml_stub.c wiringPiOcaml.ml shiftReg.ml
PACKAGES=unix parmap

OBJECTS=$(SOURCES)
OUTPUT=$(MAIN:.ml=.bin)


all: $(OBJECTS)
	$(CC) $(OPT) -cclib -lwiringPi unix.cma $(SOURCES) $(MAIN) -o $(OUTPUT)
	$(CC) $(OPT) -cclib -lwiringPi unix.cma $(SOURCES) test_led.ml -o test_led.bin

clean:
	rm -f *.cmo *.cmi *.cmx 

