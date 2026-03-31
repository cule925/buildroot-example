FROM debian:13.4

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Arguments for UID/GID matching
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USERNAME=builder

# Install required packages with explicit versions
RUN apt-get update && apt-get install -y \
	which \
	sed \
	make \
	binutils \
	build-essential \
	diffutils \
	gcc \
	g++ \
	bash \
	patch \
	gzip \
	bzip2 \
	perl \
	tar \
	cpio \
	unzip \
	rsync \
	file \
	bc \
	findutils \
	gawk \
	wget \
	python3 \
	bzr \
	curl \
	cvs \
	git \
	mercurial \
	openssh-client \
	subversion \
	ca-certificates \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Create user matching host UID/GID
RUN groupadd -g ${GROUP_ID} ${USERNAME} \
	&& useradd -m -u ${USER_ID} -g ${GROUP_ID} -s /bin/bash ${USERNAME}

# Set working directory
WORKDIR /workspace

# Switch to non-root user
USER ${USERNAME}

# Default command: run build script
CMD ["bash", "-c", "./make_buildroot.sh build"]
