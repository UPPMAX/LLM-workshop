#!/bin/bash -l
#SBATCH -t 1:00:00
#SBATCH --nodes 1
#SBATCH --gpus-per-node "A40:1"

module purge

export HF_MODEL="/mimer/NOBACKUP/Datasets/LLM/huggingface/hub/models--openai--gpt-oss-20b/snapshots/cbf31f62664d4b1360b3a78427f7b3c3ed8f0fa8/"
export MODEL_NAME=$(echo "$HF_MODEL" | sed -n 's#.*/models--\([^/]*\)--\([^/]*\)/.*#\1/\2#p')
export SIF_IMAGE=/apps/containers/vLLM/vllm-0.11.0.sif

# start vllm server
vllm_opts="--tensor-parallel-size=${SLURM_GPUS_ON_NODE} --max-model-len=10000"
export API_PORT=$(find_ports)

echo "Starting server node"
apptainer exec ${SIF_IMAGE} vllm serve ${HF_MODEL} \
   --port ${API_PORT} ${vllm_opts} \
   --served-model-name $MODEL_NAME \
   > vllm.out 2> vllm.err &
VLLM_PID=$!
sleep 20

# wait at most 10 min for the model to start, otherwise abort
if timeout 600 bash -c "tail -f vllm.err | grep -q 'Application startup complete'"; then
    curl http://localhost:$API_PORT/v1/chat/completions -H "Content-Type: application/json" -d '{
        "model": "openai/gpt-oss-20b",
        "messages": [
            { "role": "user", "content": "why is the sky blue" }
        ],
        "temperature": 0.6
    }'
    echo "========================================================================"
    apptainer exec ${SIF_IMAGE} python3 openai_chat.py
else
    echo "vLLM doesn't seem to start, aborting"
fi

echo "Terminating VLLM" && kill -15 ${VLLM_PID}

