#!/usr/bin/env bash

brew bundle
cpan install Switch
perl -V:'installsitelib'

pyenv local 3.7.4
pyenv rehash

pip install apio==0.5.4 tinyprog==1.0.21

apio install ice40 iverilog scons system verilator yosys

make enable-serial-drivers
