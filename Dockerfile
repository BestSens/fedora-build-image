FROM fedora:40
RUN curl -fsSL https://rpm.nodesource.com/setup_22.x | bash -
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
	libmodbus-devel \
	boost \
	boost-devel \
	nodejs && \
	dnf clean all && rm -rf /var/cache/yum