MAKE=make
MKDIR=mkdir
PYTH=python2.7
PANDOC=pandoc
TEX=pdflatex

SRC_DIR=src
BUILD_DIR=build
MD_DIR=$(BUILD_DIR)/md
TEX_DIR=$(BUILD_DIR)/tex

PYTH_OPTS=-W ignore
MKDIR_OPTS=-p
PANDOC_OPTS=--from=markdown --to=latex --smart --normalize
TEX_OPTS=-output-directory $(BUILD_DIR) 

.PHONY: clean md tex keys

all: keys md tex pdf

$(BUILD_DIR)/keys.txt: 
	$(MKDIR) $(MKDIR_OPTS) $(BUILD_DIR) 
	$(PYTH) $(PYTH_OPTS) $(SRC_DIR)/getkeys.py > $@

keys: $(BUILD_DIR)/keys.txt

$(MD_DIR)/%.md: 
	$(MKDIR) $(MKDIR_OPTS) $(MD_DIR)
	$(PYTH) $(PYTH_OPTS) $(SRC_DIR)/getmd.py $@ 
	
$(TEX_DIR)/%.tex: $(MD_DIR)/%.md
	$(MKDIR) $(MKDIR_OPTS) $(TEX_DIR)
	cp $< tmp.md
	$(PANDOC) $(PANDOC_OPTS) -o $@ $<
	mv tmp.md $<

$(BUILD_DIR)/grimoire.tex: 
	$(MKDIR) $(MKDIR_OPTS) $(BUILD_DIR)
	cat $(SRC_DIR)/preamble.tex > $@
	for key in $(basename $(shell ls $(TEX_DIR))); do\
		echo -n "\section{" >> $@;\
		$(PYTH) $(PYTH_OPTS) $(SRC_DIR)/gettitle.py $$key >> $@;\
		echo "}" >> $@;\
		echo "\input{$(TEX_DIR)/$$key.tex}" >> $@;\
		echo "\newpage" >> $@;\
		echo "" >> $@;\
	done
	cat $(SRC_DIR)/appendix.tex >> $@

md: $(BUILD_DIR)/keys.txt
	for key in $(addsuffix .md, $(shell cat $<)); do\
		make $(MD_DIR)/$$key;\
	done

tex: md
	for key in $(addsuffix .tex, $(basename $(shell ls $(MD_DIR)))); do\
		make $(TEX_DIR)/$$key;\
	done

pdf: $(BUILD_DIR)/grimoire.tex
	$(TEX) $(TEX_OPTS) $(BUILD_DIR)/grimoire.tex

clean:
	rm -r $(BUILD_DIR)
