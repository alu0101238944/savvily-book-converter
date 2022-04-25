#!/bin/sh
set -e
. ./src/scripts/manuscriptFormatter.sh

mkdir -p output && cd .tmp-manuscript

formattedManuscript=$(manuscriptFormatter "ebook")

# Run Pandoc on formatted input
echo "$formattedManuscript" | timeout 600 pandoc \
    --epub-embed-font=/usr/share/fonts/Roboto-Bold.ttf \
    --css ../src/templates/mobi/epub.css \
    --epub-cover-image ./resources/book-cover-print.png \
    -o ./../output/ebook.epub \
    --metadata-file ../src/templates/epub/metadata.yml && \

ebook-convert ./../output/ebook.epub ./../output/ebook.mobi

echo "MOBI successfully generated"
