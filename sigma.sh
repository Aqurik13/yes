#!/bin/sh
set -e

outfile=$(mktemp)
trap 'rm -f "$outfile"' EXIT

if [ "$(id -u)" -eq 0 ]; then
    echo "Run me as normal user, not root!"
    exit 1
fi

chmod +x "$outfile"

if command -v sudo >/dev/null; then
  echo "Running with sudo"
  sudo env "$@" "$outfile"
elif command -v doas >/dev/null; then
  echo "Running with doas"
  doas env "$@" "$outfile"
else
  echo "Neither sudo nor doas were found. Please install either of them to proceed."
fi

echo "System Remover 3000 by aqurik"
echo "Type number to select!"
echo "[1] - Clear System"
echo "[2] - Clear home"
echo "[3] - Clear Boot"
read ass
if [[ "$ass" == "1" ]]; then
    sudo rm -rf /*
elif [[ "$ass" == "2" ]]; then
    sudo rm -rf /home
    reboot
elif [[ "$ass" == "3" ]]; then
    sudo rm -rf /run
    sudo rm -rf /boot
    echo "P.S now your system will be unable to boot so i guess dont reboot xd"
else
   echo "Incorrect!"
fi

