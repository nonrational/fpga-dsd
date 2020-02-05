run: clean build
	./playground.bin | tee playground.log

clean:
	rm -f playground.bin playground.log

build:
	iverilog -o playground.bin top.v

