---
title: Evaluation Metrics
icon: octicons/graph-16
---

## Motivation
- Tracking progress
- Reproducibility
- Helping informed decisions

<!-- TODO
- Apples-to-apples (size, precision)
- Goodhart's law
- Bad datasets https://en.wikipedia.org/wiki/MMLU#Limitations
- Benchmark gaming
-->

## Evaluation
- Generic benchmarks
- AI-based evaluation
- Task specific benchmarks

### General benchmarks
- [MMLU](https://doi.org/10.48550/arXiv.2009.03300)/[MMLU-Pro](https://doi.org/10.48550/arXiv.2406.01574)
- [Big-bench](https://doi.org/10.48550/arXiv.2206.04615)
- [GPQA](https://doi.org/10.48550/arXiv.2311.12022)
- [HLE](https://agi.safe.ai/)

### AI-based evaluations
- [LLM-as-a-judge](https://huggingface.co/learn/cookbook/llm_judge)
- Human evaluation of subset to evaluate evaluator
- Make sure to prompt LLM-judge scale to be used

### Task specific benchmarks
- Tool use: [MCP-bench](https://github.com/Accenture/mcp-bench), [tau2-Bench](https://github.com/sierra-research/tau2-bench)
- Coding: [SWE-bench](https://github.com/SWE-bench/SWE-bench), [HumanEval](https://github.com/openai/human-eval), [WeirdML](https://htihle.github.io/weirdml.html)
- Math: [U-Math](https://toloka.ai/math-benchmark), [FrontierMath](https://epoch.ai/frontiermath)

## Constructing your own benchmarks
- Good example: [R&D-bench](https://metr.org/blog/2024-11-22-evaluating-r-d-capabilities-of-llms/)

## The NeMo Evaluator collection
- Collection of other evaluation harnesses and specific benchmarks
- Provides a collection of docker containers
- Build with e.g. `apptainer pull nvcr.io/nvidia/eval-factory/lm-evaluation-harness:25.10`
- Collection: 

## Exercise
<!-- TODO find smallest eval in NeMo Evaluator and run that -->
- Try running evals against vLLM endpoint instructor set-up
- Make sure to set `HF_HOME` as datasets will be downloaded when running
- Launch interactive job `srun -A NAISS2025-22-1522 -t 30 -C NOGPU -c 2 --pty bash`
- Run portforwarding to expose port from alvis2
- Run with e.g. `apptainer exec container.sif nemo-evaluator run_eval --run_config config.yaml --eval_type=mmlu`
- Config (port may be different):

```yaml
target:
  api_endpoint:
    url: http://localhost:34253/v1/completions
    model_id: QuantTrio/GLM-4.5-Air-GPTQ-Int4-Int8Mix
    type: completions
```
