#!/bin/bash

## if [ -n $NM ]; then
##   Rscript -e "library(methods);library(knitr); knit('$NM.Rnw')"; latexmk -pdf $NM.tex
## fi



if [ -n $1 ]; then
  Rscript -e "library(methods);library(knitr); knit('$1.Rnw')"; latexmk -pdf $1.tex
fi
