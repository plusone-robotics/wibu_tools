#!/usr/bin/env bash
# Copyright (C) 2019 Plus One Robotics - All Rights Reserved
# Permission to copy and modify is granted under the foo license
#
# Description:
# - This script checks if "CmContainer" object is detected by CodeMeter daemon. If it is detected, do nothing else. If not, force running "/sys/bus/usb/drivers/usb/{unbind, bind}" manually in an attempt to trigger CodeMeter to detect CmContainer object.
# - This script is intended to improve success rate for CodeMeter to detect CmContainer on Linux, which was problematic to the authors.
# - This script is originally intended to be run as part of daemon process e.g. systemd.

STR1=$(cmu -l | grep 'Result:')
STR2="Result: 1 CmContainer(s) listed."

sleep 3

if [ "$STR1" = "$STR2" ]; then
    echo "License Dongle found. CmContainer(s) detected."
    echo $STR1
else
    echo "License Dongle not found. 0 CmContainer(s) detected."
    echo $STR1
fi
COUNTER=1
while [ "$STR1" != "$STR2" ]
do
  echo "wibu check $COUNTER '${STR1}' != '${STR2}'"
  CODE_METER_FOUND=$(ps ax | grep CodeMeterLin | grep -cv "grep")
  if [ "$CODE_METER_FOUND" == "0" ]; then /bin/bash -c '/usr/sbin/CodeMeterLin'; fi

  /bin/bash -c "echo `grep 064f /sys/bus/usb/devices/*/idVendor | tr '/' ' ' | awk '{ print $5 }'` >/sys/bus/usb/drivers/usb/unbind"
  sleep 3
  /bin/bash -c "echo `grep 064f /sys/bus/usb/devices/*/idVendor | tr '/' ' ' | awk '{ print $5 }'` >/sys/bus/usb/drivers/usb/bind"
  sleep 10
  COUNTER=$(( $COUNTER + 1 ))
  STR1=$(cmu -l | grep 'Result:')
  sleep 3
done
