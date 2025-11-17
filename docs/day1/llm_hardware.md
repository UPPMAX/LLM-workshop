---
title: LLM and hardware
icon: simple/nvidia
---

<aside class="notes" markdown="1">

This section is available as slides which is presented on the workshop. This
text version include some additional notes. You can also access the slide
version [here](./llm_hardware-slides).

</aside>

### Overview

<aside class="notes" markdown="1">

This section cover the following:

</aside>

- Computations in LLMs
- LLM on super-comupters

## Computations in LLMs

### Neural networks

![](figures/neural_network_training.png){ style="height:360px"}

- Learn patterns by adjusting parameters (weights);
- Training = prediction → differentiation → update;
- So far: mini-batch & optimizer & big → good.

<aside class="notes" markdown="1">

 Neural networks are building blocks of modern machine learning applications,
 the principle is simple, just like your regular gradient descent, you:

 - compute the output of your model;
 - compute the *loss function* according to reference output
 - compute the gradient of loss with respect to your parameters;
 - update you parameters slightly in the direction that reduces the loss the most;

 Neural networks are however:

 - **easy to differentiate:** thanks to automatic differentiation;
 - **easy to parallelize:** matrix multiplications can be done in parallel;
 - **easy to scale:** training is done on small subsets of data per step.

 which makes it extermely easy to scale up, and show great performance when
 scaled up. [^1]

 Note that during training, we need to store multiple copies of all model
 parameters (for gradients, optimizer states, etc.), which multiplies memory
 needs.
 
 PS: If you are suprised that large models work better, you are not alone; see
 [double descent](https://en.wikipedia.org/wiki/Double_descent)
 
</aside>


### Transformer

![](figures/transformer_vs_rnn.png){ style="height:360px" }

- Transformer computes *relationships* between tokens (attention);
- tokens can be processed in parallel

<aside class="notes" markdown="1">

 Transformers is an innovation that makes a training a large language model
 practical.  Unlike RNNs or LSTMs, they do not rely on a hidden state that is
 carried sequentially.

 Instead, the transformer computes *relationships* between all tokens in a
 sequence using the self-attention mechanism.  This means that during training,
 all tokens can be processed in parallel.

 (Caching of) The relations between tokens will be crucial to inference
 performance, but for now, we can see transformer as just a composition of
 neural network blocks that predicts the next token with a sequence of previous
 ones.

</aside>


### Training of LLMs

![](./figures/neural_network_training.png){ style="height:350px;" }

- Just neural networkes that can be parallelized more efficiently;

<aside class="notes">

 Training of LLMs are not very different from what we talked about. But now we
 can have a rough view of the big picture, you have your data, you feed it to
 some memory, you let some processor work on it, get the gradient, the updated
 gradient, you put in another data, you continue.

</aside>

### Fine-tuninig of LLMs

![](./figures/fine_tuning.png){ style="height:360px" }

- With specialized data (instruct, chat, etc);
- Less memory usage by "freezing parameters"

<aside class="notes" markdown="1">

Once a base model is trained, we usually fine-tune it on specific data
(instruct, chat, etc.).

From a computation point of view, fine-tuning is really the same task as
training, but you we can use some tricks to reduce the resource we need.

Above is a diagram of the LoRA (Low-Rank Adaptation) algorithm. Instead of
updating a full weight matrix, we consider updating it by a matrix product of
two small ones, this way we still need to do one copy of the big matrix, but the
backward path we just have the two low-rank matrices.

</aside>

### Inference of LLMs

![](figures/prefill_vs_decode.png){ style="height:360px" }

- GPT-style inference: *pre-filling* and *decoding*;
- Pre-filling: process the input prompt in parallel;
- Decoding: generate new tokens one-by-one, using cached results.

<aside class="notes" markdown="1">

Inference will need much less memory than training as we only need the forward
pass. But this is actually an interesting aspect of LLMs as compared to other
common machine learning tasks.

When inferencing with LLM, we are essentially two things:

- *Pre-filling* — we process the entire prompt, this can be done in parallel
   efficiently;
- *decoding*: we generate one token at a time, but the intermediate results from
   previous can be cached as *key–value (KV) cache*, saving computation at the
   expense of memory.

Think about what your task in mind, will it be more heavy in pre-filling or
decoding?

</aside>

### Optimize caches for inference

![](./figures/paged_attention.gif){ style="height:360px" }

- KV cache:
  + paged attention: indexed blockes of caches;
  + flash attention: fuse operations to reduce caches;

more in-depth discussion of the technique where that visualization is from:
[paged attention from first principles].


[paged attention from first principles]: https://hamzaelshafie.bearblog.dev/paged-attention-from-first-principles-a-view-inside-vllm/

<aside class="notes" markdown="1">

For this reason many effort in improving inference of LLMs has been put on
improving efficiency of memory accessing patterns and reducing the memory
needed. As an example, the paged attention mechanism groups adjacent tokens into
virtual memory "pages" like has been done in operating system kernels.

This allows us to efficiently use the fast memory on the GPUs. You can find more
examples and techniques in the blog linked.

</aside>

### Key takeaway

- LLMs/NNs benefit from massive parallelization;
- Need for different tasks:
  + training: memory + compute + data throughput;
  + fine-tuninig: similar to training, cheaper;
  + pre-filling: compute;
  + decoding: memory;

## LLM on HPC clusters

### LLM on general computers

- Mostly about inference;
- Quantization;
- CPU offloading;
- Memory-mapped file formats;

### HPC clusters

![](./figures/hpc_cluster.png){ style="height:360px" }


- Racked computer nodes;
- Parallel network storage;
- Infiniband/RoCE networking;

<aside class="notes" markdown="1">

HPC are designed for parallel computing; the hardware is
good at handing:

- fast communication between node;
- fast access to storage (local or shared);
- many CPUs/GPUs in one node

</aside>


### Alvis hardware - compute

| Data type | A100        | A40   | V100 | T4   |
|----------:|-------------|-------|------|------|
|      FP64 | 9.7 \| 19.5 | 0.58  | 7.8  | 0.25 |
|      FP32 | 19.5        | 37.4  | 15.7 | 8.1  |
|      TF32 | 156         | 74.8  | N/A  | N/A  |
|      FP16 | 312         | 149.7 | 125  | 65   |
|      BF16 | 312         | 149.7 | N/A  | N/A  |
|      Int8 | 624         | 299.3 | 64   | 130  |
|      Int4 | 1248        | 598.7 | N/A  | 260  |

<!-- - _\*Performance on -->
<!--   [Tensor Core](https://en.wikipedia.org/wiki/Deep_learning_super_sampling#Architecture)._ -->
<!-- - _\*\*Up to a factor of two faster with -->
<!--   [sparsity](https://developer.nvidia.com/blog/accelerating-inference-with-sparsity-using-ampere-and-tensorrt/)._ -->

<aside class="notes" markdown="1">

Alvis was build for AI research, so it's equipped with latest (at the time) GPU
acceleration cards. They are capable of doing fast floating point operations
in reduced precision (see next section).

</aside>

### Alvis hardware - network & storage

![](./figures/gpu_direct.png){ style="height:200px" }

- Fast storage: [WEKA file system];
- Infiniband: 100Gbit (A100 nodes);
- Ethernet: 25Gbit (most other nodes);

[WEKA file system]: https://docs.weka.io/weka-system-overview/about/weka-system-functionality-features

<aside class="notes" markdown="1">

Not only so, Alvis is also equipped with fast storage system backed by flash
storage; on the most powerful nodes (4xA100 GPUs) infiniband network that goes
directly to storage is available.

They were designed to facilitate fast loading of data, which is useful for any
training tasks. In the case of LLM, one should already benefit from that for
training.

It is worth noting that the while one typically do not need such fast storage
for inference, the LLM inference can actually take advantage of fast storage
backend, this is rather experimental, but take a look at the [LMcache] package
if you want to optimize you inference tasks for real.

[LMcache]: https://docs.lmcache.ai/kv_cache/storage_backends/infinistore.html

</aside>

### Running LLMs on supercomputers

- Most common bottleneck: **memory**
- Quantized models to fit larger models;
- Parallelize the model across GPUs or nodes;

<aside class="notes" markdown="1">

Supercomputers allow us to run larger LLMs because of not only the more powerful
nodes, but also the nodes are connected with fast internet connection. But we
still have the same issue as most high performance computing tasks, the compute
needs to access the memory and the data need to transferred.

Most commonly, when you try to run a large model (70B and 400B) parameters, you
need to split the models to many GPUs. You can choose to quantize the model, so
that the model use less memory, and you need less GPUs and less parallelization
issues. To this end, you will need to look up the compatibility between the
model, hardware and implementation.

You will also need to think about how do you parallelize the models, you have
the options:

- Tensor parallelism;
- Pipeline parallelism;
- Data parallelism

So next we will introduce the different formats in LLMs, to give you an idea of
what it means when you download a certain model, and tomorrow we will walk through
the

</aside>

### Tools to gain information

![](./figures/grafana.png){ style="height:360px" }


- grafana (network utilization, temp disk);
- nvtop, htop (CPU/GPU utilization, power draw);
- nvidia nsight (advanced debugging and tracing);

See details in C3SE documentation.


## Summary

### Take home messages

- LLMs/neural networks benefit from massive parallelization;
- Same issue of memeory vs. compute-bound;
- Some optimization strategies;
- Be aware of the troubleshooting tools!


### Useful links

- nanotron has some in-depth discussion about the efficiency of model training;
  ([The Ultra-Scale Playbook]), as well as a [prediction memory] estimation tool;
- Alvis [hardware specifications];
- Alvis [monitoring tools];

[The Ultra-Scale Playbook]: https://huggingface.co/spaces/nanotron/ultrascale-playbook
[prediction memory]: https://huggingface.co/spaces/nanotron/predict_memory
[hardware specifications]: https://www.c3se.chalmers.se/about/Alvis/#gpu-hardware-details
[monitoring tools]: https://www.c3se.chalmers.se/documentation/submitting_jobs/monitoring/

