#/usr/bin/env bash

VBoxManage list runningvms | grep ubuntu-18.04 || VBoxManage startvm ubuntu-18.04 --type headless

ssh vbox -C 'uname -a'
ssh vbox -C '/bin/bash -l -c "/home/norton/fpga-dsd/vivado/xvivado.sh"'

