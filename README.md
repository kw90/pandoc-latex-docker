# Container for converting Markdown to LaTeX Beamer PDF files for quick presentations

## Getting started

### Build container yourself

Clone the Repository and enter the directory

```zsh
git clone https://gitlab.enterpriselab.ch/mt-kawa/mt-docs/pandoc-latex-docker.git
cd pandoc-latex-docker
```

Build container using docker command

```zsh
docker build -t pandoc-latex .
```

### Pull container from registry

Login to registry and pull container using

```zsh
docker pull kw90/pandoc-latex:latest
```

### Generate LaTeX Beamer PDF from README.md

Simply run `make slides` to generate a PDF from README.md called $DIRNAME.pdf. To change the input file and rename the output accordingly use the command `make file="INPUT.md"`. Use `make remove` and `make prune` to remove unused containers, images and volumes.

> **_NOTE:  In order to use the provided `Makefile` a recent `make` installation is required. For Debian distributions installing `build-essentials` is the easiest (e.g. `sudo apt-get install build-essentials` on Ubuntu). Installation from source can be done by reading through the README of the tarball downloaded from the [GNU Make Manual](https://www.gnu.org/software/make/manual/)._**

#### Without Make

To generate a PDF with name `PROJECT_NAME` run the following

```zsh
docker run --name pandoc-latex --volume `pwd`:/data -e OUTPUT_FILENAME=$(PROJECT_NAME) pandoc-latex
```

If a different input file than README.md should be used specify it using

```zsh
docker run --name pandoc-latex --volume `pwd`:/data pandoc-latex pandoc -t beamer "INPUT_FILE.md" -o "OUTPUT_FILE.pdf"
```

