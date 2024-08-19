#!/bin/bash

# DEFAULT
DEFAULT_RESOLUTION="1024x768"
DEFAULT_DISPLAY_NUMBER=2
DEFAULT_DESKTOP_ENV="startxfce4"

function print_help {
  echo "Usage: $0 [-r resolution] [-d display_number] [-e desktop_environment]"
  echo "       $0 --help"
  echo
  echo "Options:"
  echo "  -r, --resolution           Screen resolution (e.g., 1280x720)"
  echo "  -d, --display-number       Display number (e.g., 2)"
  echo "  -e, --desktop-environment  Desktop environment to start (e.g., startxfce4)"
  echo "  --help                     Show this help message"
  echo
  echo "Example:"
  echo "  $0 -r 1280x720 -d 2 -e startxfce4"
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
    -e | --desktop-environment )
      shift
      DESKTOP_ENV=$1
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
DESKTOP_ENV=${DESKTOP_ENV:-$DEFAULT_DESKTOP_ENV}

if ! command -v Xephyr &> /dev/null; then
  echo "Error: Xephyr is not installed. Please install it first."
  exit 1
fi

if ! command -v $DESKTOP_ENV &> /dev/null; then
  echo "Error: Desktop environment '$DESKTOP_ENV' is not installed or not found."
  exit 1
fi

echo "Starting Xephyr on DISPLAY :$DISPLAY_NUMBER with resolution $RESOLUTION..."
Xephyr :$DISPLAY_NUMBER -resizeable -screen $RESOLUTION &

sleep 2

echo "Starting desktop environment: $DESKTOP_ENV..."
DISPLAY=:$DISPLAY_NUMBER $DESKTOP_ENV &

LOG_FILE="xephyr_$DISPLAY_NUMBER.log"
echo "Logging to $LOG_FILE..."
{
  echo "Xephyr started with the following settings:"
  echo "Resolution: $RESOLUTION"
  echo "Display Number: $DISPLAY_NUMBER"
  echo "Desktop Environment: $DESKTOP_ENV"
  echo "Timestamp: $(date)"
} >> $LOG_FILE

echo "Xephyr and $DESKTOP_ENV started successfully on DISPLAY :$DISPLAY_NUMBER."
echo "You can adjust the window size dynamically."
cat <<EOF
Powered by: EdwardLab/WSL-Desktop (https://github.com/EdwardLab/WSL-Desktop)
MIT LICENSE
EOF