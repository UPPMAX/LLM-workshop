---
tags:
  - multi-modality
  - inference
---

# Multi-Modality

## Introduction

- architecture?
https://arxiv.org/abs/2405.17927

## Inference in vLLM

The way to use multimodal models is similar to using normal LLMs. VLMs can also
be hosted as OpenAI-compatible API servers or loaded as local model instances.
The main difference is the content of data to be sent to the model. Instead of
text-only messages like
```
messages = [
    {"role": "user", "content": "..."},
    ...
]
```
The content has to be expanded with data type and the data match with the type.
For example, to send an image, the content may look like
```
messages = [
    {
        "role": "user",
        "content": [
            {"type": "text", "text": "What is shown in the image?"},
            {"type": "image_url", "image_url": {"url": "https://..."}}
        ]
    }
]
```
Instead of sending a URL in the content, a base64-encoded can also be sent to
models, such as 
```python
import base64
with open("image.jpg", "rb") as image_file:
    data = base64.b64encode(image_file.read())

messages = [
    {
        "role": "user",
        "content": [
            {"type": "text", "text": "What is shown in the image?"},
            {"type": "image_url", "image_url": {"url": "data"}}
        ]
    }
]
```

A complete example:

```bash
#!/bin/bash
#SBATCH --gpus-per-node=A100:4
#SBATCH --time=2:00:00

VLLM_PORT=$(find_ports) # get a random port
NGPUS=${SLURM_GPUS_ON_NODE:-1}

export APPTAINERENV_VLLM_DISABLE_COMPILE_CACHE=1

### Llama-3.2-11B-Vision-Instruct
# https://github.com/vllm-project/vllm/issues/27198
VLLM_SIF=/apps/containers/vLLM/vllm-0.9.1.sif
HF_MODEL=/mimer/NOBACKUP/Datasets/LLM/huggingface/hub/models--neuralmagic--Llama-3.2-11B-Vision-Instruct-quantized.w4a16/snapshots/7f66874ab1a17131069ffede32f5efaad2cb80b5/
MODEL_NAME=$(echo "$HF_MODEL" | sed -n 's#.*/models--\([^/]*\)--\([^/]*\)/.*#\1/\2#p')

vllm_opts="--tensor-parallel-size=$NGPUS"
vllm_opts+=" --max-model-len=10000"
vllm_opts+=" --no-use-tqdm-on-load"
vllm_opts+=" --enable-auto-tool-choice"
vllm_opts+=" --tool-call-parser llama3_json"
vllm_opts+=" --gpu-memory-utilization 0.5"
vllm_opts+=" --max-num-seqs=16"  # multimodal
vllm_opts+=" --enforce-eager"  # multimodal
vllm_opts+=" --limit-mm-per-prompt.image 2"  # multimodal
vllm_opts+=" --limit-mm-per-prompt.video 1"  # multimodal
vllm_opts+=" --allowed-local-media-path=${HOME}"  # multimodal

apptainer exec $VLLM_SIF \
    vllm serve ${HF_MODEL} \
        --served-model-name $MODEL_NAME \
        --port ${VLLM_PORT} \
        ${vllm_opts} \
        > vllm.out 2> vllm.err &
VLLM_PID=$!

if timeout 600 bash -c "tail -f vllm.err | grep -q 'Application startup complete'"; then
    echo "vLLM is running. Sending test request"
else
    echo "vLLM doesn't seem to start, aborting"
    echo "Terminating VLLM" && kill -15 ${VLLM_PID}
    exit
fi

curl http://localhost:$VLLM_PORT/v1/models | jq .

BASE64IMG=$(base64 M87BH.jpg)
cat > payload.json << EOF
{
    "model": "neuralmagic/Llama-3.2-11B-Vision-Instruct-quantized.w4a16",
    "messages": [
        {
            "role": "user",
            "content": [
                {"type": "text", "text": "What is shown in the image?"},
                {"type": "image_url", "image_url": {"url": "data:image/png;base64, $BASE64IMG"}}
            ]
        }
    ],
    "temperature": 0
}
EOF
curl http://localhost:$VLLM_PORT/v1/chat/completions \
    -H "Content-Type: application/json; charset=utf-8" \
    -d @payload.json | jq

IMGURL="https://upload.wikimedia.org/wikipedia/commons/4/4f/Black_hole_-_Messier_87_crop_max_res.jpg"
cat > payload.json << EOF
{
    "model": "neuralmagic/Llama-3.2-11B-Vision-Instruct-quantized.w4a16",
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
curl http://localhost:$VLLM_PORT/v1/chat/completions \
    -H "Content-Type: application/json; charset=utf-8" \
    -d @payload.json | jq
```

