## File:    r-rules.mk - to be included in Makefile(s)
## Purpose: Define gnu make rules for R, Sweave, knitr, rmarkdown, sas,
##          stata, PSPP, python, perl
##
## Licence: GPLv3 see <http://www.gnu.org/licenses/>
##
## Version: 0.2.9012
## Usage: Place file in a directory such as ~/lib and include with
##         include ~/lib/r-rules.mk
##         at the bottom of Makefile (or adjust for your directory of choice)
##         To override any definitions place them after the include statement
## NB: if using makepp then ~ is not recognized but the following is OK
##         include ${HOME}/lib/r-rules.mk
##
##   The latest version of this file is available at
##   https://github.com/petebaker/r-makefile-definitions

## For help after including r-rules.mk in Makefile: run
##         $  make help

## use knitr or sweave for processing .Rnw files --------------------

## Default: knitr which works when blank
## SWEAVE_ENGINE=
## SWEAVE_ENGINE=Sweave

## NB: you can change the default to Sweave below and use SWEAVE_ENGINE=knitr
##     in the odd Makefile where all pdfs produced using knitr

## You can uncomment one of these lines to make the change permanent
## but then you CAN NOT override it in Makefile

## Alternatively, leave SWEAVE_ENGINE unset and specify the targets
## SWEAVE_PDF:  list of pdf files for processing with Sweave
## KNITR_PDF:   list of pdf files for processing with knitr
## KNITR_HTML:  list of  html files for processing with knitr

## Not implemented yet
## would need some html example files to use 
## SWEAVE_HTML: list of html files for processing with Sweave/R2HTML

## other files - eg rst, odfWeave, html via sweave etc etc??

## END: use knitr or sweave for processing .Rnw files --------------------

## Changelog: None recorded until Frid 2015-02-06 at 15:40:21
##          On Frid 2015-02-06
##            1) Added Rmarkdown rules
##               run $ make help-rmarkdown
##            2) Added stitch rules
##          Sat 2015-03-28 at 20:48:20
##            1) added version
##            2) added git and rsync targets
##            3) fixed some knitr/rmarkdown targets
##          2015-06-16 at 08:50:37
##            1) Added rmarkdown pdf options to drop pdfcrop etc
##          2015-09-07 at 17:55:27
##            1) fixed 'make help-r' which referred to myFile.R rather
##               than .Rout
##            2) added link to blog site
##          2016-05-19 at 11:58:34
##            1) modified beamer from .Rnw to be more generic
##            2) added beamer example and preamble .Rnw files
##          2016-06-19 at 23:27:34
##            1) added in various 'rmarkdown' outputs like ioslides,
##               slidy, beamer, tufte, rtf, odt
##          2016-06-23 at 16:23:57 (Version 0.2.9004)
##            1) fixed Rscript --vanilla R CMD --vanilla bug for latexmk
##            2) added variables for programs like cat, rm, pdfjam,
##               latexmk to include PROG_OPTS to set options
##               and LATEXMK_PRE which can be prepended to latex
##            3) changed outputting R syntax from .Rmd and .Rnw files
##               to produce -syntax.R to avoid dependency loops where
##               a .tex file then .pdf might be produced instead
##               of using rmarkdown
##          Wed Sep 28 16:43:09 AEST 2016 (Version 0.2.9005)
##            1) moved common.mk to r-rules.mk to better identify rules
##            2) added markdown options RMARKDOWN_HTML_OPTS and
##               RMARKDOWN_DOCX_OPTS
##            3) added a .r dependency for .Rout files
##         Sunday 2016-11-13 at 20:33:24 - Version 0.2.9006
##            1) added Graham-Cumming (2015) multiple target functions
##               sentinel and atomic for multiple targets
##               NB: Still need to add help, document and redo examples
##         Saturday 2017-06-03 at 10:05pm - Version 0.2.9007
##            1) Added SAS, STATA, PSPP
##            2) Added python and perl
##            NB: SAS, STATA, PSPP only simple testing on Windows/macOS
##         Friday 2017-06-30 12:30am - Version 0.2.9008
##            1) puts function definitions into separate file to define
##               functions at the start separately and override in Makefile
##               New File:  r-rules-functions.mk
##            2) added complex-demo recursive and non-recursive make examples
##         Wednesday 2017-09-13 at 17:35:43 - Version 0.2.9009
##            1) added a second remote destination for rsync
##            2) added post rsync variable RSYNC_FLAGS_POST for extra
##               flexibility
##         Tuesday 2018-07-31 at 16:43:43 - Version 0.2.9010
##            1) Added back Sweave because not everyone uses knitr
##               NB: needs more work - initial idea only
##                   Also, needs HTML etc output added which will be an
##                   RSCRIPT call rather than command line processing
##         Friday August 10 18:40 Version 0.2.9010
##           1) added SWEAVE_ENGINE pdf using Sweave rules
##         Friday August 17 2018-08-17 at 17:34:32
##           1) Added SWEAVE_ENGINE option for Sweave and commented knitr eqiv
##         Tuesday August 21 2018-08-21 at 13:21:02- Version 0.2.9012
##           1) added extra variables SWEAVE_PDF, KNITR_PDF etc to process
##              .Rnw files from both knitr and sweave format files from
##              same Makefile
##              along with help-sweave and help-knitr etc targets

## EXTRA 1) proper documentation            2015-02-21 at 23:41:44
##       2) make knit more system independent
##          PARTIALLY DONE 2015-03-29 at 09:37:41
##          DONE 2016-06-19 at 18:45:02
##       3) generic clean/backup needs work (see just before multiple targets)

