.PHONY: all clean distclean

ZIP=paper/Latex.zip       # ← renomme ton zip ainsi
SRC_DIR=paper/src                 # ← extraction temporaire
MAIN=$(SRC_DIR)/main.tex
BUILD_DIR=$(SRC_DIR)/build
OUT_PDF=paper/odwdl_report.pdf

all: $(OUT_PDF)

$(OUT_PDF): $(MAIN)
	@mkdir -p $(BUILD_DIR)
	latexmk -pdf -interaction=nonstopmode -outdir=$(BUILD_DIR) $(MAIN)
	@cp -f $(BUILD_DIR)/main.pdf $(OUT_PDF)
	@echo "Built $(OUT_PDF)"

$(MAIN):
	@[ -f "$(ZIP)" ] || (echo "Missing $(ZIP). Put your LaTeX zip there." ; exit 1)
	@mkdir -p $(SRC_DIR)
	@unzip -o -qq "$(ZIP)" -d $(SRC_DIR)
	@# Si l'archive contient un sous-dossier, ajuste MAIN en conséquence (ex: $(SRC_DIR)/paper/main.tex)

clean:
	-@latexmk -C -outdir=$(BUILD_DIR) $(MAIN) >/dev/null 2>&1 || true

distclean: clean
	@rm -rf "$(SRC_DIR)"
