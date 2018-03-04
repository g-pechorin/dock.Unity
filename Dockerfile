
# Peter LaValle / gmail.com


# stage("zoomship") {
# 	agent {
# 			dockerfile {
# 				// only execute on a Jenkins node labelled
# 				label 'amd64Docker'
#
# 				// use this Dockerfile
# 				dir 'ci/lin.Unity/2017.3.1f1/'
#
# 				// mount the project as the workspace
# 				args  '-v ${WORKSPACE}:/workspace'
# 			}
# 	}
# 	steps {
# 		dir ("zoomship.unity") {
# 			whatever commands you're using to build your Unity3D project
# 		}
# 	}
# }

FROM ubuntu:artful

# docker build -t unity-2017.3.1f1 .

# do the normal setup stuff
USER root
	RUN apt-get -qy install apt-utils
  RUN apt-get -y update && apt-get -y upgrade

# look at this!
	RUN apt-get -qy install \
    gconf-service \
    lib32gcc1 \
    lib32stdc++6 \
    libasound2 \
    libc6 \
    libc6-i386 \
    libcairo2 \
    libcap2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libfreetype6 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libglu1-mesa \
    libgtk2.0-0 \
    libnspr4 \
    libnss3 \
    libpango1.0-0 \
    libstdc++6 \
    libx11-6 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxtst6 \
    zlib1g \
    debconf \
    npm \
		libsoup2.4 \
		libarchive-dev

# make a folder we'll use
  RUN mkdir /opt/unity
	RUN mkdir /var/unity
  WORKDIR /var/unity

# install unity!
# https://forum.unity.com/threads/unity-on-linux-release-notes-and-known-issues.350256/page-2#post-3393668
# url: https://beta.unity3d.com/download/aea5ecb8f9fd/UnitySetup-2017.3.1f1
# sha: 065c7c75980dd57dc9b7113b2cd089e2ba2b9931
	ADD https://beta.unity3d.com/download/aea5ecb8f9fd/UnitySetup-2017.3.1f1 /var/unity/UnitySetup-2017.3.1f1
  #COPY UnitySetup-2017.3.1f1 /var/unity/UnitySetup-2017.3.1f1
  RUN chmod +=rwx ./UnitySetup-2017.3.1f1

# setup unity
  RUN echo 'y' | ./UnitySetup-2017.3.1f1 \
    --unattended \
    --install-location=/opt/unity \
    --download-location=/var/unity \
		&& rm -fr /var/unity/* \
		&& rm UnitySetup-2017.3.1f1
#
# reads:
# > Installation succeeded! Run 'cd /opt/unity/Editor; ./Unity'
#

# setup the user
	RUN adduser -D -h /var/unity -g unity unity
	RUN chown -R unity /var/unity

# my project is/was version'ed with Mercurial
	USER root
		RUN apt-get -qy install \
			mercurial

	USER unity
