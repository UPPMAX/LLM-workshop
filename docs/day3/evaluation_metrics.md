---
title: Evaluation Metrics
icon: octicons/graph-16
---

## Motivation
<style type="text/css" rel="stylesheet">
.reveal section {
  text-align: center;
}
</style>
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

### Collections
- <https://epoch.ai/benchmarks>
- <https://docs.nvidia.com/nemo/evaluator/latest/evaluation/benchmarks.html#benchmark-categories>
- <https://huggingface.co/docs/leaderboards/open_llm_leaderboard/about>

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

### NeMo Evaluator CLI
- `nemo-evaluator ls`: list available benchmarks
- `nemo_evaluator run_eval ...`: run one or more benchmarks

### NeMo Evaluator Python SDK
- Run benchmarks from Python code
- Configure your own benchmark

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

### Instructor set-up
We are running an vLLM instance on a compute node and forwarding the port to
`alvis2` log-in node. The relevant port number will be in
`/mimer/NOBACKUP/groups/llm-workshop/exercises/day3/tools/_instructor/.vllm_alvis2_port`.

### Interactive node set-up
1. Allocate an interactive job `srun -A NAISS2025-22-1522 -t 30 -C NOGPU --pty bash`
2. Forward the port from alvis2
3. Set-up NeMo Evaluator config file
4. Set `HF_HOME` to `$TMPDIR` (usually this would be project storage)
5. Run parts of a benchmark with NeMo Evaluator

Steps 2 and onwards:
```bash
# Prepare local port
my_vllm_port=$(find_ports)  # local port
echo my_vllm_port=$my_vllm_port
ssh -L $my_vllm_port:localhost:$(cat /mimer/NOBACKUP/groups/llm-workshop/exercises/day3/tools/_instructor/.vllm_alvis2_port) -fN alvis2  # port forwarding

# Create config file
echo "
target:
  api_endpoint:
    url: http://localhost:${my_vllm_port}/v1/completions
    type: completions
    #  url: http://localhost:${my_vllm_port}/v1/chat
    #  type: chat
    model_id: QuantTrio/GLM-4.5-Air-GPTQ-Int4-Int8Mix

config:
    params:
        parallelism: 1
        request_timeout: 600
" > my_nemo_config.yaml

# Set HF_HOME to not have stuff put in your home dir
HF_HOME="$TMPDIR/hf"

# Run partial benchmark
apptainer exec /apps/containers/NeMo/Evaluator/NeMo-Evaluator-LM-Evaluation-Harnesk-NGC-25.10.sif nemo-evaluator run_eval --run_config my_nemo_conf.yaml --output_dir="${TMPDIR:-/tmp/}/$USER" --eval_type bbq --override="config.params.limit_samples=10"
```

### Possible complications
- Some LM Harness benchmarks require tokenizer to be specified. Possible solutions:
    - Install NeMo Evaluator on-top of vLLM and launch your model with NeMo Evaluator launcher
    - Run LM Harness directly with a custom model using both endpoint and tokenizer
- Endpoint down
    - If you're not running this during the workshop session you will have to launch your own vLLM instance
    - See `exercises/tools/_instructor/launch_GLM.sbatch`
