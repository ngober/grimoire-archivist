PYTH=python

PYMARKTEX=pymarktex/pymarktex.py

BUILD_DIR=build
MD_DIR=$(BUILD_DIR)/md
TEX_DIR=$(BUILD_DIR)/tex

.PHONY: clean

*.tex: *.md
	$(PYTH) $(PYMARKTEX) $< > $@

clean:
	rm -r $(BUILD_DIR)
