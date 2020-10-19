FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN apt update -y
RUN apt install -y tzdata
RUN apt install python3-pip git cmake ninja-build -y

WORKDIR /home

RUN pip3 install conan
RUN git clone https://github.com/nemtech/catapult-server.git --single-branch --branch v0.10.0.3 server

RUN cd server
RUN mkdir _build
RUN cd _build

RUN conan remote add nemtech https://api.bintray.com/conan/nemtech/symbol-server-dependencies

RUN apt install -y gcc-9 g++-9
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9

RUN conan install /home/server --build missing

RUN cmake -DUSE_CONAN=ON -DCMAKE_BUILD_TYPE=Release -G Ninja -DENABLE_TESTS=OFF /home/server

RUN ninja publish && ninja -j4

RUN mkdir -p /usr/catapult/bin /usr/catapult/lib /usr/catapult/deps

RUN cp -r bin/* /usr/catapult/bin
RUN cp -r lib/* /usr/catapult/lib
RUN cp -r deps/* /usr/catapult/deps