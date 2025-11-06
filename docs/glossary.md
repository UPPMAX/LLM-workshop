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

### API (Application Programming Interface)
A set of protocols and endpoints that allow different software applications to communicate. LLM services often provide OpenAI-compatible APIs for inference requests.

### Autoregressive
A modeling approach where outputs are generated sequentially, with each token conditioned on previously generated tokens. Most decoder-only LLMs use autoregressive generation.

---

## B

### Benchmark
Standardized tests used to evaluate and compare LLM performance across different capabilities like reasoning (BBH), mathematics (MATH, GSM8K), or world knowledge (MMLU).

### BF16 (Brain Float 16)
A 16-bit floating point format developed by Google with the same range as FP32 but reduced precision. Favored in ML for maintaining numerical stability while reducing memory usage.

---

## C

### ChatGPT
OpenAI's conversational AI system based on GPT models, fine-tuned with instruction following and RLHF. Released in November 2022, bringing LLMs to mainstream attention.

### Closed Source
Models where weights and architecture are proprietary and not publicly accessible. Users can only interact via APIs. Examples: GPT-4, Claude.

### Context Window
The maximum sequence length an LLM can process at once. Determines how much text (prompt + previous conversation) the model can consider when generating responses.

---

## D

### Data Parallelism
A parallelization strategy where identical model copies process different data batches simultaneously. Gradients are synchronized across replicas during training.

### Decoder
The component of transformer architecture that generates output tokens. Decoder-only models like GPT are commonly used for text generation tasks.

### Deep Learning
Machine learning using multi-layered neural networks. The 2012 AlexNet breakthrough and 2017 transformer architecture marked key milestones in modern deep learning.

---

## E

### Embeddings
Dense vector representations of tokens or text that capture semantic meaning. Used in retrieval systems and as input to transformer models.

### Encoder
The transformer component that processes input sequences to create contextual representations. BERT uses encoder-only architecture for understanding tasks.

---

## F

### Fine-tuning
Adapting a pre-trained model to specific tasks or domains using specialized datasets. More efficient than training from scratch and requires fewer resources.

### FP16/FP32 (Floating Point 16/32)
IEEE 754 standard floating-point formats with 16 or 32 bits. FP32 is standard precision; FP16 reduces memory and increases speed with some accuracy trade-off.

---

## G

### GGUF (GPT-Generated Unified Format)
A file format for storing LLM weights developed for llama.cpp. Supports multiple quantization formats and is memory-mapped for efficient loading.

### GPU (Graphics Processing Unit)
Specialized hardware accelerator designed for parallel computations. Essential for training and running large language models efficiently.

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

### LLM (Large Language Model)
Neural networks with billions of parameters trained on massive text corpora to understand and generate human-like text. Examples: GPT, LLaMA, Gemini.

### LoRA (Low-Rank Adaptation)
An efficient fine-tuning technique that updates only small low-rank matrices instead of all model weights, drastically reducing memory requirements and training time.

---

## M

### MMLU (Massive Multitask Language Understanding)
A benchmark covering 57 subjects to test models' world knowledge and problem-solving across diverse academic and professional domains.

### Multimodal
Models that process and generate multiple types of data (text, images, audio, video). Examples: GPT-4 Vision, Gemini.

---

## N

### Neural Network
Computing systems inspired by biological brains, consisting of interconnected layers of nodes that learn patterns through adjusting weights during training.

### NLP (Natural Language Processing)
The field of AI focused on enabling computers to understand, interpret, and generate human language.

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

### RLHF (Reinforcement Learning from Human Feedback)
Training technique using human preferences to fine-tune models, making them more helpful, harmless, and aligned with human values. Key to ChatGPT's capabilities.

---

## S

### Self-Attention
Mechanism where each token in a sequence computes relationships with all other tokens, enabling models to capture long-range dependencies and context.

### SLURM
A batch queue system for managing and scheduling computational jobs on HPC clusters, allocating resources fairly among users.

### Supervised Fine-Tuning (SFT)
Fine-tuning with labeled input-output pairs to teach models specific behaviors or task formats, often the first step before RLHF.

---

## T

### Temperature
A sampling parameter controlling randomness in generation. Lower values (0.1-0.5) produce focused outputs; higher values (0.7-1.5) increase creativity and diversity.

### Tensor Parallelism
Splitting individual weight matrices across multiple devices, distributing computation at the operation level. Requires fast interconnects between GPUs.

### Token
The basic unit of text processing in LLMs. Can represent words, subwords, or characters depending on the tokenization algorithm used.

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

### Weights
The learned parameters of neural networks that are adjusted during training. Model size is typically described by the number of parameters (e.g., 70B for 70 billion parameters).

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
