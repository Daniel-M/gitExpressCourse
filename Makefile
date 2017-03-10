###############################################
### DOCONCE MAKEFILE V 1.0 - Daniel-M. 2015 ###
###############################################


################################
## Doconce Sources
################################

# Name of the main doconce file without extension
PROJECT = git

## Directories to search for sources

#APPENDICESDIR = appendices
CHAPTERSDIR = chapters
#TABLESDIR = tables
FIGURESDIR = figures
#REFERENCESDIR = references

######################
## Compilation Options
######################

# Command to compile latex source
DOCONCE = doconce

# List of formats to include

FORMATS = html pandoc

# Commmand to build the latex project into PDF (or DVI according to $(DOCONCE).
#BUILD_DOCONCE = $(DOCONCE) format $(FORMATS) $(PROJECT).do.txt

# Command to build pandoc
PANDOC = pandoc
PANDOC_OPTIONS = -V geometry:letterpaper -V geometry:margin=2cm 
BUILD_PANDOC_PDF = pandoc $(PROJECT).html $(PANDOC_OPTIONS) -o $(PROJECT).pdf
MOVE_HTML = mv $(PROJECT).html doc/index.html

############################
## Search for sources prior compilation
############################

# Directories to search for .do.txt files.
DOCONCE_DIRS = $(CHAPTERSDIR)
#DOCONCE_DIRS = $(APPENDICESDIR) $(CHAPTERSDIR) $(TABLESDIR)

# Find .do.txt files in the subdirectories
# performing a search of *.do.txt files amongst all the directories defined on $DOCONCE_DIRS
DOCONCE_TARGETS = $(shell find $(DOCONCE_DIRS) -type f -regex ".*\.\do\.txt") 

## Search for images

# Search for changes on png figures. This can be changed by changing the figure extension or by adding
# other search pattern for other image extensions.
FIGURETARGETS = $(shell find $(FIGURESFDIR) -type f -regex ".*\.\png")

## Build the final target

# Global set of targets.
# This searches changes on the $PROJECT.do.txt file, the template $STYFILE (or set of files)
# and the .do.txt files found on the subdirectories by $DOCONCE_TARGETS
TARGETS = $(PROJECT).do.txt $(DOCONCE_TARGETS) $(FIGURETARGETS)


##############################
## DEFINING TARGETS OPERATIONS
##############################

all: $(TARGETS)
	for format in $(FORMATS); do \
		echo $$format;\
		doconce format $$format $(PROJECT).do.txt; \
	done
	#$(BUILD_DOCONCE)
	$(BUILD_PANDOC_PDF)
	$(MOVE_HTML)
	rm -f tmp_*.do.txt 

$(PROJECT).pdf: $(TARGETS)
	doconce format html $(PROJECT).do.txt; 
	$(BUILD_PANDOC_PDF)
	rm -f tmp_*.do.txt 

html: $(TARGETS) 
	doconce format html $(PROJECT).do.txt; 
	$(MOVE_HTML)
	rm -f tmp_*.do.txt 
	
# Clean all temporary resource files created during the compilation of the master file
clean:
	rm -f tmp_*.do.txt *.log *.bak *.aux *.bbl *.blg *.idx *.toc *.out *~ *.lof *.lot *.nlo *.nls *.ist *.ilg
	rm -f $(CHAPTERSDIR)/*.log $(CHAPTERSDIR)/*.bak $(CHAPTERSDIR)/*.aux $(CHAPTERSDIR)/*.bbl $(CHAPTERSDIR)/*.blg $(CHAPTERSDIR)/*.idx $(CHAPTERSDIR)/*.toc $(CHAPTERSDIR)/*.out $(CHAPTERSDIR)/*~  $(CHAPTERSDIR)/*.nlo $(CHAPTERSDIR)/*.nls $(CHAPTERSDIR)/*.ist $(CHAPTERSDIR)/*.ilg
	rm -f $(TABLES)/*.log $(TABLES)/*.bak $(TABLES)/*.aux $(TABLES)/*.bbl $(TABLES)/*.blg $(TABLES)/*.idx $(TABLES)/*.toc $(TABLES)/*.out $(TABLES)/*~ $(TABLES)/*.nlo $(TABLES)/*.nls $(TABLES)/*.ist $(TABLES)/*.ilg
	rm -f $(APPENDICESDIR)/*.log $(APPENDICESDIR)/*.bak $(APPENDICESDIR)/*.aux $(APPENDICESDIR)/*.bbl $(APPENDICESDIR)/*.blg $(APPENDICESDIR)/*.idx $(APPENDICESDIR)/*.toc $(APPENDICESDIR)/*.out $(APPENDICESDIR)/*~ $(APPENDICESDIR)/*.nlo $(APPENDICESDIR)/*.nls $(APPENDICESDIR)/*.ist $(APPENDICESDIR)/*.ilg

# Clean all temporary resource files created during compilation and delete the latex output.
clean-all:
	rm -f tmp_*.do.txt *.dvi *.log *.bak *.aux *.bbl *.blg *.idx *.ps *.eps *.pdf *.toc *.out *~ *.lof *.lot *.nlo *.nls *.ist *.ilg
	rm -f $(CHAPTERSDIR)/*.dvi $(CHAPTERSDIR)/*.log $(CHAPTERSDIR)/*.bak $(CHAPTERSDIR)/*.aux $(CHAPTERSDIR)/*.bbl $(CHAPTERSDIR)/*.blg $(CHAPTERSDIR)/*.idx $(CHAPTERSDIR)/*.ps $(CHAPTERSDIR)/*.eps $(CHAPTERSDIR)/*.pdf $(CHAPTERSDIR)/*.toc $(CHAPTERSDIR)/*.out $(CHAPTERSDIR)/*~  $(CHAPTERSDIR)/*.nlo $(CHAPTERSDIR)/*.nls $(CHAPTERSDIR)/*.ist $(CHAPTERSDIR)/*.ilg
	rm -f $(TABLES)/*.dvi $(TABLES)/*.log $(TABLES)/*.bak $(TABLES)/*.aux $(TABLES)/*.bbl $(TABLES)/*.blg $(TABLES)/*.idx $(TABLES)/*.ps $(TABLES)/*.eps $(TABLES)/*.pdf $(TABLES)/*.toc $(TABLES)/*.out $(TABLES)/*~ $(TABLES)/*.nlo $(TABLES)/*.nls $(TABLES)/*.ist $(TABLES)/*.ilg
	rm -f $(APPENDICESDIR)/*.dvi $(APPENDICESDIR)/*.log $(APPENDICESDIR)/*.bak $(APPENDICESDIR)/*.aux $(APPENDICESDIR)/*.bbl $(APPENDICESDIR)/*.blg $(APPENDICESDIR)/*.idx $(APPENDICESDIR)/*.ps $(APPENDICESDIR)/*.eps $(APPENDICESDIR)/*.pdf $(APPENDICESDIR)/*.toc $(APPENDICESDIR)/*.out $(APPENDICESDIR)/*~ $(APPENDICESDIR)/*.nlo $(APPENDICESDIR)/*.nls $(APPENDICESDIR)/*.ist $(APPENDICESDIR)/*.ilg

