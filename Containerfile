FROM ghcr.io/charles8191/rocky-bootc:r9
RUN --mount=type=bind,source=build.sh,destination=/build.sh,ro=false chmod +x /build.sh && /build.sh