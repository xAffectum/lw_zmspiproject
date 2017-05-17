#!/bin/sh

# anzuzeigende URL
URL="http://google.com"

# Endlosschleife für Browser Crash
while true; do

# Alle laufenden Programme beenden
killall -9 chromium-browser 2>/dev/null
killall -9 unclutter 2>/dev/null
killall -9 matchbox-window-manager 2>/dev/null

# Anwendungsdaten löschen
rm -rf ~/.cache &
rm -rf ~/.config &
rm -rf ~/.pki &

# Energiesparmodus ausschalten
xset -dpms
xset s off
xset s noblank

matchbox-window-manager -use_titlebar no &
unclutter &

# Browser starten
chromium-browser --kiosk --incognito --app=$URL --no-first-run --fast --fast-start --disable-poup-blocking --disable-infobars --disable-session-crashed-bubble --disable-tab-switcher --disable-translate --enable-low-res-tiling
#midori
#iceweasel
#chromium-browser
done

