#!/usr/bin/env bash
#SBATCH -A NAISS2025-22-1522
#SBATCH -t 5
#SBATCH --gpus-per-node=A40:1

ml purge
container="/apps/containers/vLLM/vllm-0.11.0.sif"
apptainer exec "$container" python3 async_llm_streaming.py


# TODO use vllm run-batch instead? https://docs.vllm.ai/en/stable/cli/index.html#run-batch
