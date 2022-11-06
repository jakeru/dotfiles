#!/usr/bin/env python3

import psutil
from plyer import notification
import time

def report(battery):
    print(f"Reporting Battery {battery.percent}%")
    percent = battery.percent
    notification.notify(
        title="Battery",
        message=f"Battery {battery.percent}%",
        timeout=10
    )

def get_battery_status():
    return psutil.sensors_battery()

if __name__ == "__main__":
    report_at = (5, 10, 15, 20, 30, 50, 75)
    reported = []
    while(True):
        battery = get_battery_status()
        if not battery.power_plugged:
            print(f"Battery {battery.percent}%")
            for r in report_at:
                if battery.percent <= r:
                    if r not in reported:
                        reported.append(r)
                        report(battery)
                    break
        else:
            reported = []
        time.sleep(60)
