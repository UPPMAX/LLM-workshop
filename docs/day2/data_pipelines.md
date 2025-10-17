---
tags:
  - Data pipelines
icon: octicons/workflow-16
---

# Data Pipelines

???- info "Learning outcomes"

    - Understand the key coponents of data pipelines for LLMs  

![Data meme](./figures/data_meme.jpg){ align=right width=300 }

- Well-designed data pipelines determine LLM quality, safety, and training throughput.

- Success of all frontier models like GPT-5 relies heavily on quality data and costructing effecient pipelines around it that reduces training compute and improves the capabilities of the model that we desire it to have.

https://learn.deeplearning.ai/courses/pretraining-llms/lesson/xfpqx/data-preparation
https://learn.deeplearning.ai/courses/pretraining-llms/lesson/wqgv4/packaging-data-for-pretraining

## Pre-training

**Goal:** Assemble large, diverse, governed corpora and feed tokens efficiently to the model.

[Raw data](https://raw.githubusercontent.com/stanford-cs336/spring2025-lectures/refs/heads/main/var/sample-documents.txt), is often messy and unsuitable for learning linguistic semantics. It typically exists in diverse formats like HTML, PDFs, spreadsheets etc, requiring extensive preprocessing to make it usable for training. Challenge lies in preserving the content and structure during this lossy process of data cleaning.

<div class="annotate" markdown>

- Data acquisition and licensing (1)

- Content extraction, normalization and detection (2)

- Deduplication (3)

- Quality filtering, decontamination (4)

- Tokenization and training (5)

- Mixture building and sampling (6)

- Storage and sharding (7)

- Training and observability (8)

- Continuous Evaluation (9)

- Data governance and ethics (10)

</div>

1. web crawl, books, Github code, academic papers. PII and copyright governance.  
Web crawl : [CC](https://commoncrawl.org/overview) 
2. language ID, Unicode cleanup, boilerplate removal, doc boundaries.  
Language classifiers: [GlotLID](https://github.com/cisnlp/GlotLID), [Fasttext](https://github.com/facebookresearch/fastText)
3. exact and near-dup (MinHash/SimHash); mitigate contamination and overfitting.
4. heuristic/classifier filters (toxicity, spam), quality scoring, temperature sampling.
5. train vocab (BPE/Unigram), pre-tokenize, pack sequences respecting EOD.
Tokenization: [HF Tokenizers](https://huggingface.co/docs/tokenizers/en/index), 
6. domain/language balance, curriculum, up/down-sampling.
7. Arrow/Parquet/WebDataset, deterministic sharding, resume-safe streaming.
Arrow: [HF Datasets](https://huggingface.co/docs/datasets/about_arrow)
8. Remove overlaps with evals; versioning, lineage, dashboards.
Checkpoint/logging: [HF Trainer](https://huggingface.co/docs/transformers/en/trainer)
9. benchmark language understanding, reasoning, QA etc. Bias, stereotype, toxicity and answer safety checks.
10. Ethical charter, inspection tools for data composition, licensing, artifact release for reproducibility and further research. 

References (arXiv):

- The Pile: https://arxiv.org/abs/2101.00027  

- CCNet: https://arxiv.org/abs/1911.00359

- RefinedWeb: https://arxiv.org/abs/2306.01116

- Dolma: https://arxiv.org/abs/2306.07196

- T5/C4: https://arxiv.org/abs/1910.

- End-to-end Data preprocessing libraries: 
  https://github.com/huggingface/datatrove/
  https://github.com/NVIDIA-NeMo/Curator
  https://github.com/webdataset/webdataset

- Classic NLP data preprocessing libararies:
  https://github.com/explosion/spaCy
  https://github.com/nltk/nltk
  https://github.com/stanfordnlp/stanza

## Post-training

**Goal**: Align base LLMs via supervised fine-tuning and preference optimization.

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


post-processing libraries:
tokenizations; https://huggingface.co/docs/transformers/fast_tokenizers