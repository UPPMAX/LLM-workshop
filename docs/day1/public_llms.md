---
tags:
  - Public llm
  - Introduction
icon: material/earth 
---

# Brief introduction to publicly available LLMs

???- info "Learning outcomes"

    - To understand the different categories that LLM comes in
    - To know which matrices to look at for your particular usecase

## Arena


<figure markdown="span">
  ![Open vs Closed Models](./figures/open-vs-close.png){ width="700" }
  <figcaption>Narrowing performance gap on MMLU benchmark (Apr 2022 - July 2025) with human domain experts at 89.8%</figcaption>
</figure>

Open-weight models are catching up with closed source models steadily[^1][^9]. However, creating high-quality benchmarks is an active area of research as the existing ones are beginning to plateau. 

## Categories 

* LLMs come in wide-range of "openness".
* Public != Open.
* “Publicly Available” means that the model checkpoints can be publicly accessible (terms can still apply) while “Closed Source” means the opposite.


| Category (ordered by openness) | Weights available? | Inference | Fine‑tuning | Redistribute weights / derivatives | Typical license | Examples |
|--------------------------------|--------------------|-----------|------------|------------------------------------|-----------------|----------|
| **Open Source (OSI‑compatible)** | ✅ Full | ✅ | ✅ | ✅ | Apache‑2.0 / MIT | Mistral 7B ; OLMo 2 ; Alpaca |
| **Open Weights (restricted / gated)** | ✅ Full | ✅ | ⚠️ License‑bound (e.g., research‑only / carve‑outs) | ❌ Usually not allowed | Custom terms (Llama / Gemma / RAIL) | Llama 3 (Meta Llama 3 Community License); Gemma 2 (Gemma Terms of Use); BLOOM (OpenRAIL) |
| **Adapter‑only / Delta releases** | ⚠️ Partial (adapters/deltas) | ✅ (after applying) | ✅ (adapters) | ✅ Adapters (base license applies) | Mixed | LoRA adapters over a base model |
| **Proprietary API + FT** | ❌ | ⚠️ API-only | ⚠️ API‑only (no weights export) | ❌ | Vendor ToS | OpenAI (GPT‑4.1, o4‑mini FT/RFT); Cohere (Command R/R+ FT); Anthropic (Claude 3 Haiku FT via Bedrock) |
| **Proprietary API‑only** | ❌ | ⚠️ API-only | ❌ | ❌ | Vendor ToS | Google Gemini API|


