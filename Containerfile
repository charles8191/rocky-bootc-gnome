FROM ghcr.io/charles8191/rocky-bootc:r9
RUN --mount=type=bind,source=build.sh,destination=/build.sh bash /build.sh