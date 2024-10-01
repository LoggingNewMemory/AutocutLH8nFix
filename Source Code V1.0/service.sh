
#!/system/bin/sh

# Service script to loop continuously while the module is active

# Function that runs in a loop
loop_function() {
    while true; do
        # Insert the tasks you want to perform here
        echo "Autocut Charging is running..."
    # Read current charging status from the system
    CHARGE_STATUS=$(cat /sys/class/power_supply/battery/status)
    
    # Read current battery level
    LEVEL=$(cat /sys/class/power_supply/battery/capacity)
    
    # Determine the screen state by checking NFC service state
    SCREEN_STATE=$(dumpsys nfc | grep 'mScreenState' | cut -d'=' -f2)
    
    sleep 5  # Adding a delay to prevent excessive looping
    
    # Conditional logic based on battery level
    if [ $LEVEL -gt 99 ]; then
        # If battery level is greater than 99%, disable charging
        chmod +w /sys/devices/platform/charger/bypass_charger
        echo "1" >/sys/devices/platform/charger/bypass_charger 2>/dev/null
        su -lp 2000 -c "cmd notification post -S bigtext -t 'Autocut Charging' TagFull 'Battery Is Full, Autocut Is Enabled'"
    elif [ $LEVEL -lt 1 ]; then
        # If battery level is less than 100%, enable charging
        chmod +w /sys/devices/platform/charger/bypass_charger
        echo "0" >/sys/devices/platform/charger/bypass_charger 2>/dev/null
        # Sleep for a defined interval (e.g., 60 seconds) to prevent the script from running too frequently
        sleep 60
    fi
done

}

# Start the loop
loop_function &
