============
Installation
============

Per nature where this package is intended for automated, production system, the resource in this package is to be used in "install" space.

Source build
============

Build the package by `catkin`:
::
   source /opt/ros/%ROS_DISTRO%/setup.bash
   catkin config --install
   catkin build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=%APP_INSTALL_DIR%

Usage
=====

Call the script from system daemon process. E.g. from within ``systemd`` process (replace ``%APP_INSTALL_DIR%`` with what you used upon installation above), add a line in ``/lib/systemd/system/%YOUR_SYSTEMD_SERVICE%.service` file:

::
   ExecStartPre=/bin/bash -c '%APP_INSTALL_DIR%/lib/wibu_tools/codemeter_init_check.sh'

EoF
