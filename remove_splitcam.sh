#!/bin/bash

echo "Starting the removal of SplitCam..."

# 1. Remove the SplitCam application
if [ -d "/Applications/SplitCam.app" ]; then
    echo "Removing SplitCam application..."
    sudo rm -rf "/Applications/SplitCam.app"
else
    echo "SplitCam application not found in /Applications."
fi

# 2. Remove SplitCam related files from ~/Library/Application Support/
if [ -d "$HOME/Library/Application Support/SplitCam" ]; then
    echo "Removing SplitCam Application Support files..."
    rm -rf "$HOME/Library/Application Support/SplitCam"
else
    echo "No SplitCam files found in Application Support."
fi

# 3. Remove SplitCam related files from ~/Library/Preferences/
if [ -f "$HOME/Library/Preferences/com.splitcam.plist" ]; then
    echo "Removing SplitCam Preferences..."
    rm "$HOME/Library/Preferences/com.splitcam.plist"
else
    echo "No SplitCam preferences file found."
fi

# 4. Remove SplitCam caches from ~/Library/Caches/
if [ -d "$HOME/Library/Caches/com.splitcam" ]; then
    echo "Removing SplitCam Caches..."
    rm -rf "$HOME/Library/Caches/com.splitcam"
else
    echo "No SplitCam cache found."
fi

# 5. Remove virtual audio device (if it's still visible)
echo "Checking Audio MIDI Setup for virtual devices..."
sudo kextunload -b com.splitcam.virtualaudio 2>/dev/null

# 6. Final cleanup and reboot suggestion
echo "SplitCam removal complete. Please reboot your system to ensure all changes are applied."
