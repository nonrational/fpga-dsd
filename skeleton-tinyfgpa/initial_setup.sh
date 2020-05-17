#!/usr/bin/env bash

brew bundle

# enable gtkwave at the commandline
cpan install Switch
perl -V:'installsitelib'

mkvirtualenv tiny
# pyenv local 3.7.4
# pyenv rehash

pip install apio==0.5.4 tinyprog==1.0.21

apio install ice40 iverilog scons system verilator yosys

make enable-serial-drivers
