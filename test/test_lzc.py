import cocotb
import os
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles, Timer
from math import log2

@cocotb.test()
async def test_lzc_basic(dut):
    for s in range(15):
        dut.x.value = 1<<s
        await Timer(10, units="ns")
        assert dut.c.value == 15-s

@cocotb.test()
async def test_lzc_full(dut):
    for s in range(65535):
        if s>0:
            dut.x.value = s
            await Timer(10, units="ns")
            c = dut.c.value
            m = int(log2(s))
            assert dut.c.value == 15-m
