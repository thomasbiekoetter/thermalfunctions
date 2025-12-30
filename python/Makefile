PC = python
FC = gfortran

all:
	fpm install --compiler=$(FC) --prefix=./pythermalfunctions/
	cd pythermalfunctions/lib && patchelf --set-rpath '$$ORIGIN' libthermalfunctions.so
	cd pythermalfunctions/lib && patchelf --set-rpath '$$ORIGIN' libevortran.so
	cd pythermalfunctions/lib && patchelf --set-rpath '$$ORIGIN' liberror-handling.so
	$(PC) -m pip install -e .
