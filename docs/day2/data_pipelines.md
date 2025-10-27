---
tags:
  - Data pipelines
icon: octicons/workflow-16
---

# Data Pipelines

???- info "Learning outcomes"

    - Understand the key components of data pipelines for LLMs  
    - Perform data preparation for a pre-training task

![Data meme](./figures/data_meme.jpg){ align=right width=300 }

- Well-designed data pipelines determine LLM quality, safety, and training throughput.

- Success of all frontier models like GPT-5 relies heavily on quality data and costructing effecient pipelines around it that reduces training compute and improves the capabilities of the model that we desire it to have.

## Pre-training

**Goal:** Assemble large, diverse, governed corpora and feed tokens efficiently to the model to learn general-purpose representations.

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


???- info "Full reproduction of the FineWeb dataset"

    ```python title="fineweb.py"

    --8<-- "https://raw.githubusercontent.com/huggingface/datatrove/refs/heads/main/examples/fineweb.py"

    ```


???- info "Resources"

    - LLM papers on data and data pipelines:

        - [The Pile: An 800GB Dataset of Diverse Text for Language Modeling](https://arxiv.org/abs/2101.00027)
        - [CCNet: Extracting High Quality Monolingual Datasets from Web Crawl Data](https://arxiv.org/abs/1911.00359)
        - [The RefinedWeb Dataset for Falcon LLM: Outperforming Curated Corpora with Web Data, and Web Data Only](https://arxiv.org/abs/2306.01116)
        - [Dolma: an Open Corpus of Three Trillion Tokens for Language Model Pretraining Research](https://arxiv.org/abs/2306.07196)
        - [RedPajama: an Open Dataset for Training Large Language Models](https://arxiv.org/pdf/2411.12372)
 
    - End-to-end Data preprocessing libraries:
        - [HF datatrove](https://github.com/huggingface/datatrove/)
        - [Nvidia Curator](https://github.com/NVIDIA-NeMo/Curator)
        - [Webdataset](https://github.com/webdataset/webdataset)

    - Classic NLP data preprocessing libararies:
        - [Explosion spaCy](https://github.com/explosion/spaCy)
        - [NLTK](https://github.com/nltk/nltk)
        - [StanfordNLP Stanza](https://github.com/stanfordnlp/stanza)



## Post-training

**Goal**: Align base LLMs to new tasks or improve its existing abilities in chat-based dialogs, structured tasks or domain-specific data.

This aligning is done via supervised fine-tuning and preference optimization (reward modelling or RLHF/RLAIF).

<div class="annotate" markdown>

- Collection and cleaning (1)

- Curation (2)

- Transformation (3)

- Validation (4)

</div>

1. Instruction–response pairs, multi-turn formatting style and tool-use coverage. Synthetic data generation.  
2. PII filtering and annotation by humans or AI. Ranking and scoring by humans or smaller models for Reward modelling. Deduplication.  
3. Tokenization, formatting into chat templates, sharding and packing for effecient GPU training.  
Tokenizers: [HF Fast-tokenizer](https://huggingface.co/docs/transformers/fast_tokenizers)
4. Schema validataion (e.g. via pydantic), quality checks, benchmarking and collecting stats.

???- info "Resources"

    - LLM papers on data and data pipelines:

        - [Training language models to follow instructions with human feedback](https://arxiv.org/abs/2203.02155)
        - [Direct Preference Optimization: Your Language Model is Secretly a Reward Model](https://arxiv.org/abs/2305.18290)
        - [Constitutional AI: Harmlessness from AI Feedback](https://arxiv.org/abs/2212.08073)
        - [LIMA: Less Is More for Alignment](https://arxiv.org/abs/2305.11206)
        - [Self-Instruct: Aligning Language Models with Self-Generated Instructions](https://arxiv.org/abs/2212.10560)


https://learn.deeplearning.ai/courses/pretraining-llms/lesson/xfpqx/data-preparation
https://learn.deeplearning.ai/courses/pretraining-llms/lesson/wqgv4/packaging-data-for-pretraining
