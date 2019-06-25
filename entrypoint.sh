#!/bin/sh

pandoc -t beamer README.md -o $OUTPUT_FILENAME.pdf
#pandoc --pdf-engine=xelatex -t beamer README.md -o $OUTPUT_FILENAME.pdf --variable mainfont='DejaVu Sans'

