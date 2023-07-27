FROM fedora:38 as builder
RUN dnf install -y \
	gcc \
	g++ \
	wget \
	openssl-devel
RUN mkdir /root/Temp && cd /root/Temp
RUN wget https://boostorg.jfrog.io/artifactory/main/release/1.82.0/source/boost_1_82_0.tar.gz -P /root/Temp && \
	tar -xzf /root/Temp/boost_1_82_0.tar.gz -C /root/Temp && \
	cd /root/Temp/boost_1_82_0 && \
	./bootstrap.sh && \
	./b2 install --without-python
RUN rm -Rf /root/Temp

FROM fedora:38
RUN dnf install -y \
	cmake \
	git \
	ninja-build \
	samurai \
	ccache \
	gcc \
	g++ \
	libasan \
	libubsan \
	clang-tools-extra \
	openssl-devel \
	libmodbus-devel
RUN dnf clean all && rm -rf /var/cache/yum

# install boost from builder image
COPY --from=builder /usr/local/lib/libboost* /usr/local/lib/
COPY --from=builder /usr/local/lib/cmake/ /usr/local/lib/cmake/
COPY --from=builder /usr/local/include/boost/ /usr/local/include/boost/