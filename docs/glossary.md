---
hide:
  - navigation
tags:
  - glossary
  - terminology
icon: material/book-alphabet
---

# Glossary

This glossary provides concise definitions of key terms and concepts used throughout the LLM workshop materials.

---

## A

### Attention Mechanism
A technique that allows models to focus on relevant parts of input when processing data. The scaled dot-product attention computes relationships between tokens, enabling transformers to understand context efficiently.

### Autoregressive
A modeling approach where outputs are generated sequentially, with each token conditioned on previously generated tokens. Most decoder-only LLMs use autoregressive generation.

---

## B

### Benchmark
Standardized tests used to evaluate and compare LLM performance across different capabilities like reasoning (BBH), mathematics (MATH, GSM8K), or world knowledge (MMLU).

### Beam Search
A search algorithm that explores multiple candidate sequences simultaneously by maintaining the top-K most likely paths at each step, improving generation quality over greedy decoding.

### BF16 (Brain Float 16)
A 16-bit floating point format developed by Google with the same range as FP32 but reduced precision. Favored in ML for maintaining numerical stability while reducing memory usage.

### BPE (Byte-Pair Encoding)
A tokenization algorithm that iteratively merges the most frequent character or character sequence pairs, creating a vocabulary that balances between character-level and word-level representations.

---

## C

### Chain-of-Thought (CoT)
A prompting technique where the model is encouraged to break down complex reasoning into step-by-step intermediate thoughts before arriving at a final answer, significantly improving performance on reasoning tasks.

### Closed Source
Models where weights and architecture are proprietary and not publicly accessible. Users can only interact via APIs. Examples: GPT-4, Claude.

### Constitutional AI
An alignment technique where models are trained to follow a set of principles or "constitution" through AI-generated feedback, reducing reliance on human annotation for harmless behavior.

### Context Window
The maximum sequence length an LLM can process at once. Determines how much text (prompt + previous conversation) the model can consider when generating responses.

### Continuous Batching
A serving optimization that dynamically groups requests into batches as they arrive, improving throughput compared to static batching by minimizing idle GPU time.

---

## D

### Data Parallelism
A parallelization strategy where identical model copies process different data batches simultaneously. Gradients are synchronized across replicas during training.

### Decontamination
The process of removing evaluation benchmark data from training sets to ensure fair and unbiased model assessment, preventing inflated performance due to data leakage.

### Deduplication
Removing exact or near-duplicate examples from training data using techniques like MinHash or SimHash to reduce redundancy, improve training efficiency, and mitigate memorization.

### DPO (Direct Preference Optimization)
A simpler alternative to RLHF that directly optimizes models on preference data without requiring a separate reward model, making alignment training more efficient.

---

## E

### Expert Parallelism
A parallelization strategy for Mixture of Experts models where different experts are distributed across devices, with routing mechanisms directing tokens to appropriate experts based on learned gating functions.

---

## F

### Few-Shot Learning
The ability of models to learn new tasks from just a few examples provided in the prompt, without updating model weights. Demonstrates strong in-context learning capabilities.

### Fine-tuning
Adapting a pre-trained model to specific tasks or domains using specialized datasets. More efficient than training from scratch and requires fewer resources.

### Flash Attention
An optimized attention implementation that reduces memory usage and increases speed by chunking computations and minimizing memory reads/writes through kernel fusion.

### FP16/FP32 (Floating Point 16/32)
IEEE 754 standard floating-point formats with 16 or 32 bits. FP32 is standard precision; FP16 reduces memory and increases speed with some accuracy trade-off.

---

## G

### GGUF (GPT-Generated Unified Format)
A file format for storing LLM weights developed for llama.cpp. Supports multiple quantization formats and is memory-mapped for efficient loading.

### GPTQ (Generative Pre-trained Transformer Quantization)
A post-training quantization method that minimizes error by weighting parameter importance using inverse Hessian approximation.

---

## H

### HPC (High-Performance Computing)
Computing infrastructure with powerful nodes, fast interconnects, and parallel storage designed for intensive computational tasks like LLM training.

### Hyperparameter
Configuration values set before training that control the learning process, such as learning rate, batch size, or model architecture choices.

---

## I

### Inference
The process of using a trained model to generate predictions or outputs. For LLMs, this involves generating text based on input prompts.

### Infiniband
A high-speed networking technology providing low latency and high bandwidth for inter-node communication in HPC clusters, essential for efficient multi-node model training.

### Instruct Tuning
Fine-tuning models on instruction-following datasets to improve their ability to understand and execute user commands accurately.

---

## K

### KV Cache (Key-Value Cache)
Cached intermediate results from attention computation that avoid redundant calculations during autoregressive generation, trading memory for speed.

---

## L

### LangChain
An open-source framework for building LLM applications, providing tools for chains, agents, retrieval, and integration with various data sources.

### LlamaIndex
An open-source data framework for connecting LLMs with external data sources, specializing in indexing, retrieval, and query engines for RAG applications.

### LoRA (Low-Rank Adaptation)
An efficient fine-tuning technique that updates only small low-rank matrices instead of all model weights, drastically reducing memory requirements and training time.

---

## M

