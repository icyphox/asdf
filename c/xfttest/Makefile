CC=gcc
CFLAGS=-std=c99 -pedantic -Wall
XFT_CFLAGS=$(shell pkg-config --cflags freetype2)
LDFLAGS=-lX11
XFT_LDFLAGS=$(shell pkg-config --libs freetype2) -lXft

main: xftest.c
	$(CC) $(CFLAGS) $(XFT_CFLAGS) $(LDFLAGS) $(XFT_LDFLAGS) xftest.c -o xftest

clean:
	rm -f xftest
