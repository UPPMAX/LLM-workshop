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

!!! example "Exercise"

    - Run a jupyter notebook using `post_training_env` environment.
    - Run `sft.ipynb`

    - Recommeded [max_length calculator](https://huggingface.co/spaces/trl-lib/dataset-length-profiler).
    Deepspeed [memory calculator](https://deepspeed.readthedocs.io/en/latest/memory.html) API.

    DIY: [Gpt-oss PEFT](https://cookbook.openai.com/articles/gpt-oss/fine-tune-transfomers)


## Preference Optimization 

* Contrastive learning based on positive and negative responses.
* With SFT, LLM only reproduce patterns it learnt from the data it was trained on.
* LLM has more potential to learn if it is shown good and bad examples of responses.
* This encourages model to produce more "preferred" responses and dicourages it to produce less of the other kind.
* Uses cases:
    * Give persona/identity.
    * Give safer responses.
    * Improve multilingual responses.
    * Improve instruction following. 
* Data curation:
    * We need even less data than SFT as the model is already following our instructions nicely and alternatively gained domain knowledge.
    * We can already leverage LLMs now to generate strong and weak pair of responses. Use a better model -> strong responses, weaker/baseline model -> weak responses.
    * Alternatively, run ony one LLM on the same prompt to produce strong/weak response pairs and another "grader" LLM that gives scores to these outputs.
<!-- 
https://learn.deeplearning.ai/courses/post-training-of-llms/lesson/ynmgf/introduction-to-post-training
https://learn.deeplearning.ai/courses/post-training-of-llms/lesson/erg07/basics-of-sft -->

!!! example "Exercise"

    - Run a jupyter notebook using `post_training_env` environment.
    - Run `dpo.ipynb`

## Reinforcement Learning (RL) 🎮

* "A is better than B" is not always what we are looking for. We would like to have in-between steps to be correct too for problems that requires thinking longer.
* LLM can be given an environment that could include code unit tests, math verfiers, humans as judges or code executors in real-time as LLM is thinking.
* Reward signals can help guide LLMs to generate better code, solve math problems or plan in multiple steps. Caveat being reward models are difficult create and LLMs are harder to stabilise and costly to train. Reward hacking is a challenging to overcome. 
* Use cases:
    * When we can create verifiable reward signals
    * When tasks are multi-steps

!!! example "Exercise"

    - Run a jupyter notebook using `post_training_env` environment.
    - Run `rl.ipynb`

???- note "Note on On-policy distillation"

    Methods like this lie in-between preference optimization and RL by taking advantage of reward signal coming from a Teacher model. The student model can continously absorb samples from Teacher model and without needing explicit preference labels, can start to show capabilities of the Teacher model. This method is often simpler to implement than RL way cheaper in compute too. Although its success is only shown in smaller to mid-sized (<30B) models. Whereas RL works better in larger models (20B+) only. 


<!-- https://learn.deeplearning.ai/courses/post-training-of-llms/lesson/jeg0d/basics-of-online-rl -->

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
