#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/media/kurtlike/0bc13ae9-569d-48dc-9158-75f16c6ace65/Vivaldo/Vivado/2021.2/ids_lite/ISE/bin/lin64:/media/kurtlike/0bc13ae9-569d-48dc-9158-75f16c6ace65/Vivaldo/Vivado/2021.2/bin
else
  PATH=/media/kurtlike/0bc13ae9-569d-48dc-9158-75f16c6ace65/Vivaldo/Vivado/2021.2/ids_lite/ISE/bin/lin64:/media/kurtlike/0bc13ae9-569d-48dc-9158-75f16c6ace65/Vivaldo/Vivado/2021.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/media/kurtlike/0bc13ae9-569d-48dc-9158-75f16c6ace65/Vivaldo/Vivado/2021.2/bin/lab2_1/lab2_1.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .init_design.begin.rst
EAStep vivado -log main_funk.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source main_funk.tcl -notrace


