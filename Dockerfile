FROM boot2docker/boot2docker
MAINTAINER dan@typeamachines.com

# Make the binfmt_misc pseudo-filesystem available at boot.
RUN echo "binfmt_misc /proc/sys/binfmt_misc	defaults 0 0" >> $ROOTFS/etc/fstab

# Install qemu-arm and its dependencies.
ENV TCZ_DEPS qemu-arm \
			   SDL libmad \
			   glib2 libffi \
			   libusb udev-lib \
			   ncurses ncurses-common \
 			   pixman \
			 qemu-common

RUN for dep in $TCZ_DEPS; do \
    echo "Download $TCL_REPO_BASE/tcz/$dep.tcz" && \
        curl -L -o /tmp/$dep.tcz $TCL_REPO_BASE/tcz/$dep.tcz && \
        unsquashfs -f -d $ROOTFS /tmp/$dep.tcz && \
        rm -f /tmp/$dep.tcz ; \
    done

# Register arm binary format at boot.
COPY ./register_binfmt_arm /etc/rc.d/

# Default command is to generate the iso and stream it to stdout.
RUN /make_iso.sh
CMD ["cat", "boot2docker.iso"]