## For .Rnw files I've changed the default to knit as that's what I
## usually want but to use Sweave then set SWEAVE_ENGINE to Sweave or
## uncomment appropriate lines below
## KNIT now called inside Rscript
## but could be changed if this way preferred
## note - may need to use this (or similar) instead if knit is not in path
## KNIT     = knit
## KNIT     = /usr/lib/R/site-library/knitr/bin/knit
## KNIT     = /usr/lib/R/library/knitr/bin/knit
## KNIT     = /usr/lib64/R/library/knitr/bin/knit
## KNIT_FLAGS = -n -o
## %.md: %.Rmd
##	${KNIT} $@ ${KNIT_OPTS} $<

## program defs - may prefer gmake for macOS
##MAKE      = make
##MAKE      = gmake

## general help -----------------------------------------------------

.PHONY: help
help:
	@echo Simple help can be obtained with
	@echo ""
	@echo make help-r
	@echo make help-stitch
	@echo make help-rmarkdown
	@echo make help-knitr
	@echo make help-sweave
	@echo make help-both-sweave-knitr
	@echo make help-stats-others
	@echo make help-beamer
	@echo make help-rsync
	@echo make help-git

# latex variables ---------------------------------------------------

## can be used to convert simple latex to .rtf file for MS word
LATEX2RTF     = latex2rtf

## cross platform way to run latex but may also run through R
## LATEXMK_PRE   = ${R} CMD ${R_OPTS}
LATEXMK_PRE   =
LATEXMK       = latexmk
LATEXMK_OPTS = -pdf
LATEXMK_CLEAN = -c

## rubber - latexmk alternative on linux systems only
RUBBER    = $(R) CMD rubber
RUB_FLAGS = -d

## specific program variables - may need to redefine on other systems
RM       = rm
RM_OPTS  = -f
MV       = mv
MV_OPTS  = -f
CAT      = cat
CAT_OPTS =
PDFJAM   = pdfjam
PDFJAM_OPTS=

## git variables ---------------------------------------------------

GIT_REMOTE = master
## GIT_REMOTE = ssh://pete@192.168.0.1:port/git.repository
GIT_ORIGIN = origin
GIT = git
GIT_FLAGS = -a

## pandoc variables ---------------------------------------------

PANDOC = pandoc
PANDOC_OPTS = -s

## R variables ---------------------------------------------

R         = R
R_FLAGS   = CMD BATCH
R_OPTS    = --vanilla
RSCRIPT   = Rscript
RSCRIPT_OPTS = --vanilla
##R_OPTS    = --no-save --no-restore --no-restore-history --no-readline
RSWEAVE    = $(R) CMD Sweave
RSWEAVE_FLAGS=
RSWEAVE_CLEAN=yes
## RSWEAVE_CLEAN=
RSTANGLE = $(R) CMD Stangle
RSTANGLE_FLAGS=

## --------------------------------------------------------------
## R and Rmarkdown ----------------------------------------------
## --------------------------------------------------------------


## R pattern rules -------------------------------------------------
.PHONY: help-r
help-r:
	@echo Just one major rule to produce .Rout but can stitch .R file too
	@echo ""
	@echo $$ make myFile.Rout
	@echo will produce 'myFile.Rout' using R CMD BATCH --vanilla myFile.R
	@echo but you can change options with something like
	@echo $$ R_OPTS=--no-restore-history make myFile.Rout
	@echo ""
	@echo To stitch file \(like RStudio\) just choose any or all of:
	@echo make myFile.pdf
	@echo make myFile.docx
	@echo make myFile.html
	@echo NB: This assumes you don\'t have files like myFile.\{Rmd,Rnw,tex\} etc present,
	@echo "    only 'myFile.R'"
	@echo "    So good practice is to use different (base)names for reports and analysis"
	@echo ""
	@echo "    Type 'make help-stitch' for details of other output formats."

## produce .Rout from .R file --------------------------------------

## Running R to produce text file output
## If you want to see start and end time on a linux system uncomment
##  the echo lines 
%.Rout: %.R
##	@echo Job $<: started at `date`
	${R} ${R_FLAGS} ${R_OPTS} $< 
##	@echo Job $<: finished at `date`
%.Rout: %.r
##	@echo Job $<: started at `date`
	${R} ${R_FLAGS} ${R_OPTS} $< 
##	@echo Job $<: finished at `date`

## stitch an R file using knitr --------------------------------------

## I find that rmarkdown seems to be a better option than knitr  
## both on CRAN now so easy to install

## RMARKDOWN_PDF_OPTS = (fig_crop=FALSE, fig_caption = TRUE) # default fig_capt
RMARKDOWN_PDF_OPTS = (fig_crop=FALSE)
RMARKDOWN_HTML_OPTS = ()
RMARKDOWN_DOCX_OPTS = ()
RMARKDOWN_ODT_OPTS = ()
RMARKDOWN_RTF_OPTS = ()

.PHONY: help-stitch
help-stitch:
	@echo To stitch file \(like RStudio\) from a .R file, just do one of the following:
	@echo make myFile.pdf
	@echo make myFile.docx
	@echo make myFile.html
	@echo make myFile.odt
	@echo make myFile.rtf
	@echo " "
	@echo Variables: RMARKDOWN_PDF_OPTS has default \(fig_crop=FALSE\)
	@echo "           RMARKDOWN_HTML_OPTS, RMARKDOWN_DOCX_OPTS, RMARKDOWN_ODT_OPTS,"
	@echo "           RMARKDOWN_RTF_OPTS have default ()"
	@echo " "
	@echo NB: This assumes you don\'t have files like myFile.\{Rmd,Rnw,tex\} etc present,
	@echo "    only 'myFile.R' So good practice is to use different"
	@echo "    file (base)names for reports and analysis"

