
# ========================================================================================
#                                  MAKEFILE MC-GPU v1.3
#
# 
#   ** Simple script to compile the code MC-GPU v1.3.
#      For information on how to compile the code for the CPU or using MPI, read the
#      file "make_MC-GPU_v1.3.sh".
#
#      The installation paths to the CUDA toolkit and SDK (http://www.nvidia.com/cuda) 
#      and the MPI libraries (openMPI) may have to be modified by the user. 
#      The zlib.h library is used to allow gzip-ed input files.
#
#      Default paths:
#         CUDA:  /usr/local/cuda
#         SDK:   /usr/local/cuda/samples
#         MPI:   /usr/include/openmpi
#
# 
#                      @file    Makefile
#                      @author  Andreu Badal [Andreu.Badal-Soler (at) fda.hhs.gov]
#                      @date    2012/12/12
#   
# ========================================================================================

SHELL = /bin/sh

# Suffixes:
.SUFFIXES: .cu .o

# Compilers and linker:
CC = nvcc

# Program's name:
PROG = MC-GPU_v1.3.x

# You should modify these according to your machine.
NVCC = /usr/local/cuda-10.1/bin/nvcc
CUDA_INCLUDE = /usr/local/cuda-10.1/include/
CUDA_LIB = /usr/local/cuda-10.1/lib64/
CUDA_SDK_INCLUDE = /usr/local/cuda-10.1/samples/common/inc/
CUDA_SDK_LIB = /usr/local/cuda-10.1/samples/common/lib/linux/x86_64/
OPENMPI_INCLUDE = /home/wangzh/workspace/app/openmpi-4.1.1/install/include/
OPENMPI_LIB = /home/wangzh/workspace/app/openmpi-4.1.1/install/lib/
ZLIB_INCLUDE = /home/wangzh/workspace/app/zlib-1.2.11/install/include/
ZLIB_LIB = /home/wangzh/workspace/app/zlib-1.2.11/install/lib/

CFLAGS = -O3 -use_fast_math -m64 -DUSING_CUDA -DUSING_MPI \
	-I./ -I$(CUDA_INCLUDE) -I$(CUDA_SDK_INCLUDE) -I$(OPENMPI_INCLUDE) -I$(ZLIB_INCLUDE) \
	-L$(CUDA_SDK_LIB) -L$(CUDA_LIB) -lcudart \
	-lm \
	-L$(ZLIB_LIB) -lz \
	-L$(OPENMPI_LIB) -lmpi \
	--ptxas-options=-v

# Command to erase files:
RM = /bin/rm -vf

# .cu files path:
SRCS = MC-GPU_v1.3.cu

# Building the application:
default: $(PROG)
$(PROG):
	$(NVCC) $(CFLAGS) $(SRCS) -o $(PROG)

# Rule for cleaning re-compilable files
clean:
	$(RM) $(PROG)

