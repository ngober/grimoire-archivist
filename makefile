PYTH=python

BUILD_DIR=build
MD_DIR=$(BUILD_DIR)/md
TEX_DIR=$(BUILD_DIR)/tex

.PHONY: clean

*.tex: *.md
	$(PYTH) pymarktex.py $< > $@

clean:
	rm -r $(BUILD_DIR)
