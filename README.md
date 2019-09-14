# Convert Markdown to Nearly Every Format

This container converts easy-to-read and -write Markdown to nearly every thinkable format (best used for presentations or documentations).

## Getting Started

### Build Container Yourself

Clone the Repository and enter the directory

```zsh
git clone https://github.com/kw90/pandoc-latex-docker.git
cd pandoc-latex-docker
```

Build container using docker command

```zsh
docker build -t pandoc-latex .
```

### Pull Container from Registry

Login to registry and pull container using

```zsh
docker pull kw90/pandoc-latex:latest
```

### Generate LaTeX Beamer PDF from README.md

Simply run `make slides` to generate a PDF from README.md called $DIRNAME.pdf. To change the input file and rename the output accordingly use the command `make file="INPUT.md"`. Use `make remove` and `make prune` to remove unused containers, images and volumes.

> **_NOTE:  In order to use the provided `Makefile` a recent `make` installation is required. For Debian distributions installing `build-essentials` is the easiest (e.g. `sudo apt-get install build-essentials` on Ubuntu). Installation from source can be done by reading through the README of the tarball downloaded from the [GNU Make Manual](https://www.gnu.org/software/make/manual/)._**

### Watch for Changes and Update on Save

The container comes with `watchexec`, which watches filetypes for changes. By default - as defined in the Makefile - it will just watch `.md` for changes. If a Markdown file is saved with changes, the `pandoc` command is triggered, updating the output file. 

To start watching a Markdown file in your project path, simply execute `make watch`, which will always generate an updated pdf of the modified and saved Markdown.


#### Without Make

To generate a PDF with name `PROJECT_NAME` run the following

```zsh
docker run --name pandoc-latex --volume `pwd`:/data -e OUTPUT_FILENAME=$(PROJECT_NAME) pandoc-latex
```

If a different input file than README.md should be used specify it using

```zsh
docker run --name pandoc-latex --volume `pwd`:/data pandoc-latex pandoc -t beamer "INPUT_FILE.md" -o "OUTPUT_FILE.pdf"
```

