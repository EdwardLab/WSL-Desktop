#!/bin/bash

# DEFAULT
DEFAULT_RESOLUTION="1024x768"
DEFAULT_DISPLAY_NUMBER=2
DEFAULT_XSTARTUP="startxfce4"

function print_help {
  echo "Usage: $0 [-r resolution] [-d display_number] [-x xstartup]"
  echo "       $0 --help"
  echo
  echo "Options:"
  echo "  -r, --resolution    Screen resolution (e.g., 1280x720)"
  echo "  -d, --display-number       Display number (e.g., 2)"
  echo "  -x, --xstartup      Startup command to launch (e.g., startxfce4)"
  echo "  --help              Show this help message"
  echo
  echo "Example:"
  echo "  $0 -r 1280x720 -d 2 -x startxfce4"
}

while [[ "$1" != "" ]]; do
  case $1 in
    -r | --resolution )
      shift
      RESOLUTION=$1
      ;;
    -d | --display-number )
      shift
      DISPLAY_NUMBER=$1
      ;;
    -x | --xstartup )
      shift
      XSTARTUP=$1
      ;;
    --help )
      print_help
      exit 0
      ;;
    * )
      echo "Invalid option: $1"
      print_help
      exit 1
      ;;
  esac
  shift
done

RESOLUTION=${RESOLUTION:-$DEFAULT_RESOLUTION}
DISPLAY_NUMBER=${DISPLAY_NUMBER:-$DEFAULT_DISPLAY_NUMBER}
XSTARTUP=${XSTARTUP:-$DEFAULT_XSTARTUP}

if ! command -v Xephyr &> /dev/null; then
  echo "Error: Xephyr is not installed. Please install it first."
  exit 1
fi

if ! command -v $XSTARTUP &> /dev/null; then
  echo "Error: Startup command '$XSTARTUP' is not installed or not found."
  exit 1
fi

echo "Starting Xephyr on DISPLAY :$DISPLAY_NUMBER with resolution $RESOLUTION..."
Xephyr :$DISPLAY_NUMBER -resizeable -screen $RESOLUTION &

sleep 2

echo "Starting startup command: $XSTARTUP..."
DISPLAY=:$DISPLAY_NUMBER $XSTARTUP &

echo "Xephyr and $XSTARTUP started successfully on DISPLAY :$DISPLAY_NUMBER."
echo "You can adjust the window size dynamically."
cat <<EOF
WSL-Desktop, 
Powered by: EdwardLab/WSL-Desktop (https://github.com/EdwardLab/WSL-Desktop)
MIT LICENSE
EOF
