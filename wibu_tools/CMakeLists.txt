cmake_minimum_required(VERSION 2.8.3)
project(wibu_tools)

find_package(catkin REQUIRED)

catkin_package(
)

install(PROGRAMS scripts/codemeter_init_check.sh
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
