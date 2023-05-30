import cocotb
import os
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles, Timer
from math import log2

@cocotb.test()
async def test_lzc_basic(dut):
    for s in range(25):
        dut.x.value = 8388608>>s
        await Timer(10, units="ns")
        z = dut.z.value
        print(z, s)
        assert dut.z.value == s

@cocotb.test()
async def test_lzc_full(dut):
    for s in range(16777215):
        if s%65536==0:
            print(s)
        dut.x.value = s
        await Timer(10, units="ns")
        z = dut.z.value
        if s==0:
            assert dut.z.value == 24
        else:
            m = int(log2(s))
            assert dut.z.value == 23-m
