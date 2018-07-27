FROM debian:stretch-slim

# Get Dependencies
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y --no-install-recommends apt-utils 
RUN apt-get -y install \
	build-essential pkg-config libc6-dev m4 g++-multilib \
	autoconf libtool ncurses-dev unzip git python python-zmq \
	zlib1g-dev wget curl bsdmainutils automake

# Build
RUN git clone https://github.com/zcash/zcash.git --branch v1.1.2 /tmp/coin-daemon
WORKDIR /tmp/coin-daemon
RUN ./zcutil/fetch-params.sh
RUN ./zcutil/build.sh -j$(nproc)

RUN mkdir -p /coin/data

WORKDIR /coin
RUN cp /tmp/coin-daemon/src/zcashd ./daemon
RUN cp /tmp/coin-daemon/src/zcash-cli ./cli

EXPOSE 3000
EXPOSE 3001
CMD ./daemon --datadir=/coin/data
