---
title: Multi-Modal LLM / VLM Inference
tags:
  - multimodal
  - inference
icon: octicons/stack-24
---

## Introduction

- Multi-modal LLMs are LLMs capable of handling multiple types (modalities)
of data, e.g. text, image, audio, video.
- In this workshop, we focus on Vision Language Model (VLM), a subset of
multi-modal LLMs.

### VLM architectures

![](figures/vlm_arch.jpg)

Image source: [Sebastian Raschka](https://magazine.sebastianraschka.com/p/understanding-multimodal-llms)

## Inference in vLLM

- Support of 
[multiModal models](https://docs.vllm.ai/models/supported_models.html#list-of-multimodal-language-models)
- Same way to launch server for VLM:

```
$ vllm serve unsloth/Llama-3.2-11B-Vision-Instruct
```

- Some other useful arguments: 
    - `--limit-mm-per-prompt`
    - `--allowed-local-media-path`

### Messages to LLM

```python
messages = [
    {"role": "user", "content": "..."},
    ...
]
```

### Messages to multi-modal model

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

### Send image raw data

- Encode with `base64`

```bash
# bash
data=$(base64 image.jpg)
```

```python
# python
import base64
with open("image.jpg", "rb") as image_file:
    data = base64.b64encode(image_file.read()).decode("utf-8")
```

### Message with raw data

```
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

### OpenAI python SDK example

```python
import base64
from openai import OpenAI

client = OpenAI(base_url="http://localhost:8000/v1", api_key="")

with open("../image/eso2105a.jpg", "rb") as image_file:
    data = base64.b64encode(image_file.read()).decode("utf-8")

messages = [
    {
        "role": "user",
        "content": [
            {"type": "text", "text": "What is shown in the image?"},
            {"type": "image_url", "image_url": {"url": f"data:image/png;base64,{data}"}},
        ],
    },
]
response = client.chat.completions.create(model="...", messages=messages)
print(response)
```

## Offline inference in Transformers

- Use `AutoProcessor` instead of `AutoTokenizer`
- User `AutoModelForImageTextToText` instead of `AutoModelForCausalLM`

```python
import requests
from PIL import Image
from transformers import AutoProcessor, AutoModelForImageTextToText

model = AutoModelForImageTextToText.from_pretrained(
    model_name, torch_dtype="auto", device_map="auto",
)
processor = AutoProcessor.from_pretrained(model_name)

url = "https://cdn.eso.org/images/screen/eso2105a.jpg"
```

### Message to multimodal model

- Use `{"type": "image", "url": url}` instead of 
`{"type": "image_url", "image_url": {"url": url}}`
```python
messages = [
    {
        "role": "user",
        "content": [
            {"type": "image", "url": url},
            {"type": "text", "text": "What is shown in the image?"},
        ],
    },
]
```

### Raw data in message

```python
with open("../image/eso2105a.jpg", "rb") as image_file:
    data = base64.b64encode(image_file.read()).decode("utf-8")

messages = [
    {
        "role": "user",
        "content": [
            {"type": "text", "text": "What is shown in the image?"},
            {"type": "image", "url": f"data:image/png;base64,{data}"},
        ],
    },
]

processed_chat = processor.apply_chat_template(
    messages, add_generation_prompt=True, tokenize=True, return_dict=True, return_tensors="pt"
)
print(list(processed_chat.keys()))
```

### Attach image with processor

```python
image = Image.open(requests.get(url, stream=True).raw)

messages = [
    {
        "role": "user",
        "content": [
            {"type": "image"},
            {"type": "text", "text": "What is shown in the image"}
        ]
    }
]
input_text = processor.apply_chat_template(messages, add_generation_prompt=True)
inputs = processor(
    image, input_text, add_special_tokens=False, return_tensors="pt"
).to(model.device)

output = model.generate(**inputs, max_new_tokens=30)
print(processor.decode(output[0]))
```

<div markdown="1" class="no-mkdocs">

### Exercise

<div style="text-align: center; justify-content: center; align-items: center">

- Write a jobscript to launch a vLLM server serving one VLM
- Use your preferable way to send messages and images to the server,
you can do it in the same jobscript

</div>
</div>

## Reference

- https://huggingface.co/learn/computer-vision-course/unit4/multimodal-models/pre-intro
- https://magazine.sebastianraschka.com/p/understanding-multimodal-llms
- https://arxiv.org/abs/2405.17927

