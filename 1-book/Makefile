#------------------------------------------------------------------------------#

# List of all subderectories
SUBDIRS=`find -mindepth 1 -maxdepth 1 -type d -not -name '.*' -not -name '_*'`

TEX_FILES=MatematicaBasica.tex
PDF_FILES=$(TEX_FILES:.tex=.pdf)
NON_FILES=$(TEX_FILES:.tex=)

all: $(PDF_FILES)

LATEX := >/dev/null 2>&1 latexmk -pdf -silent

%.pdf: %.tex \
       $(wildcard *.tex) \
       $(wildcard *.cls) \
       $(wildcard *.sty) \
       $(wildcard *.bib)
	${LATEX} $<

.PHONY: clean
clean:
	@ rm -vf *~ .*~  *.bak \
      *.aux *.bbl *.blg *.lof *.log *.lot *.out *.toc  \
      *.bcf *.run.xml .*.sw? *.synctex.gz *.txss *.idx \
      *.ilg *.ind *.lod *.mtc* *.fdb_latexmk *.fls *.maf
	@ for D in $(SUBDIRS) ; do make -C $$D clean ; done

.PHONY: distclean
distclean: clean
	@ rm -vf $(PDF_FILES)
	@ rm -vf _sandbox.pdf _exercises.pdf

#------------------------------------------------------------------------------#
