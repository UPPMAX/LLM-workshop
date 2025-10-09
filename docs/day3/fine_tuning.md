---
tags:
  - fine tuning
  - lora
  - qlora
icon: octicons/tools-16
---

# Post-training

https://arxiv.org/html/2408.13296v1#Ch5.S1

* Consists of Fine-tuning and/or RL.


Do you even need to post-train your model?
* When simple prompting and instruction following fails.
* Query KB using RAG if KB keeps changing.
* Domain knowelege is needed heavily and base model does not perform well? Continue your pre-training for inject more knowledge.
* BUT if you want model to follow almost all your instructions tightly and have improved targeted capabilities, reasoning, use fine-tuning/post-training.

## Fine-tuning

https://learn.deeplearning.ai/courses/post-training-of-llms/lesson/ynmgf/introduction-to-post-training
https://learn.deeplearning.ai/courses/post-training-of-llms/lesson/erg07/basics-of-sft

## RL

https://learn.deeplearning.ai/courses/post-training-of-llms/lesson/jeg0d/basics-of-online-rl