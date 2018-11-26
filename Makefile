RMDS = $(wildcard *.rmd)
RNWS = $(wildcard *.rnw)
SLIDES = $(patsubst %.rmd, %.pdf, $(RMDS))
SLIDES := $(SLIDES) $(patsubst %.rnw, %.pdf, $(RNWS))
TEX = $(patsubst %.rmd, %.tex, $(RMDS))
TEX := $(TEX) $(patsubst %.rnw, %.tex, $(RNWS))
# tex versions of the files, just to clean up

%.md: %.rmd
	Rscript -e "knitr::knit('$<', quiet=FALSE)"

%.pdf: %.md
	Rscript -e "rmarkdown::render('$<', output_format=\"all\")"

%.pdf: %.rnw
	Rscript -e "knitr::knit2pdf('$<', quiet=FALSE)"

all: $(SLIDES)

clean:
	rm -vf $(TEX) *.aux *.log *.nav *.out *.snm *.toc *.vrb *.rmd~
# -v : verbose
# -f: ignore non-existent files
