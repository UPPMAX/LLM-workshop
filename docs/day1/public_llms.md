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


    ???- question "Quiz yourself!"

        ???- note inline end "Answer key"
    
            1:A, 2:B, 3:C


        1. What distinguishes "Publicly Available" models from "Closed Source" models in the document?  
        A. Publicly available means model checkpoints can be publicly accessible (terms can still apply). Closed source means the opposite.  
        B. Publicly available models always permit commercial use without restrictions.  
        C. Publicly available models are only accessible via an API.  
        D. Publicly available models are always smaller and less capable than closed-source models.
        
        2. Where to begin your search for publicly available models
        A. Academic papers and technical reports    
        B. Model hub & model cards on Hugging Face  
        C. Official vendor pages and API docs (e.g., OpenAI, Meta, Google)  
        D. Community leaderboards, GitHub repos, and discussion forums  

        3. Which category from the table typically allows redistribution of weights and derivatives?  
        A. Open Source (OSI‑compatible)  
        B. Open Weights (restricted / gated)  
        C. Adapter‑only / Delta releases  
        D. Proprietary API‑only  


## The DeepSeek Moment 🚀

![Open AI vs Deepseek meme](./figures/openai_vs_deepseek.png){align=right width="250" }

The release of DeepSeek-R1 in January 2025 marked a pivotal "DeepSeek moment" in the LLM landscape. This open-weight model demonstrated that it could match or even exceed the performance of leading closed-source models like GPT-4o and Claude-3.5-Sonnet across multiple benchmarks, while being trained at a fraction of the cost (~$5.5M vs hundreds of millions). 

DeepSeek's achievement proved that world-class AI capabilities are no longer exclusive to well-funded closed-source providers, fundamentally shifting the competitive dynamics and accessibility of cutting-edge language models.


## Arena ⚖️

<figure markdown="span">
  ![Open vs Closed Models](./figures/open-vs-close.png){align=left width="700" }
  <figcaption>Narrowing performance gap on MMLU benchmark (Apr 2022 - July 2025) with human domain experts at 89.8%</figcaption>
</figure>

Open-weight models are catching up with closed source models steadily[^1][^9]. However, creating high-quality benchmarks is an active area of research as the existing ones are beginning to plateau. 

## Categories 📂

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


## Leaderboard 🏆
[:hugging: Open LLM Leaderboard](https://huggingface.co/spaces/open-llm-leaderboard/open_llm_leaderboard#/)

<iframe
  src="https://open-llm-leaderboard-open-llm-leaderboard.hf.space"
  frameborder="0"
  width="1200"
  height="450"
></iframe>

!!!- note "Open LLM leaderboard has retired"

    To check community owned leaderboards head to : [OpenEvals](https://huggingface.co/OpenEvals/collections)

Other notable leaderboards:  
 - [HELM](https://crfm.stanford.edu/helm/latest/) (Holistic Evaluation of Language Models by Stanford)  
 - [LMArena](http://lmarena.ai/leaderboard) (focus on open-weight models by UC Berkeley)

## Benchmarks to consider 📊

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

??? - note "Popular benchmarks for Vision Language Models"

    * [MathVista](https://arxiv.org/abs/2310.02255): evaluates mathematical reasoning in the context of images.
    * [AI2D](https://arxiv.org/abs/1603.07396): focuses on diagram understanding.
    * [ScienceQA](https://arxiv.org/abs/2209.09513): science question answering.
    * [OCRBench](https://arxiv.org/abs/2501.00321): assesses document understanding and OCR capabilities.
    
    [Leaderboard for VLMs](https://huggingface.co/spaces/opencompass/open_vlm_leaderboard) 

??? - note "Detailed benchmark coverage per open-weight model provider"

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

