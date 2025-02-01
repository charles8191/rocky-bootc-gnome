FROM ghcr.io/charles8191/rocky-bootc:r9
RUN --type=bind,source=build.sh,destination=/build.sh chmod +x /build.sh && /build.sh