---
tags:
  - Data pipelines
icon: octicons/workflow-16
---

# Data Pipelines

???- info "Learning outcomes"

    - Understand the key coponents of data pipelines for LLMs  

Well-designed data pipelines determine LLM quality, safety, and training throughput.

## Pre-training Pipelines

Goal: assemble large, diverse, governed corpora and feed tokens efficiently to trainers.

- Data sourcing and licensing: web crawl, books, code, academic; PII and copyright governance.

- Normalization and detection: language ID, Unicode cleanup, boilerplate removal, doc boundaries.

- Deduplication: exact and near-dup (MinHash/SimHash); mitigate contamination and overfitting.

- Quality filtering: heuristic/classifier filters (toxicity, spam), quality scoring, temperature sampling.

- Tokenization and packing: train vocab (BPE/Unigram), pre-tokenize, pack sequences respecting EOD.

- Mixtures and sampling: domain/language balance, curriculum, up/down-sampling.

- Storage and sharding: Arrow/Parquet/WebDataset, deterministic sharding, resume-safe streaming.

- Decontamination and observability: remove overlaps with evals; versioning, lineage, dashboards.

References (arXiv):

- The Pile: https://arxiv.org/abs/2101.00027

- CCNet: https://arxiv.org/abs/1911.00359

- RefinedWeb: https://arxiv.org/abs/2306.01116

- Dolma: https://arxiv.org/abs/2306.07196

- T5/C4: https://arxiv.org/abs/1910.10683

## Post-training Pipelines

Goal: align base LMs via supervised fine-tuning and preference optimization.

- SFT data curation: instruction–response pairs, multi-turn formatting, style and tool-use coverage.

- Preference data: pairwise rankings (human or AI feedback), rubric design, rater QA.

- Optimization: reward modeling + RLHF (PPO) or preference-only methods (DPO, RRHF).

- Safety and policy: Constitutional prompts, red-teaming, filters, decontamination of evals.

- Mixtures and iteration: SFT + preferences + safety data; synthetic data (Self-Instruct); versioned loops.

References (arXiv):

- InstructGPT (RLHF): https://arxiv.org/abs/2203.02155

- Constitutional AI: https://arxiv.org/abs/2212.08073

- DPO: https://arxiv.org/abs/2305.18290

- LIMA: https://arxiv.org/abs/2305.11206

- Self-Instruct: https://arxiv.org/abs/2212.10560

- RRHF: https://arxiv.org/abs/2304.05302

