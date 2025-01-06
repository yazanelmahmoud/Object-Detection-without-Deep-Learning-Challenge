# Object Detection without Deep Learning Challenge

Classical **object detection without deep learning** using feature engineering (HOG/HSV/LBP),
proposal methods (Selective Search, EdgeBoxes), SVM classification, NMS, and hard-negative mining.
Includes a LaTeX report (PDF included) and a single large notebook driving the full pipeline.

## Contents
- `paper/` — LaTeX sources + compiled PDF
- `notebooks/` — One large end-to-end notebook
- `src/` — Optional Python modules/CLI
- `data/` — Instructions only (no raw data)
- `history/` — Timeline gathered by commit replay
- `scripts/` — Automation (replay, checks)

## Quickstart
1. Ensure your Git identity is set and email verified on GitHub.
2. Initialize an orphan `main` and replay the historical commits:
   ```bash
   bash setup_and_replay.sh
   ```
3. Create an **empty** GitHub repo and push with `--force-with-lease`.

See `docs/QUICKSTART.md` for the step‑by‑step.
