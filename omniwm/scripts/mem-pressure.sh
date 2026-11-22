#!/bin/sh
# Feeds macOS memory pressure to the OmniWM bar's system-stats widget every 2 s (run by the
# local.omniwm.mem-pressure LaunchAgent). Pressure % = 100 - kern.memorystatus_level, the
# "memory free percentage" that `memory_pressure` prints. Needs ipcEnabled = true in OmniWM.
while :; do
    /Applications/OmniWM.app/Contents/MacOS/omniwmctl shell set mempressure \
        "$((100 - $(/usr/sbin/sysctl -n kern.memorystatus_level)))" >/dev/null 2>&1
    sleep 2
done
