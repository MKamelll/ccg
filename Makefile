SRC=./src
CCG=./src/generator

ccg: $(SRC)/*.d $(CCG)/*.d
	mkdir -p build
	dmd $^ -of=build/$@