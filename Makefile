.PHONY: all
all:
	g++ `pkg-config glib-2.0 --cflags` `pkg-config glib-2.0 --libs` -lpython \
		-lz ./mac-dictionary-kit/sdconv/*.cpp -o ./mac-dictionary-kit/sdconv/sdconv
