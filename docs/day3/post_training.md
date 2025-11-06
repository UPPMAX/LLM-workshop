---
tags:
    - fine tuning
    - lora
    - RL
icon: octicons/tools-16
---

# Post-training

* This phase consists of fine-tuning and/or RL.


* Do you even need to post-train your model? 🤔

    * When simple prompting and instruction following fails.
    * Query KB using RAG if KB keeps changing.
    * Domain knowelege is needed heavily and base model does not perform well? Continue your pre-training for inject more knowledge.
    * BUT if you want model to follow almost all your instructions tightly and have improved targeted capabilities, reasoning, use fine-tuning/post-training.

## Supervised Fine-tuning (SFT) 📖


<div class="annotate" markdown>

* Imitation learning based on instruction prompts and responses
* Use cases: 
    * pre-trained to instruction following model
    * non-reasoning to reasoning model
    * non-tool usage to tool usage
    * Improve certain model capabilities from larger model to smaller model
* Data curation: 
    * Quality >> quantity. 1k high quality data > 1M mixed/low quality data. ⭐
    * Common methods:
        * Distillation: by generating responses from stronger/larger model
        * Best of K/ rejection sampling: by generating multiple responses from model and selecting best among them.
        * Filtering: by starting from a large-scale dataset and then filter as per the quality of responses and diversity of the prompts.
* Full-finetune or PEFT? ⚖️
    * Both can be used. FullFT takes lot of memory and is slower to perform. PEFT (LoRA) saves lot of memory, but learns less and forgets less[^1].(1)
     

</div>
1.  ![LoRA learning-forgetting tradeoff](./figures/learnless_forgetless.png) 

!!! info "Exercise"

    Recommeded [max_length calculator](https://huggingface.co/spaces/trl-lib/dataset-length-profiler).


https://learn.deeplearning.ai/courses/post-training-of-llms/lesson/ynmgf/introduction-to-post-training
https://learn.deeplearning.ai/courses/post-training-of-llms/lesson/erg07/basics-of-sft

## RL 🎮

https://learn.deeplearning.ai/courses/post-training-of-llms/lesson/jeg0d/basics-of-online-rl

???- info "Resources 📚"

    - Frameworks for post-training[^10]:

    | Framework | SFT | PO | RL | Multi-modal | FullFT | LoRA | Distributed |
    |-----------|-----|----|----|-------------|--------|------|-------------|
    | [TRL](https://github.com/huggingface/trl) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
    | [Axolotl](https://github.com/axolotl-ai-cloud/axolotl) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
    | [OpenInstruct](https://github.com/allenai/open-instruct) | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ |
    | [Unsloth](https://github.com/unslothai/unsloth) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
    | [vERL](https://github.com/volcengine/verl) | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ |
    | [Prime RL](https://github.com/PrimeIntellect-ai/prime-rl) | ✅ | ❌ | ✅ | ❌ | ✅ | ✅ | ✅ |
    | [PipelineRL](https://github.com/ServiceNow/PipelineRL) | ❌ | ❌ | ✅ | ❌ | ✅ | ✅ | ✅ |
    | [ART](https://github.com/OpenPipe/ART/tree/main) | ❌ | ❌ | ✅ | ❌ | ❌ | ✅ | ❌ |
    | [TorchForge](https://github.com/meta-pytorch/torchforge) | ✅ | ❌ | ✅ | ❌ | ✅ | ❌ | ✅ |
    | [NemoRL](https://github.com/NVIDIA-NeMo/RL) | ✅ | ✅ | ✅ | ❌ | ✅ | ❌ | ✅ |
    | [OpenRLHF](https://github.com/OpenRLHF/OpenRLHF) | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ |


[^1]: LoRA Learns Less and Forgets Less. [arXiv](https://arxiv.org/abs/2405.09673)
[^10]: The Smol Training Playbook:
The Secrets to Building World-Class LLMs. [Blog](https://huggingface.co/spaces/HuggingFaceTB/smol-training-playbook#tools-of-the-trade)
