PC = python
FC = gfortran

wrapper:
	fpm install --compiler=$(FC) --prefix=./pythermalfunctions/
	cd pythermalfunctions/lib && patchelf --set-rpath '$$ORIGIN' libthermalfunctions.so
	cd pythermalfunctions/lib && patchelf --set-rpath '$$ORIGIN' libevortran.so
	cd pythermalfunctions/lib && patchelf --set-rpath '$$ORIGIN' liberror-handling.so
	$(PC) -m pip install -e .

clean:
	$(PC) -m pip uninstall pythermalfunctions
	rm -rf build
	rm -rf pythermalfunctions/lib
	rm -rf pythermalfunctions/include
