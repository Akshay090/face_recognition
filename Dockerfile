FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu16.04

# Install face recognition dependencies

RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:deadsnakes/ppa

RUN apt-get update -y; apt-get install -y \
git \
cmake \
libsm6 \
libxext6 \
libxrender-dev

RUN apt-get install -y \
build-essential \
python3.6 \ 
python3.6-dev \ 
python3-pip \
python3.6-venv \
python3-setuptools

# update pip
RUN python3.6 -m pip install pip --upgrade
RUN python3.6 -m pip install wheel

RUN pip3 install scikit-build

# Install compilers

RUN apt install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt update -y; apt install -y gcc-6 g++-6

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 50
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 50

#Install dlib 

RUN git clone -b 'v19.16' --single-branch https://github.com/davisking/dlib.git
RUN mkdir -p /dlib/build

RUN cmake -H/dlib -B/dlib/build -DDLIB_USE_CUDA=1 -DUSE_AVX_INSTRUCTIONS=1
RUN cmake --build /dlib/build

RUN cd /dlib; python3.6 /dlib/setup.py install

# Install the face recognition package

RUN pip3 install face_recognition
