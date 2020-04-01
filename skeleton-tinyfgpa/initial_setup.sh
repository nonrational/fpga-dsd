#/usr/bin/env bash

pyenv local 3.7.4
pyenv rehash

pip install apio==0.4.0b3 tinyprog
apio install system scons icestorm drivers verilator
apio drivers --serial-enable