### MCP (Model Context Protocol)
A standardized protocol for connecting LLMs with external tools and data sources, enabling models to interact with APIs, databases, and other services in a controlled manner.

### MMLU (Massive Multitask Language Understanding)
A benchmark covering 57 subjects to test models' world knowledge and problem-solving across diverse academic and professional domains.

### Mixture of Experts (MoE)
An architecture where the model contains multiple "expert" sub-networks, with a gating mechanism routing each input to a subset of experts, enabling larger models with lower computational cost.

### Multimodal
Models that process and generate multiple types of data (text, images, audio, video). Examples: GPT-4 Vision, Gemini.

---

## N

---

## O

### Open Source
Models with publicly available weights and code under permissive licenses (Apache-2.0, MIT), allowing unrestricted use, modification, and redistribution.

### Open Weights
Models with publicly accessible weights but usage restrictions. Not fully open source. Examples: LLaMA (Meta Llama Community License), Gemma.

---

## P

### Paged Attention
A memory optimization technique that manages KV cache in fixed-size blocks, similar to virtual memory in operating systems, enabling efficient GPU memory utilization.

### Perplexity
A metric measuring how well a language model predicts a sample, calculated as the exponentiated average negative log-likelihood. Lower perplexity indicates better prediction.

### Pipeline Parallelism
A parallelization strategy that splits models across devices vertically (by layers), with different devices processing different pipeline stages simultaneously.

### Pre-filling
The initial phase of LLM inference where the entire input prompt is processed in parallel to compute the KV cache before token generation begins.

### Prompt Engineering
The practice of crafting effective input prompts to elicit desired responses from LLMs, including techniques like few-shot learning and chain-of-thought reasoning.

---

## Q

### Quantization
Reducing numerical precision of model weights and activations (e.g., from FP32 to INT8) to decrease memory usage and increase inference speed with minimal accuracy loss.

### QAT (Quantization-Aware Training)
Training that incorporates quantization operations, allowing models to adapt and maintain accuracy despite reduced precision.

---

## R

### RAG (Retrieval Augmented Generation)
A technique combining LLMs with external knowledge retrieval to provide contextually relevant, up-to-date information without retraining the model.

### ReAct (Reasoning and Acting)
A prompting framework that interleaves reasoning traces with action executions, enabling models to dynamically interact with external tools while solving problems through explicit reasoning steps.

### RLHF (Reinforcement Learning from Human Feedback)
Training technique using human preferences to fine-tune models, making them more helpful, harmless, and aligned with human values.

---

## S

### Self-Attention
Mechanism where each token in a sequence computes relationships with all other tokens, enabling models to capture long-range dependencies and context.

### SLURM
A batch queue system for managing and scheduling computational jobs on HPC clusters, allocating resources fairly among users.

### Speculative Decoding
An inference optimization where a smaller draft model generates candidate tokens that a larger target model verifies in parallel, reducing latency while maintaining quality.

### Supervised Fine-Tuning (SFT)
Fine-tuning with labeled input-output pairs to teach models specific behaviors or task formats, often the first step before RLHF.

---

## T

### Temperature
A sampling parameter controlling randomness in generation. Lower values (0.1-0.5) produce focused outputs; higher values (0.7-1.5) increase creativity and diversity.

### Tensor Parallelism
Splitting individual weight matrices across multiple devices, distributing computation at the operation level. Requires fast interconnects between GPUs.

### Tokenization
The process of converting text into discrete units (tokens) that can be processed by language models, using algorithms like BPE or WordPiece to balance vocabulary size and coverage.

### Top-K Sampling
Generation strategy that samples from the K most likely next tokens, balancing diversity and coherence in model outputs.

### Top-P (Nucleus) Sampling
Sampling from the smallest set of tokens whose cumulative probability exceeds threshold P, dynamically adjusting the candidate pool based on confidence distribution.

### Transformer
Neural network architecture introduced in "Attention Is All You Need" (2017) that uses self-attention mechanisms, enabling parallel processing and superior performance on sequence tasks.

---

## V

### Vector Store
Database optimized for storing and querying high-dimensional embeddings, enabling fast similarity search for retrieval applications.

### vLLM
A high-throughput inference library featuring PagedAttention and continuous batching, optimized for serving LLMs efficiently at scale.

### VRAM (Video Random Access Memory)
Memory on GPU cards used to store model weights, activations, and KV cache during LLM operations. Often the primary bottleneck for running large models.

---

## W

---

## Z

### Zero-Shot
The ability of models to perform tasks without task-specific training examples, relying solely on pre-training knowledge and prompt instructions.

---

## References

For deeper understanding of these concepts, refer to the workshop materials:

- [Introduction](day1/introduction.md) - AI history, transformers, and compute
- [Public LLMs](day1/public_llms.md) - Model categories and benchmarks
- [LLM Hardware](day1/llm_hardware.md) - Hardware considerations and HPC
- [LLM Formats](day1/llm_formats.md) - Model formats and quantization
- [RAG](day2/rag.md) - Retrieval augmented generation
- [Parallelization](day2/parallelization_schemes.md) - Distributed computing strategies
- [Prompt Engineering](day3/prompt_engineering.md) - Effective prompt design
- [Fine-tuning](day3/fine_tuning.md) - Model adaptation techniques
