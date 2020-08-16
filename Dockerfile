FROM pandoc/latex:2.10

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
		tlmgr install beamertheme-metropolis pgfopts mdframed zref needspace \
		sourcesanspro sourcesanspro ly1 sourcecodepro titlesec pmboxdraw fvextra

WORKDIR /pandoc

# Add pandoc filter for emphasizing code in fenced blocks
# TODO: wait for musl-based Linux support of GHC
# https://github.com/commercialhaskell/stack/issues/2387
# RUN wget -qO- https://get.haskellstack.org/ | sh && \
# 		wget https://github.com/owickstrom/pandoc-emphasize-code/archive/master.zip && \
# 		unzip master.zip && \
# 		mv pandoc-emphasize-code-master emphasize-code && \
# 		cd emphasize-code && \
# 		stack setup && \
# 		stack install

RUN ls

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

