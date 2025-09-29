---
tags:
  - Public llm
  - Introduction
---

# Brief introduction to publicly available LLMs

LLMs come in wide-range of "openness":

| Category                     | Inference Availability | Fine-Tuning Availability | Access Method           | Typical License / Restrictions     | Examples                          |
|------------------------------|-------------------------|---------------------------|-------------------------|------------------------------------|-----------------------------------|
| **Closed / Proprietary**     | ✅ (via API only)       | ⚠️ Limited (via API only, if offered) | API (no weights)       | Proprietary, no weights shared     | GPT-4, Claude, Gemini             |
| **Open-Weight**              | ✅ (local & hosted)     | ✅ (local fine-tuning)     | Download weights        | Mixed (permissive or research-only)| LLaMA, Mistral, Falcon            |
| **Open-Source (Full Stack)** | ✅ (local & hosted)     | ✅ (local fine-tuning, full retraining possible) | Code + weights + data | Permissive open-source (e.g., Apache 2.0, MIT) | BLOOM, GPT-NeoX, Pythia           |
| **Hybrid (Weights + API)**   | ✅ (both API & local)   | ✅ (local fine-tuning, sometimes API too) | Both API & weights     | Depends (permissive or research-only) | Hugging Face-hosted LLaMA/Mistral |
| **Partially Open**           | ✅ (depends: API or small released model) | ⚠️ Sometimes (e.g., only on smaller versions) | Weights-only or partial release | Often research/non-commercial     | LLaMA-2 (restricted), OPT         |
| **Community Reproduced**     | ✅ (local & hosted)     | ✅ (local fine-tuning)     | Weights + open infra    | Usually permissive                 | Alpaca, OpenAssistant, RedPajama  |
| **Frontier / Controlled-Access** | ✅ (heavily gated, API only) | ❌ (no fine-tuning allowed) | Invite-only API         | Strict safety & research controls  | GPT-4 (Research Access Program), Gemini Ultra |



## Leaderboard
[Open LLM Leaderboard](https://huggingface.co/spaces/open-llm-leaderboard/open_llm_leaderboard#/)

## Which model to use?

Focus on a small set of comparable metrics (most appear on the Open LLM Leaderboard or model cards):

Core capability benchmarks (higher is better unless noted)

- MMLU: general academic/world knowledge
- GSM8K: grade‑school math reasoning
- BBH / ARC / HellaSwag / Winogrande: reasoning & commonsense
- HumanEval / MBPP: code synthesis
- TruthfulQA: resistance to misinformation (higher = more truthful)
- MT-Bench / Instruction-following composite: dialogue quality

Model + deployment fit

- License: can you use it commercially? (e.g., Apache 2.0 vs research-only)
- Parameter count & architecture: affects quality vs hardware cost
- Context length: needed for long documents / RAG
- Multilingual support: required? (check benchmark variants or model card)

Efficiency

- Inference latency (tokens/sec on target hardware)
- VRAM / RAM footprint at desired precision (BF16, FP16, 4/8-bit)
- Quantization availability (Q4_K_M, Q6, GPTQ, AWQ)
- Throughput scalability (batching support)

Adaptability

- Fine-tuning options: LoRA, QLoRA, full, adapters
- Available instruct / chat variant (saves tuning effort)
- Tool / function calling support (if integrating with agents)
- Safety / alignment layer (helpful for end-user exposure)

Reliability & safety

- Evaluation variance (multiple seeds?)
- Known failure modes (hallucination, formatting drift)
- Safety / toxicity / jailbreak notes (model card & community reports)

Selection heuristic (fast path)

1. Filter by license + context length + hardware limits.
2. Compare MMLU + GSM8K (general + reasoning) for baseline quality.
3. Add domain benchmark (e.g., HumanEval for code) if relevant.
4. Pick smallest model meeting quality threshold; only move up in size if a key benchmark is lacking.
5. Prototype with quantized variant; move to higher precision only if quality degrades.

Rule of thumb

- Lightweight tasks (classification, simple RAG): 7–13B well-aligned model.
- Reasoning / coding: strongest 14–34B or distilled frontier-tier open model.
- Long-context analysis: prioritize extended context (e.g., 128K) over marginally higher MMLU.

Document your chosen metrics + hardware profile for reproducibility.
