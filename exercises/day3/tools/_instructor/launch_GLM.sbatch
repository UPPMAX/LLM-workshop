#!/usr/bin/env bash
#SBATCH -A C3SE-STAFF
#SBATCH --gpus-per-node=A40:4
#SBATCH -t 8:00:00

# Environment
module purge
vllm_sif=/apps/containers/vLLM/vllm-0.11.0.sif

# Model
hf_model="/mimer/NOBACKUP/Datasets/LLM/huggingface/hub/models--QuantTrio--GLM-4.5-Air-GPTQ-Int4-Int8Mix/snapshots/1c98fb7603baad6661067ad2a1c745ae7e9f6286"
model_name=$(echo "$hf_model" | sed -n 's#.*/models--\([^/]*\)--\([^/]*\)/.*#\1/\2#p')

# Set local port
local_vllm_port="$(find_ports)"

# vLLM options
vllm_opts=(
    "--host=0.0.0.0"
    "--port=${local_vllm_port}"
    "--served-model-name=$model_name"
    "--no-use-tqdm-on-load"
    "--tensor-parallel-size=$SLURM_GPUS_ON_NODE"
    "--enable-expert-parallel"
    "--enable-auto-tool-choice"
    "--tool-call-parser=glm45"
)

# Set cache
export APPTAINERENV_VLLM_CACHE_ROOT=${TMPDIR}/cache
export APPTAINERENV_VLLM_CONFIG_ROOT=${TMPDIR}/config

# Remote port forwarding to make the port accessible on alvis2
# N.B. not recommended in general everyone can access your instance
# contact support if you want a better option https://supr.naiss.se/support
remote_vllm_port="$(ssh alvis2 find_ports)"
ssh -N -f -R ${remote_vllm_port}:localhost:${local_vllm_port} alvis2
echo ${remote_vllm_port} > .vllm_alvis2_port

echo
echo "Opening vLLM endpoint on alvis2 and port ${remote_vllm_port}"
echo

# Launch vLLM inference server
apptainer exec "${vllm_sif}" vllm serve "${hf_model}" "${vllm_opts[@]}"
