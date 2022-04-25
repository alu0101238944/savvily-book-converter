FROM pandoc/latex:latest

# Install latex libraries
RUN tlmgr update --self \
    && tlmgr install pdfpages  \
    && tlmgr install tocloft  \
    && tlmgr install emptypage  \
    && tlmgr install footmisc  \
    && tlmgr install titlesec  \
    && tlmgr install wallpaper  \
    && tlmgr install roboto  \
    && tlmgr install incgraph  \
    && tlmgr install tcolorbox  \
    && tlmgr install environ  \
    && tlmgr install eso-pic \
    && tlmgr install datatool
RUN apk add sed
RUN apk add ghostscript

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/calibre/lib
ENV PATH $PATH:/opt/calibre/bin
ENV CALIBRE_INSTALLER_SOURCE_CODE_URL https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py
RUN apk update && \
    apk add --no-cache --upgrade \
    bash \
    ca-certificates \
    gcc \
    mesa-gl \
    python3 \
    qt5-qtbase-x11 \
    wget \
    xdg-utils \
    xz && \
    wget -O- ${CALIBRE_INSTALLER_SOURCE_CODE_URL} | python3 -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)" && \
    rm -rf /tmp/calibre-installer-cache

RUN which calibre

# Install JetBrains Mono font
RUN mkdir -p /usr/share/fonts/
COPY src/JetBrains_Mono/static/*.ttf /usr/share/fonts/
COPY src/Roboto/*.ttf /usr/share/fonts/
RUN fc-cache -f && rm -rf /var/cache/*
ENTRYPOINT ["sh"]
