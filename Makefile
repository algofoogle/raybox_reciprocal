MAIN_VSOURCES = src/rtl/lzc_fast.v
TEST_VSOURCES = test/lzc16_tb.v

# COCOTB variables:
export COCOTB_REDUCED_LOG_FMT=1
export PYTHONPATH := test:$(PYTHONPATH)
export LIBPYTHON_LOC=$(shell cocotb-config --libpython)

test: clean
	mkdir sim_build
	mkdir results
	iverilog \
		-g2005 \
		-o sim_build/sim.vvp \
		-s lzc16 -s lzc16_tb \
		$(MAIN_VSOURCES) $(TEST_VSOURCES)
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_lzc \
		vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus \
		sim_build/sim.vvp
	mv results.xml results/
	mv *.vcd results/

clean:
	rm -rf sim_build results

.PHONY: test clean
