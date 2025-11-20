#!/bin/bash
#SBATCH --gpus-per-node=A40:4
#SBATCH --time=2:00:00

export VLLM_API_PORT=$(find_ports) # get a random port
NGPUS=${SLURM_GPUS_ON_NODE:-1}

export APPTAINERENV_VLLM_DISABLE_COMPILE_CACHE=1

### Llama-3.2-11B-Vision-Instruct
VLLM_SIF=/apps/containers/vLLM/vllm-0.9.1.sif
HF_MODEL=/mimer/NOBACKUP/Datasets/LLM/huggingface/hub/models--unsloth--Llama-3.2-11B-Vision-Instruct/snapshots/677b0c1b7008230a0fb88708c5550748e72b9a83/
MODEL_NAME=$(echo "$HF_MODEL" | sed -n 's#.*/models--\([^/]*\)--\([^/]*\)/.*#\1/\2#p')

vllm_opts="--tensor-parallel-size=$NGPUS"
vllm_opts+=" --max-model-len=10000"
vllm_opts+=" --no-use-tqdm-on-load"
vllm_opts+=" --max-num-seqs=16"
vllm_opts+=" --enforce-eager"
vllm_opts+=" --limit-mm-per-prompt.image 2"  # multimodal
vllm_opts+=" --limit-mm-per-prompt.video 1"  # multimodal
vllm_opts+=" --allowed-local-media-path=${HOME}"  # multimodal

apptainer exec $VLLM_SIF \
    vllm serve ${HF_MODEL} \
        --served-model-name $MODEL_NAME \
        --port ${VLLM_API_PORT} \
        ${vllm_opts} \
        > vllm.out 2> vllm.err &
VLLM_PID=$!
sleep 20

IMGURL="https://cdn.eso.org/images/screen/eso2105a.jpg"
cat > payload.json << EOF
{
    "model": "$MODEL_NAME",
    "messages": [
        {
            "role": "user",
            "content": [
                {"type": "text", "text": "What is shown in the image?"},
                {"type": "image_url", "image_url": {"url": "$IMGURL"}}
            ]
        }
    ],
    "temperature": 0
}
EOF

wget $IMGURL

if timeout 600 bash -c "tail -f vllm.err | grep -q 'Application startup complete'"; then
    echo "vLLM is running. Sending test request"
    curl http://localhost:$VLLM_API_PORT/v1/chat/completions \
        -H "Content-Type: application/json; charset=utf-8" \
        -d @payload.json | jq
    echo "========================================================================"
    apptainer exec $VLLM_SIF python3 openai_multimodal.py
else
    echo "vLLM doesn't seem to start, aborting"
    echo "Terminating VLLM" && kill -15 ${VLLM_PID}
    exit
fi


