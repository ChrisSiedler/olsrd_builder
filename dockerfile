# oldstable necesarry for build
FROM debian:oldstable-slim as build

MAINTAINER Christopher Siedler <mail@chris-siedler.at>

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
               build-essential dpkg-dev \
			debhelper bison flex pkg-config libgps-dev libgtk2.0-dev python-gtk2-dev liblua50-dev\
			git ca-certificates

RUN cd /opt &&\
	git clone https://github.com/OLSR/olsrd.git

WORKDIR /opt/olsrd
RUN git checkout release-0.9.7 &&\
	git remote add debbuild https://salsa.debian.org/debian/olsrd.git &&\
	git fetch debbuild &&\
	git checkout debbuild/master debian &&\
	echo "1.0" > debian/source/format

RUN dpkg-buildpackage -uc -us

WORKDIR /opt/

# =====================================================================================
# oldstable package also working with stable

#FROM debian:stable-slim
#MAINTAINER Christopher Siedler <mail@chris-siedler.at>


#COPY --from=build /opt/olsrd*.deb /opt/

#RUN dpkg -i /opt/olsrd_0.9.6.1-1_amd64.deb
#RUN rm /opt/*.deb

#CMD olsrd -i eth0 -d 1

