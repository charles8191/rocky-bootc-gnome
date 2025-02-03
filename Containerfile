FROM quay.io/almalinuxorg/almalinux-bootc:9.5
RUN --mount=type=bind,source=build.sh,destination=/build.sh bash /build.sh