## pdf output
%.pdf: %.R
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.pdf=.R}\", pdf_document${RMARKDOWN_PDF_OPTS})"
%.pdf: %.r
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.pdf=.r}\", pdf_document${RMARKDOWN_PDF_OPTS})"
## html output
%.html: %.R
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.html=.R}\", html_document${RMARKDOWN_HTML_OPTS})"
%.html: %.r
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.html=.r}\", html_document${RMARKDOWN_HTML_OPTS})"
## word doc output
%.docx: %.R
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.docx=.R}\", word_document${RMARKDOWN_DOCX_OPTS})"
%.docx: %.r
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.docx=.r}\", word_document${RMARKDOWN_DOCX_OPTS})"
## open (libre) office output
%.odt: %.R
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.odt=.R}\", odt_document${RMARKDOWN_ODT_OPTS})"
%.odt: %.r
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.odt=.r}\", odt_document${RMARKDOWN_ODT_OPTS})"
## rich text rtf output
%.rtf: %.R
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.rtf=.R}\", rtf_document${RMARKDOWN_RTF_OPTS})"
%.rtf: %.r
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.rtf=.r}\", rtf_document${RMARKDOWN_RTF_OPTS})"


## knit and rmarkdown pattern rules ----------------------------------

## produce R syntax from .Rmd files - Note that .Rnw files in knitr section
## %-syntax.R: %.Rmd
##	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(knitr);purl(\"${@:.R=.Rmd}\")"
## %-syntax.R: %.rmd
##	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(knitr);purl(\"${@:.R=.rmd}\")"

%-syntax.R: %.Rmd
	${RSCRIPT} ${RSCRIPT_OPTS}  -e 'library(knitr);purl("$<", out="$@")'
%-syntax.R: %.rmd
	${RSCRIPT} ${RSCRIPT_OPTS}  -e 'library(knitr);purl("$<", out="$@")'


## wonder if this would cause a conflict with rmarkdown - shouldn't as
## long as R markdown rules come after this and possible override with
## explicit definitions? UPSHOT: THIS CONFLICTS BADLY - DON'T DO THIS
## %.md: %.Rmd
## 	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(knitr);knit(\"${@:.md=.Rmd}\")"
## %.md: %.rmd
## 	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(knitr);knit(\"${@:.md=.rmd}\")"

## ## pandoc pattern rules 
## %.pdf: %.md
## 	${PANDOC} ${PANDOC_OPTS} $< -o $@
## %.docx: %.md
## 	${PANDOC} ${PANDOC_OPTS} $< -o $@
## %.html: %.md
## 	${PANDOC} ${PANDOC_OPTS} $< -o $@
## %.tex: %.md
# # 	${PANDOC} ${PANDOC_OPTS} $< -o $@


## Uses latex2rtf but perhaps should use markdown/pandoc as better result 
%.rtf: %.tex
	${LATEX2RTF} ${L2R_FLAGS} ${@:.rtf=}

## Rmarkdown pattern rules  --------------------------------------------------

## generating pdf, docx, html other from Rmarkdown/sweave
## Note: $< does not appear to work whereas ${@:.pdf=.Rmd} does even
##       though I think they should be identical

.PHONY: help-rmarkdown
help-rmarkdown:
	@echo ""
	@echo "Using R Markdown/knitr to automatically produce output from .Rmd"
	@echo ''
	@echo Rules to make output using $$ make myFile.XXX:
	@echo "    .pdf (via latex)"
	@echo "    .html"
	@echo "    .docx (Microsoft Word)"
	@echo "    .odt (open/libre office document)"
	@echo "    .rtf (rich text format)"
	@echo "    BASENAME_ioslides.html from BASENAME.Rmd eg $$ make myFile_ioslides.html"
	@echo "    BASENAME_slidy.html from BASENAME.Rmd"
	@echo "    BASENAME_beamer.pdf from BASENAME.Rmd (beamer presentation)"
	@echo "    BASENAME_tufte.pdf from BASENAME.Rmd (tufte beamer handouts)"
	@echo ""
	@echo NB: You can easily set up a .PHONY target in \'Makefile\' to produce all
	@echo "    output format files specified at the top of the .Rmd file"
	@echo "    Set up a phony target with something like"
	@echo "      .PHONY: rmarkdown-all"
	@echo "      rmarkdown-all: myfile.Rmd"
	@echo "    then typing the following at the command prompt"
	@echo '    $$ make rmarkdown-all'
	@echo "    produces all formats defined in YAML header for 'myfile.Rmd'"
	@echo ""
	@echo "   Finally, BASENAME-syntax.R: produces R syntax file tangled from Rnw using knit"
	@echo "   Type 'make help-stitch' for details of variables"


## .pdf from .Rmd (via latex)
%.pdf: %.Rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.pdf=.Rmd}\", pdf_document${RMARKDOWN_PDF_OPTS})"
%.pdf: %.rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.pdf=.rmd}\", pdf_document${RMARKDOWN_PDF_OPTS})"
## uncomment next line if required for debugging latex although could also use
##                clean = FALSE in RMARKDOWN_PDF_OPTS to see .log file
## .PRECIOUS: .tex 

## Note: html and docx added options for general setting Wed Sep 28 16:43:09
## Was
##%.html: %.Rmd
##	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.html=.Rmd}\", \"html_document\")"

## .html from .Rmd
%.html: %.Rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.html=.Rmd}\", html_document${RMARKDOWN_HTML_OPTS})"
%.html: %.rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.html=.rmd}\", html_document${RMARKDOWN_HTML_OPTS})"

## .docx from .Rmd
%.docx: %.Rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.docx=.Rmd}\", word_document${RMARKDOWN_DOCX_OPTS})"
%.docx: %.rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.docx=.rmd}\", word_document${RMARKDOWN_DOCX_OPTS})"

## open office/libre office document format
%.odt: %.Rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.odt=.Rmd}\", odt_document${RMARKDOWN_ODT_OPTS})"
%.odt: %.rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.odt=.rmd}\", odt_document${RMARKDOWN_ODT_OPTS})"

