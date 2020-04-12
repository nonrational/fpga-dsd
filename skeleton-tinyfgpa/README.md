# TinyFGPA BX

## Links
- https://tinyfpga.com/bx/guide.html

## Hardware Breadboard Setup

Breadboard connection requires soldering 2x 14-pin headers.

<img src=../gh-assets/tinyfpga_solder.jpeg width=200>

## Setup

```bash
#/usr/bin/env bash
pyenv local 3.7.4
pyenv rehash

pip install --upgrade pip
pip install apio==0.5.4 tinyprog

# install packages to run build & upload
apio install system scons ice40 yosys verilator

# enable USB connection to board
apio drivers --serial-enable
```

## Usage

See `Makefile`.