## Leaderboard
[:hugging: Open LLM Leaderboard](https://huggingface.co/spaces/open-llm-leaderboard/open_llm_leaderboard#/)

<iframe src="https://huggingface.co/spaces/open-llm-leaderboard/open_llm_leaderboard#/" loading="lazy" style="width: 100%; height: 600px; border: 0px none;" allow="web-share; clipboard-write"></iframe>

Other notable leaderboards:
 - [HELM](https://crfm.stanford.edu/helm/latest/) (Holistic Evaluation of Language Models) 
 - [LMArena](https://huggingface.co/spaces/AI-Lab-ML/LMArena) (focus on open-weight models)

## Benchmarks to consider

Focus on a small set of comparable metrics (most appear on the Open LLM Leaderboard or model cards):

Core capability benchmarks (higher is better unless noted)

- MMLU-Pro[^2]: general academic/world knowledge 
- GPQA[^4]: Q&A dataset designed by domain experts (PhD-level))
- MuSR[^5]: Reasoning with very long contexts (up to 100K tokens)
- MATH[^6]: high-school competition math problems
- IFEval[^8]: Testing ability to strictly follow instructions
- BBH[^7]: reasoning & commonsense

| Category                                    | Benchmarks (examples)                       | Orgs with open weights that report them                                                                                                    |
| ------------------------------------------- | ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| **General academic / world knowledge**      | MMLU, MMLU-Pro, CMMLU                       | Meta (LLaMA), Mistral, Cohere, DeepSeek                                                                                                    |
| **Domain expert level**                     | GPQA, CEval, CMMLU                          | Meta (LLaMA papers mention expert subsets), Cohere (Command evals), DeepSeek (reports CEval/CMMLU/GPQA)                                    |
| **Reasoning with long context**             | MuSR, LongBench / long-context evals        | Mistral (Mixtral with long context, reported evals), DeepSeek (long-context benchmarks in tech report)                                     |
| **High-school competition / advanced math** | GSM8K, MATH, AIME                           | Meta (MATH, GSM8K), Mistral (GSM8K, MATH), Cohere (GSM8K), DeepSeek (MATH, GSM8K, AIME)                                                    |
| **Instruction following / alignment**       | IFEval, instruction eval suites             | Meta (instruction-tuned LLaMA), Cohere (Command-R+ evals), DeepSeek (instruction following evals)                                          |
| **Reasoning & commonsense**                 | BBH, HellaSwag, Winogrande, PiQA, ARC, DROP | Meta (HellaSwag, BBH), Mistral (HellaSwag, Winogrande), Cohere (commonsense evals), DeepSeek (HellaSwag, BBH, PiQA, Winogrande, ARC, DROP) |
| **Code completion & debugging**             | HumanEval, MBPP, LeetCode, Codeforces       | Meta (HumanEval), Mistral (HumanEval, MBPP), Cohere (HumanEval, MBPP), DeepSeek (HumanEval, MBPP, LeetCode)                                |

**Note:** Mulitlingual and multimodal benchmarks are not covered here in detail.

??? - info "Detailed benchmark coverage per open-weight model provider"

    | Benchmark                                 |           Meta (LLaMA)           |             Mistral            | Cohere (Command-R+) | DeepSeek |
    | ----------------------------------------- | :------------------------------: | :----------------------------: | :-----------------: | :------: |
    | **MMLU / MMLU-Pro / CMMLU**               |                 ✅                |                ✅               |          ✅          |     ✅    |
    | **GPQA / CEval (expert Q&A)**             |    ⚪ (GPQA subsets in papers)    |         ⚪ (less common)        |          ✅          |     ✅    |
    | **MuSR / LongBench / long-context evals** | ⚪ (not main focus, context ≤32k) | ✅ (Mixtral-8x22B long context) |          ⚪          |     ✅    |
    | **GSM8K (math word problems)**            |                 ✅                |                ✅               |          ✅          |     ✅    |
    | **MATH (competition-level)**              |                 ✅                |                ✅               |          ⚪          |     ✅    |
    | **AIME (advanced math)**                  |                 ⚪                |                ⚪               |          ⚪          |     ✅    |
    | **IFEval / Instruction evals**            |                 ✅                |                ⚪               |          ✅          |     ✅    |
    | **BBH (BigBench Hard)**                   |                 ✅                |                ⚪               |          ⚪          |     ✅    |
    | **HellaSwag**                             |                 ✅                |                ✅               |          ⚪          |     ✅    |
    | **Winogrande**                            |                 ⚪                |                ✅               |          ⚪          |     ✅    |
    | **PiQA**                                  |                 ⚪                |                ⚪               |          ⚪          |     ✅    |
    | **ARC (AI2 Reasoning Challenge)**         |                 ⚪                |                ⚪               |          ⚪          |     ✅    |
    | **DROP (reading comp / commonsense)**     |                 ⚪                |                ⚪               |          ⚪          |     ✅    |
    | **HumanEval (code completion)**           |                 ✅                |                ✅               |          ✅          |     ✅    |
    | **MBPP (Python problems)**                |                 ⚪                |                ✅               |          ✅          |     ✅    |
    | **LeetCode / Codeforces evals**           |                 ⚪                |                ⚪               |          ⚪          |     ✅    |

    ✅ = reported officially in model card / tech report / benchmarks page

    ⚪ = not a primary benchmark for that org (either not reported or only mentioned indirectly)



[^1]: The path forward for large language models in medicine is open. [Nature](https://www.nature.com/articles/s41746-024-01344-w)
[^2]: MMLU-Pro: A More Robust and Challenging Multi-Task Language Understanding Benchmark. [arXiv](https://arxiv.org/pdf/2406.01574)
[^4]: GPQA: A High-Quality Dataset for Evaluating Question Answering in Specialized Domains. [arXiv](https://arxiv.org/abs/2311.12022)
[^5]: MuSR: A Benchmark for Evaluating Mathematical Understanding and Symbolic Reasoning in Large Language Models. [arXiv](https://arxiv.org/abs/2405.12324)
[^6]: MATH: Measuring Mathematical Problem Solving With the MATH Dataset. [arXiv](https://arxiv.org/abs/2311.12022)
[^7]: BBH: Challenging BIG-Bench Tasks and Whether Chain-of-Thought Can Solve Them. [arXiv](https://arxiv.org/abs/2210.09261)
[^8]: IFEval: Instruction-Following Evaluation for Large Language Models. [arXiv](https://arxiv.org/abs/2311.07911)
[^9]: Closed-source vs. open-weight models [LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7378380957889904640/)
