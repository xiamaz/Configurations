OUT = bbswitch-control

PREFIX = /usr/local

.PHONY: run install

$(OUT): nvidia.c
	gcc -march=native -O3 -pipe -o $(OUT) $<

clean:
	rm $(OUT)

run: $(OUT)
	@./$<

install: $(OUT)
	mkdir -p $(PREFIX)/bin
	cp $< $(PREFIX)/bin/$<
	chown 'root:root' $(PREFIX)/bin/$<
	chmod u+s $(PREFIX)/bin/$<
