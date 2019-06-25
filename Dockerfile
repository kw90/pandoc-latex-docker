FROM pandoc/latex

# Install WatchExec
RUN apk -U add cargo rust libgcc libstdc++ && \
		cargo install watchexec && \
		cp /root/.cargo/bin/watchexec /bin

# Install DejaVu Font
RUN apk --update add fontconfig ttf-dejavu

# Create Entrypoint Command
COPY entrypoint.sh /entrypoint.sh

ENV OUTPUT_FILENAME "readme"

ENTRYPOINT ["sh", "/entrypoint.sh"]

