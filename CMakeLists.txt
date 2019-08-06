cmake_minimum_required(VERSION 2.8.3)
project(wibu_tools)

find_package(catkin REQUIRED)

catkin_package(
)

install(FILES
  # myfile1
  # myfile2
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)
