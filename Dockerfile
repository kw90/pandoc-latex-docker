FROM pandoc/latex

# Install WatchExec
RUN apk add --no-cache cargo rust libgcc libstdc++ python3 graphviz openjdk8-jre && \
		cargo install watchexec && \
		cp /root/.cargo/bin/watchexec /bin

# Install DejaVu Font
RUN apk --update add fontconfig ttf-dejavu

RUN python3 -m ensurepip && \
		rm -r /usr/lib/python*/ensurepip && \
		pip3 install --no-cache --upgrade pip && \
		pip install pandoc-plantuml-filter

ADD plantuml.jar /opt/plantuml/

# Create Entrypoint Command
COPY entrypoint.sh /entrypoint.sh

ENV PLANTUML_BIN "java -jar /opt/plantuml/plantuml.jar"
ENV OUTPUT_FILENAME "readme"

ENTRYPOINT ["sh", "/entrypoint.sh"]

