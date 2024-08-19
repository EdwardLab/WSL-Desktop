# WSL-Desktop
Running Native Linux Desktop Environment on Windows (WSL2 Only), ChromeOS

WSL native display, support for dynamically adjusted windows (resizeable), sound and 3D support, based on Xephyr    

# Usage
```bash
./wd.sh [-r resolution] [-d display_number] [-x xstartup] [--help]
```
Example:
```
./wd.sh -r 1280x720 -d 2 -x startxfce4
```
## Default Value
Edit wd.sh:
```
# DEFAULT
DEFAULT_RESOLUTION="1024x768"
DEFAULT_DISPLAY_NUMBER=2
DEFAULT_DESKTOP_ENV="startxfce4"
```
