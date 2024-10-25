# Use SLES 15 as the base image
#FROM registry.suse.com/suse/sles15:latest
#FROM registry.suse.com/suse/sle15:15.6
FROM registry.suse.com/suse/sle15:15.6.47.11.17

ENV LD_LIBRARY_PATH /usr/local/lib

# Install necessary packages
RUN zypper refresh && \
    zypper install -y tcl tk zlib-devel gcc make awk procps which vim redis && \
    zypper clean -a

RUN curl -O https://www.python.org/ftp/python/3.10.14/Python-3.10.14.tgz && \
    tar xvf Python-3.10.14.tgz && rm -f Python-3.10.14.tgz && \
    cd Python-3.10.14 && \
    ./configure --enable-shared --prefix=/usr/local && \
    make -j 6 && make -j 6 altinstall && \
    ln -s /usr/local/bin/python3.10 /usr/local/bin/python

    
# Expose Redis port
EXPOSE 6379

# Run Redis server
CMD ["redis-server", "--protected-mode", "no"]

