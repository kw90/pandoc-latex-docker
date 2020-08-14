FROM pandoc/latex

# Install WatchExec
RUN apk add --no-cache cargo rust libgcc libstdc++ python3 graphviz openjdk8-jre && \
		cargo install watchexec && \
		cp /root/.cargo/bin/watchexec /bin

# Install DejaVu Font
RUN apk --update add fontconfig ttf-dejavu npm inkscape

RUN python3 -m ensurepip && \
		rm -r /usr/lib/python*/ensurepip && \
		pip3 install --no-cache --upgrade pip && \
		pip install pandoc-plantuml-filter pygments

RUN tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet && \
		tlmgr update --all && \
		tlmgr install beamertheme-metropolis pgfopts

WORKDIR /pandoc

RUN pwd
# Install Emojis Filter
RUN wget https://github.com/kw90/Pandoc-Emojis-Filter/archive/master.zip && \
		unzip master.zip && \
		mv Pandoc-Emojis-Filter-master emoji-filter && \
		cd emoji-filter && \
		npm install -g

ADD plantuml.jar /opt/plantuml/

# Create Entrypoint Command
COPY entrypoint.sh /entrypoint.sh

WORKDIR /pandoc/data

ENV PLANTUML_BIN "java -jar /opt/plantuml/plantuml.jar -tsvg"
ENV OUTPUT_FILENAME "readme"

ENTRYPOINT ["sh", "/entrypoint.sh"]

