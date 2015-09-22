cmake_minimum_required(VERSION 2.8)
project(dojo_cuda)

find_package(CUDA REQUIRED)
#cuda_compile(HELPER_O helper.cu)
#cuda_compile(DRIVER_O driver.cu OPTIONS -G)

################################################################################
#PACKAGES
find_package(CUDA REQUIRED)
################################################################################
#INCLUDES
include_directories(
	include
	${CUDA_INCLUDE_DIRS}
)
################################################################################
#SOURCES
file(GLOB DOJO_CUDA_SOURCES_CPP "src/*.cpp")
file(GLOB DOJO_CUDA_SOURCES_CU "src/*.cu")
################################################################################
#LINK
LIST(APPEND LINK_LIBS
	${CUDA_LIBRARIES}
)
################################################################################
#EXECUTABLE
cuda_add_executable(${PROJECT_NAME} ${DOJO_CUDA_SOURCES_CPP} ${DOJO_CUDA_SOURCES_CU})
target_link_libraries(${PROJECT_NAME} ${LINK_LIBS})
