# -----------------------------------------------------------------
#        File: Makefile
# Description: Builds thesis.pdf
#      Author: Andrew Parlane
# -----------------------------------------------------------------

# This file is part of https://github.com/andrewparlane/fiuba_thesis
# Copyright (c) 2022 Andrew Parlane.
#
# This is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free
# Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this code. If not, see <http://www.gnu.org/licenses/>.

# Note: This thesis was written and compiled using overleaf
#       Building it via pdflatex has been tested, but not extensively

# Note: This makefile was tested using windows 10 + cygwin with the texlive package
#		Some of the texlive-collection packages are needed to, although I can't guarantee
#		that this list is complete, nor that all are required.
#			basic
#			bibtexextra
#			fonstextra
#			fontsrecommended
#			langspanish
#			latex
#			latexextra
#			latexrecommended
#			mathscience
#			pictures

SOURCES = 	thesis.tex 			\
			packages.tex 		\
			settings.tex 		\
			bibliography.bib	\
			$(wildcard img/*.*)

PDFLATEX_ARGS = -output-directory out

all: thesis

thesis.pdf: $(SOURCES)
	mkdir -p out
	pdflatex $(PDFLATEX_ARGS) thesis.tex
	# pdflatex asks me to run biber thesis
	# then rerun pdflatex
	biber --input-directory out --output-directory out thesis
	pdflatex $(PDFLATEX_ARGS) thesis.tex
	# pdflatex needs another rerun?
	pdflatex $(PDFLATEX_ARGS) thesis.tex
	mv out/thesis.pdf .

thesis: thesis.pdf

.PHONY: thesis

clean:
	rm -rf out/

.PHONY: clean