## rich text format from rmd
%.rtf: %.Rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.rtf=.Rmd}\", rtf_document${RMARKDOWN_RTF_OPTS})"
%.rtf: %.rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:.rtf=.rmd}\", rtf_document${RMARKDOWN_RTF_OPTS})"

## ioslides presentation
%_ioslides.html: %.Rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:_ioslides.html=.Rmd}\", \"ioslides_presentation\", output_file = \"$@\")"
%_ioslides.html: %.rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:_ioslides.html=.rmd}\", \"ioslides_presentation\", output_file = \"$@\")"

## slidy presentation
%_slidy.html: %.Rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:_slidy.html=.Rmd}\", \"slidy_presentation\", output_file = \"$@\")"
%_slidy.html: %.rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:_slidy.html=.rmd}\", \"slidy_presentation\", output_file = \"$@\")"

## beamer presentation
%_beamer.pdf: %.Rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:_beamer.pdf=.Rmd}\", \"beamer_presentation\", output_file = \"$@\")"
%_beamer.pdf: %.rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:_beamer.pdf=.rmd}\", \"beamer_presentation\", output_file = \"$@\")"

## tufte handout format (NB: first install.packages("tufte", dep=T))
%_tufte.pdf: %.Rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:_tufte.pdf=.Rmd}\", \"tufte_handout\", output_file = \"$@\")"
%_tufte.pdf: %.rmd
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(rmarkdown);render(\"${@:_tufte.pdf=.rmd}\", \"tufte_handout\", output_file = \"$@\")"

## --------------------------------------------------------------------
## backup using rsync -------------------------------------------------
## --------------------------------------------------------------------
## NB: this could be more flexible using options like --delete,
##     --include, --exclude etc etc 

.PHONY: help-rsync
help-rsync:
	@echo Use rsync to backup files to/from local or remote destination
	@echo ""
	@echo "rsync local to remote:"
	@echo $$ make rsynctest
	@echo "  or"
	@echo $$ make rsynccopy
	@echo ""
	@echo "rsync remote to local:"
	@echo $$ make rsynctest2here
	@echo "  or"
	@echo $$ make rsynccopy2here
	@echo ""
	@echo will either run rsync with \'--dry-run\' option to perform a
	@echo trial run with no changes made
	@echo " or"
	@echo copy just those updated files to local/remote destination
	@echo but your can change options with something like
	@echo $$ RSYNC_DESTINATION=~/ownCloud/myProject3 make rsynctest
	@echo $$ RSYNC_DESTINATION=username@remote_host:/home/username/dir1 make rsynctest
	@echo NB: rsync variables \(defaults in brackets\) are
	@echo "    RSYNC_DESTINATION, RSYNC (rsync), RSYNC_FLAGS (-auvtr)"
	@echo "    RSYNC_FILES_LOCAL (*), RSYNC_FILES_REMOTE (*) RSYNC_DRY_RUN (--dry-run)"
	@echo "    RSYNC_FLAGS_POST (--exclude=.DS_Store)"
	@echo "NB: Also can set RSYNC_FLAGS2 etc for a secondary rsync backup"
	@echo See https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps

## rsync variables ------------------------------------------------
RSYNC = rsync
RSYNC_DRY_RUN = --dry-run

## first remote rsync variables
RSYNC_DESTINATION =
## RSYNC_DESTINATION = ~/ownCloud/myProject
RSYNC_FLAGS = -auvtr
RSYNC_FLAGS_POST = --exclude=.DS_Store
RSYNC_FILES_LOCAL = *
RSYNC_FILES_REMOTE = *

## second remote rsync variables
RSYNC_DESTINATION2 =
## RSYNC_DESTINATION = ~/ownCloud/myProject
RSYNC_FLAGS2 = ${RSYNC_FLAGS}
RSYNC_FLAGS_POST2 = ${RSYNC_FLAGS_POST} --exclude="*~"
RSYNC_FILES_LOCAL2 = ${RSYNC_FILES_LOCAL}
RSYNC_FILES_REMOTE2 = ${RSYNC_FILES_REMOTE}

## rsync local to 1st remote ------
.PHONY: rsynctest
rsynctest:
	${RSYNC} ${RSYNC_DRY_RUN} ${RSYNC_FLAGS} ${RSYNC_FILES_LOCAL} ${RSYNC_DESTINATION}/. ${RSYNC_FLAGS_POST}

.PHONY: rsynccopy
rsynccopy:
	${RSYNC} ${RSYNC_FLAGS} ${RSYNC_FILES_LOCAL} ${RSYNC_DESTINATION}/. ${RSYNC_FLAGS_POST}

## rsync local to 2nd remote ------
.PHONY: rsynctest2
rsynctest2:
	${RSYNC} ${RSYNC_DRY_RUN} ${RSYNC_FLAGS2} ${RSYNC_FILES_LOCAL2} ${RSYNC_DESTINATION2}/. ${RSYNC_FLAGS_POST2}

.PHONY: rsynccopy2
rsynccopy2:
	${RSYNC} ${RSYNC_FLAGS} ${RSYNC_FILES_LOCAL2} ${RSYNC_DESTINATION2}/. ${RSYNC_FLAGS_POST2}

## rsync 1st remote to local ------
.PHONY: rsynctest2here
rsynctest2here:
	${RSYNC} ${RSYNC_DRY_RUN} ${RSYNC_FLAGS} ${RSYNC_DESTINATION}/${RSYNC_FILES_REMOTE} . ${RSYNC_FLAGS_POST}

.PHONY: rsynccopy2here
rsynccopy2here:
	${RSYNC} ${RSYNC_FLAGS} ${RSYNC_DESTINATION}/${RSYNC_FILES_REMOTE} . ${RSYNC_FLAGS_POST}

## -----------------------------------------------------------
## git  ------------------------------------------------------
## -----------------------------------------------------------

## more to remind me of commands than for actual use ---------

.PHONY: help-git
help-git:
	@echo ""
	@echo Version control using git from Makefile
	@echo ""
	@echo $$ make git.status
	@echo $$ make git.commit
	@echo "  or"
	@echo $$ make git.fetch
	@echo will either list changes via \'git status\', commit changes or push to remote repository
	@echo " "
	@echo Useful commands:
	@echo $$git remote -v : lists URLs that Git has stored for remotes
	@echo $$git remote add [shortname] [url] : to add remote
	@echo $$ git push [remote-name] [branch-name] : to push repository to remote
	@echo See http://git-scm.com/doc or
	@echo http://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes
	@echo ""
	@echo NB: It really is best to set up .git/config file and use git 
	@echo "   directly from command line (or in RStudio or emacs magit etc)"

.PHONY: git.status
git.status:
	${GIT} status

.PHONY: git.commit
git.commit:
	${GIT} commit ${GIT_FLAGS}

.PHONY: git.push
git.push:
	${GIT} push ${GIT_ORIGIN} ${GIT_REMOTE}


## ---------------------------------------------------------------------
## Course slides/presentations using knit/beamer -----------------------
## ---------------------------------------------------------------------

.PHONY: help-beamer
help-beamer:
	@echo ""  
	@echo Beamer presentations, articles and handouts produced with knitr
	@echo ""
	@echo "    The main file has name PRESENTATION.Rnw"
	@echo "    for instance, for myTalk.Rnw, then replace PRESENTATION with myTalk"
	@echo "NB: Do not include \\documentclass[...]{beamer} in main file"
	@echo ""
	@echo Targets that may be produced:
	@echo "   PRESENTATION_Present.pdf: Slides for presentation"
	@echo "   PRESENTATION_Notes.pdf: Slides for presentation with speaker notes"
	@echo "   PRESENTATION_Article.pdf: Article using 'beamerarticle' style"
	@echo "   PRESENTATION_Handout.pdf: 1 slide/page without transitions"
	@echo "   PRESENTATION-2up.pdf: Handouts - 2 per A4 page"
	@echo "   PRESENTATION-3up.pdf:            3 per A4 page"
	@echo "   PRESENTATION-4up.pdf:            4 per A4 page"
	@echo "   PRESENTATION-6up.pdf:            6 per A4 page"
	@echo "   PRESENTATION-syntax.R: R syntax file tangled from Rnw using knit"
	@echo ""
	@echo "NB: Do not put \\documentclass declaration in main .Rnw file"
	@echo "\\documentclass{} declaration obtained from files"
	@echo "      preamble{Present,Article,Notes,Handout}.Rnw"
	@echo "    Preamble files can be set with variables BEAMER_PRESENT etc"
	@echo " eg. $$ BEAMER_PRESENT=~/lib/preamble.Rnw make myTalk_Present.pdf"

## produce latex file with knit and pdf (via pdflatex) with knit2pdf
## but note that it does not have document class - knitr is then
## likely to use article if preamble is not used

## use knitr, latex and pdfjam to produce output  ------------------------

## variables which can be overridden
BEAMER_LIB = ~/lib/beamerPreamble/
##BEAMER_LIB = ""
BEAMER_PRESENT = ${BEAMER_LIB}preamblePresent.Rnw
BEAMER_HANDOUT = ${BEAMER_LIB}preambleHandout.Rnw
BEAMER_ARTICLE = ${BEAMER_LIB}preambleArticle.Rnw
BEAMER_NOTES = ${BEAMER_LIB}preambleNotes.Rnw
PDFJAM_4UP = --nup 2x2 --frame true --landscape --scale 0.92
PDFJAM_2UP = --nup 1x2 --frame true --no-landscape --scale 0.92
PDFJAM_3UP = --no-landscape
PDFJAM_6UP = --no-landscape

## Beamer presentation pdf
%_Present.Rnw: %.Rnw $(BEAMER_PRESENT)
	$(CAT) $(CAT_OPTS) $(BEAMER_PRESENT) $< > $@
%_Present.Rnw: %.rnw $(BEAMER_PRESENT)
	$(CAT) $(CAT_OPTS) $(BEAMER_PRESENT) $< > $@
%_Present.pdf: %_Present.Rnw
	${RSCRIPT} ${RSCRIPT_OPTS}  -e "library(knitr);knit2pdf('$<')"

## Beamer presentation with notes pdf (notes show on second screen)
%_Notes.Rnw: %.Rnw $(BEAMER_NOTES)
	$(CAT) $(CAT_OPTS) $(BEAMER_NOTES) $< > $@
%_Notes.Rnw: %.rnw $(BEAMER_NOTES)
	$(CAT) $(CAT_OPTS) $(BEAMER_NOTES) $< > $@
%_Notes.pdf: %_Notes.Rnw
	${RSCRIPT} ${RSCRIPT_OPTS}  -e "library(knitr);knit2pdf('$<')"

## produce Article pdf (slides usually not framed but can be)
%_Article.Rnw: %.Rnw $(BEAMER_ARTICLE)
	$(CAT) $(CAT_OPTS) $(BEAMER_ARTICLE) $< > $@
%_Article.Rnw: %.rnw $(BEAMER_ARTICLE)
	$(CAT) $(CAT_OPTS) $(BEAMER_ARTICLE) $< > $@
%_Article.pdf: %_Article.Rnw
	${RSCRIPT} ${RSCRIPT_OPTS}  -e "library(knitr);knit2pdf('$<')"

## Handout - single slide on a landscape page pdf
%_Handout.Rnw: %.Rnw $(BEAMER_HANDOUT)
	$(CAT) $(CAT_OPTS) $(BEAMER_HANDOUT) $< > $@
%_Handout.rnw: %.rnw $(BEAMER_HANDOUT)
	$(CAT) $(CAT_OPTS) $(BEAMER_HANDOUT) $< > $@
%_Handout.pdf: %_Handout.Rnw
	${RSCRIPT} ${RSCRIPT_OPTS}  -e "library(knitr);knit2pdf('$<')"

## Handouts: various - multiple slides per page using pdfjam - calls
##           latex pgfpages in background
%-4up.pdf: %_Handout.pdf
	$(PDFJAM) $(PDFJAM_OPTS) -o $@ ${PDFJAM_4UP} $<

%-2up.pdf: %_Handout.pdf
	$(PDFJAM) $(PDFJAM_OPTS) -o $@ ${PDFJAM_2UP} $<

%-6up.pdf: %_Handout.pdf
	$(PDFJAM)-slides6up $(PDFJAM_OPTS) -o $@ $(PDFJAM_6UP) $< 

%-3up.pdf: %_Handout.pdf
	$(PDFJAM)-slides3up $(PDFJAM_OPTS) -o $@ $(PDFJAM_3UP) $<

## ---------------------------------------------------------------
## house-keeping/cleaning ----------------------------------------
## ---------------------------------------------------------------

## housekeeping which needs improving - especially backup (.tgz or
## .zip file?)  but this won't work without extra directories etc
## needs some checking and thought

.PHONY: clean
clean: 
	-${RM} ${RM_OPTS} *.pdf *.Rout *.log *.aux *.bbl *~ *.html *.docx *.out

.PHONY: backup
backup:
	-zip -9 backup/backup-`date +%F`.zip *.R Makefile */*/*.csv *.pdf *.Rnw *.Rmd *.Rout

## ---------------------------------------------------------------
## Other statistical software and perl/python --------------------
## ---------------------------------------------------------------

## SAS STATA PSPP python perl rules ------------------------------

.PHONY: help-stats-others
help-stats-others:
	@echo ""
	@echo Other software: SAS, STATA, PSPP, perl, python
	@echo ""
	@echo "SAS:    make myFile.lst     from myFile.sas"
	@echo "STATA:  make myFile.log     from myFile.do"
	@echo "PSPP:   make myFile.list    from myFile.sps"
	@echo "        make myFile.pdf     from myFile.sps"
	@echo "        make myFile.odt     from myFile.sps"
	@echo "perl:   make myFile.txt     from myFile.pl"
	@echo "python: make myFile.txt     from myFile.py"
	@echo ""
	@echo "Variables:"
	@echo "Programs: SAS, STATA, PSPP, PYTHON, PERL"
	@echo "Options":
	@echo SAS_CFG, SAS_OPTS, STATA_OPTS, PSPP_OPTS, PL_OPTS, PY_OPTS
	@echo "File Output Extensions (since no defaults):"
	@echo "PL_OUT_EXT, PY_OUT_EXT  Default: txt"
	@echo ""
	@echo "Example: to make output 'myFile.out' from 'myFile.py'"
	@echo ""
	@echo "PYTHON = /usr/local/bin/python"
	@echo "PY_OUT_EXT = out"
	@echo "make myFile.out"

## python variables and rules ------------------------------
## PYTHON = /usr/bin/python
PYTHON = python
PY_OUT_EXT = txt
PY_OPTS = 
%.${PY_OUT_EXT}: %.py
	${PYTHON} ${PY_OPTS} $< > ${<:.py=.${PY_OUT_EXT}}
%.${PY_OUT_EXT}: %.PY
	${PYTHON} ${PY_OPTS} $< > ${<:.PY=.${PY_OUT_EXT}}

## python variables and rules ------------------------------
## PERL = /usr/bin/perl
PERL = perl
PL_OUT_EXT = txt
PL_OPTS = 
%.${PL_OUT_EXT}: %.pl
	${PERL} ${PL_OPTS} $< > ${<:.pl=.${PL_OUT_EXT}}
%.${PL_OUT_EXT}: %.PL
	${PERL} ${PL_OPTS} $< > ${<:.PL=.${PL_OUT_EXT}}

## PSPP: GNU PSPP -------------------------------------------
## Notes:
## SPSS: On Windows recent versions have seemingly bizarre project
##       system which doesn't have simple batch like it used to
##       although older versions OK from command prompt. As I don't
##       have access any more I can only test PSPP PB 3/6/2017
## NB: pspp is pretty basic and doesn't have usable command line
##     options but variable defined just in case things change
PSPP = pspp
PSPP_OPTS =

## list file from pspp file
%.list: %.sps ; ${PSPP} ${PSPP_OPTS}  -o $@ $<
%.LIST: %.SPS ; ${PSPP} ${PSPP_OPTS}  -o $@ $<

## PDF file from pspp file
%.pdf: %.sps ; ${PSPP} ${PSPP_OPTS}  -o $@ $<
%.PDF: %.SPS ; ${PSPP} ${PSPP_OPTS}  -o $@ $<

## libre office file from pspp file
%.odt: %.sps ; ${PSPP} ${PSPP_OPTS}  -o $@ $<
%.ODT: %.SPS ; ${PSPP} ${PSPP_OPTS}  -o $@ $<

## STATA ---------------------------------------------------
## I only have access to networked versions
##
## Networked Windows stata
## STATA=S:/ITS-NetLicSoftware/SPH-STATA12/Stata14/StataSE-64.exe
## STATA_OPTS=/e do 
## STATA_OPTS=/b do 
## Networked macOS stata
## STATA=smb://nas02.storage.uq.edu.au/HBS-MBS-Shared/ITS-NetLicSoftware/SPH-STATA12/osx/StataSE
STATA=stata
STATA_OPTS=-e do 
## stata rule: log file from do file
%.log: %.do ; ${STATA} ${STATA_OPTS} $<
%.LOG: %.DO ; ${STATA} ${STATA_OPTS} $<

## SAS ------------------------------------------------------
##
## SAS 9.4 for Windows
## SAS=C:/Program\ Files/SASHome/SASFoundation/9.4/sas.exe
## SAS_CFG=-CONFIG "C:\Program Files\SASHome\SASFoundation\9.4\nls\en\sasv9.cfg"
SAS=sas
SAS_CFG="-CONFIG ${HOME}/sasv9.cfg"
SAS_OPTS=

## lst file from sas file
%.lst: %.sas ; ${SAS} ${SAS_OPTS} $< ${SAS_CFG}
%.LST: %.SAS ; ${SAS} ${SAS_OPTS} $< ${SAS_CFG}

## ---------------------------------------------------------------
## knitr from command line for .Rnw files
## ---------------------------------------------------------------

## knitr and purl rules --------------------------------------


.PHONY: help-knitr
help-knitr:
	@echo ""
	@echo knitr and purl for .Rnw files
	@echo ""
	@echo To knitr or knitr a .Rnw file using knitr by default do not set
	@echo SWEAVE_ENGINE to Sweave and simply include r-rules with
	@echo ""
	@echo "include ~/lib/r-rules.mk"
	@echo ""
	@echo "make myFile.pdf          # .pdf using knitr from myFile.Rnw"
	@echo "make myFile.tex          # .tex using knitr from myFile.Rnw"
	@echo "make myFile-syntax.R     # purl myFile.Rnw to get R syntax"
	@echo ""
	@echo NB: Assumes all .Rnw files are in knitr format
	@echo "    See r-rules.mk on how to edit r-rules.mk to set Sweave as default"
	@echo "    For help on running Sweave on all .Rnw files run"
	@echo "       make help-sweave"
	@echo "    and"
	@echo "       help-both-sweave-knitr"
	@echo "    for help on processing knitr and Sweave format .Rnw files"

## Not sure if this conflicts  ----- START

## perhaps alternative way ifndef but blank SWEAVE_ENGINE works too
##ifndef SWEAVE_ENGINE
## uncomment SWEAVE_ENGINE next line if you want to make Sweave default
## ifeq ($(SWEAVE_ENGINE), knitr)

## tex file from .Rnw - obsolete as now use rmarkdown=knit and pandoc
%.tex: %.Rnw
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(knitr);knit('${@:.tex=.Rnw}')"
%.tex: %.rnw
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(knitr);knit('${@:.tex=.rnw}')"

## Not sure if this conflicts
##%.pdf : %.tex
##	${LATEXMK_PRE} ${LATEXMK} ${LATEXMK_OPTS} $<
##	${R} CMD ${LATEXMK} ${LATEXMK_FLAGS} $<

## best to go to .pdf directly rather than creating .tex file
## I am relying on the %.tex: %.Rnw being overriden but problematic if .tex file
## hanging around due to crash - perhaps remove %.tex: %.[Rr]nw rules
%.pdf: %.Rnw
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(knitr);knit2pdf('${@:.pdf=.Rnw}')"
%.pdf: %.rnw
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(knitr);knit2pdf('${@:.pdf=.Rnw}')"

## extract R syntax using knitr::purl ## declared above
%-syntax.R: %.Rnw
	${RSCRIPT} ${RSCRIPT_OPTS}  -e 'library(knitr);purl("$<", out="$@")'
%-syntax.R: %.rnw
	${RSCRIPT} ${RSCRIPT_OPTS}  -e 'library(knitr);purl("$<", out="$@")'
## uncomment endif if you want to make Sweave default
##endif

## Not sure if this conflicts  ----- END


## ---------------------------------------------------------------
## Sweave from command line for .Rnw files
## ---------------------------------------------------------------

## Sweave and Stangle rules --------------------------------------

.PHONY: help-sweave
help-sweave:
	@echo ""
	@echo Sweave and Stangle for .Rnw files
	@echo ""
	@echo To sweave or tangle a file using Sweave, you first need to set the
	@echo "SWEAVE_ENGINE variable to Sweave (which by default is knitr)"
	@echo "with the following:"
	@echo ""
	@echo "## note SWEAVE_ENGINE needs to be set before include"
	@echo "SWEAVE_ENGINE=Sweave"
	@echo "include ~/lib/r-rules.mk"
	@echo ""
	@echo "make myFile.pdf          # .pdf using Sweave from myFile.Rnw"
	@echo "make myFile.tex          # .tex using Sweave from myFile.Rnw"
	@echo "make myFile-syntax.R     # Stangle myFile.Rnw to get R syntax"
	@echo ""
	@echo NB: Only set SWEAVE_ENGINE if all .Rnw files are in Sweave format
	@echo "    See r-rules.mk on how to edit r-rules.mk to set Sweave as default"
	@echo "    For help on running knitr on .Rnw files run"
	@echo "       make help-knitr"
	@echo "    and"
	@echo "       help-both-sweave-knitr"
	@echo "    for help on processing knitr and Sweave format .Rnw files"

## from above!!
## RSWEAVE    = $(R) CMD Sweave
## RSWEAVE_FLAGS =
##%.R: %.Rnw
##	${R} CMD Stangle $<

## this is very slack and needs improving - just overwrites pattern rules for .Rnw if SWEAVE_ENGINE is set to Sweave
## Hence: the variable needs to be defined before r-rules.mk included

## may need to lowercase Sweave for windows etc users

## SWEAVE_ENGINE is Sweave ---------------------------------------------

## Alternative definition using latexmk and producing intermediate .tex 
##%.pdf: %.Rnw
##	${RSWEAVE} $< ${RSWEAVE_FLAGS}
##	${LATEXMK_PRE} ${LATEXMK} ${LATEXMK_OPTS} $*
##	${RM} ${RM_OPTS} $*.tex

ifeq ($(SWEAVE_ENGINE), Sweave)
## produce pdf from .Rnw etc
%.pdf: %.Rnw
	${RSWEAVE} --pdf $< ${RSWEAVE_FLAGS}
%.pdf: %.rnw
	${RSWEAVE} --pdf $< ${RSWEAVE_FLAGS}
%.pdf: %.Snw
	${RSWEAVE} --pdf $< ${RSWEAVE_FLAGS}
%.pdf: %.snw
	${RSWEAVE} --pdf $< ${RSWEAVE_FLAGS}
## produce tex from .Rnw etc
%.tex: %.Rnw
	${RSWEAVE} $< ${RSWEAVE_FLAGS}
%.tex: %.rnw
	${RSWEAVE} $< ${RSWEAVE_FLAGS}
%.tex: %.Snw
	${RSWEAVE} $< ${RSWEAVE_FLAGS}
%.tex: %.snw
	${RSWEAVE} $< ${RSWEAVE_FLAGS}
## produce R syntax from .Rnw etc
%-syntax.R: %.Rnw
	${RSTANGLE} $< ${RSTANGLE_FLAGS}
	${MV} ${MV_OPTS} ${<:.Rnw=.R} $@
%-syntax.R: %.rnw
	echo ${RSTANGLE} $< ${RSTANGLE_FLAGS}
	${MV} ${MV_OPTS} ${<:.rnw=.R} $@
%-syntax.r: %.Snw
	echo ${RSTANGLE} $< ${RSTANGLE_FLAGS}
	${MV} ${MV_OPTS} ${<:.Snw=.R} $@
%-syntax.r: %.snw
	echo ${RSTANGLE} $< ${RSTANGLE_FLAGS}
	${MV} ${MV_OPTS} ${<:.snw=.R} $@
endif

## help pdf from both Sweave and knitr in same Makefile ----------------------

.PHONY: help-both-sweave-knitr
help-both-sweave-knitr:
	@echo ""
	@echo Sweave/Stangle and knitr/purl
	@echo ""
	@echo "If you have a mixture of knitr and Sweave format .Rnw's then use the following:"
	@echo ""
	@echo "Leave SWEAVE_ENGINE unset and specify the following targets"
	@echo "and also specify dependencies (no predefined target/dependency)"
	@echo ""
	@echo "SWEAVE_PDF:  list of pdf files for processing .Rnw with Sweave"
	@echo "KNITR_PDF:   list of pdf files from .Rnw with knitr"
	@echo "KNITR_HTML:  list of html files from .Rnw with knitr"
	@echo "SWEAVE_R: list of -syntax.R files from .Rnw using Stangle"
	@echo "KNITR_R:  list of -syntax.R files from .Rnw using knitr purl"
	@echo ""
	@echo "## Example: files myknitr.Rnw and mySweave.Rnw in appropriate format"
	@echo "SWEAVE_PDF: myknitr.pdf"
	@echo "KNITR_PDF: mySweave.pdf"
	@echo ""
	@echo "myknitr.pdf: myknitr.Rnw myData1.csv"
	@echo "mySweave.pdf: mySweave.Rnw myData2.csv"
	@echo ""
	@echo "NB: For help on processing just knitr or sweave .Rnw files see"
	@echo "    make help-knitr"
	@echo "    make help-sweave"

## pdf from both Sweave and knitr in same Makefile ----------------------

## use Hooking functions from Mecklenburg pp106-108

## .pdf from .Rnw - Sweave and knitr ------------------------------------

define build-sweave
	$(call build-sweave-hook,$@)
endef

define RSWEAVEPDF
	${RSWEAVE} --pdf $< ${RSWEAVE_FLAGS}
	## ifeq ($(RSWEAVE_CLEAN), yes)  # could do this better with call etc
	${RSWEAVE} --clean  $<
	${RM} ${RM_OPTS} ${<:.Rnw=.tex} ${<:.Rnw=.aux} ${<:.Rnw=.log}
	## endif
endef

## older suggestion from stack-overflow - obsolete? use sweave manual 23/4/2018
##	${R} CMD ${LATEXMK_PRE} ${LATEXMK} ${LATEXMK_OPTS} ${<:.Rnw=}
##	${R} CMD ${LATEXMK_PRE} ${LATEXMK} --pdf ${<:.Rnw=}
##	${LATEXMK} ${LATEXMK_CLEAN} ${<:.Rnw=.tex}


define RKNITRPDF
	${RSCRIPT} ${RSCRIPT_OPTS} -e "library(knitr);knit2pdf('${@:.pdf=.Rnw}')"
endef

## RSWEAVE_RNW target(s) for .pdf from .Rnw using Sweave
$(RSWEAVE_PDF): build-sweave-hook = $(RSWEAVEPDF) $1
$(RSWEAVE_PDF):
	$(call build-sweave,$^)

## RKNITR_PDF target(s) for .pdf from .Rnw using knitr
$(RKNITR_PDF): build-sweave-hook = $(RKNITRPDF) $1
$(RKNITR_PDF):
	$(call build-sweave,$^)


## needs to be converted to hook style function with both Stangle and purl

## extract R syntax using knitr::purl ## declared above
# %-syntax.R: %.Rnw
# 	${RSCRIPT} ${RSCRIPT_OPTS}  -e 'library(knitr);purl("$<", out="$@")'
# %-syntax.R: %.rnw
# 	${RSCRIPT} ${RSCRIPT_OPTS}  -e 'library(knitr);purl("$<", out="$@")'
