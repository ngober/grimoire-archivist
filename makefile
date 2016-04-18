MAKE=make
MKDIR=mkdir -p
PYTH=python

PYMARKTEX=pymarktex/pymarktex.py

SRC_DIR=src
BUILD_DIR=build
MD_DIR=$(BUILD_DIR)/md
TEX_DIR=$(BUILD_DIR)/tex

.PHONY: clean md tex keys

all: keys tex

$(BUILD_DIR)/keys.txt: 
	$(MKDIR) $(BUILD_DIR) 
	$(PYTH) $(SRC_DIR)/getkeys.py > $@

keys: $(BUILD_DIR)/keys.txt

$(MD_DIR)/%.md: 
	$(MKDIR) $(MD_DIR)
	$(PYTH) $(SRC_DIR)/getmd.py $@
 
$(TEX_DIR)/%.tex: $(MD_DIR)/%.md
	$(MKDIR) $(TEX_DIR)
	$(PYTH) $(PYMARKTEX) $< > $@


md: $(BUILD_DIR)/keys.txt
	for key in $(addsuffix .md, $(shell cat $<)); do\
		make $(MD_DIR)/$$key;\
	done

tex: $(BUILD_DIR)/keys.txt
	for key in $(addsuffix .d, $(shell cat $<)); do\
		make $(TEX_DIR)/$$key;\
	done

clean:
	rm -r $(BUILD_DIR)
