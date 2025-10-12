---
title: LLM and hardware
icon: octicons/file-binary-24
---

### Overview

- Computations in LLMs
- LLM on general computers
- LLM on super-comupters


## Computations in LLMs

### Neural networks

![](neural_network_training.png)

- Learn patterns by adjusting parameters (weights);
- Training = prediction → differentiation → update;
- So far: mini-batch & optimizer & big → good.

<aside class="notes"> 

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
 needs.  </aside>
 
[^1]: If you are suprised that large models work better, you are not alone; see
    [double descent](https://en.wikipedia.org/wiki/Double_descent)


### Transformer

![](transformer_vs_rnn.png)[^1]

[^1]: doi:10.48550/arXiv.2307.15778

<aside class="notes">
 
 Transformers is an innovation that makes a training a large language model
 practical.  Unlike RNNs or LSTMs, they do **not rely on a hidden state that is
 carried sequentially**.
 
 Instead, the transformer computes *relationships* between all tokens in a
 sequence using the self-attention mechanism.  This means that during
 training, all tokens can be processed **in parallel**.
  
 The "relations" between tokens will be crucial to performance as we will cover
 later, but for now, we can see transformer as just a composition of neural
 network blocks that predicts the next token with a sequence of previous ones.
  
</aside>


### Training of LLMs


<aside class="notes"> 

 Training of LLMs are not very different from what we talked about. But now we
 can have a rough view of the big picture, you have your data, you feed it to 
 some memory, you let some processor work on it, get the gradient, the updated
 gradient, you put in another data, you continue.
 
</aside>

### Fine-tuninig of LLMs


<aside class="notes">

Once a base model is trained, we usually fine-tune it on specific data for
instruction following, domain adaptation, or alignment.  Fine-tuning is really
the same task as training, but you we can use some tricks to reduce the resource
we need, 

Above is a diagram of the LoRA algorithm, instead of updating our big matrix, we
say our big matrix is modified by a product of two small ones, this way we still
need to do one copy of the big matrix, but the backward path we just have the
two low-rank matrices.

</aside>

### Inference of LLMs

<aside class="notes"> 

As one know from the diagram, inference will need much
memory and 

</aside>

### Different steps in inference

<aside class="notes"> 

The inference of LLM is rather different from other ML tasks 
the decoding stage of LLM is heavily memory-bound rather than 
compute-bound; a lot of engineering techniques has been 
worked on for the inference.

</aside>

### Paged Attention

- paged attention (multi-head query attention kernel)
- flash attention

<aside class="notes"> 

This 

</aside>

### Key takeaway


- Massive parallization;
- Me
- It is *mostly* about memory



## LLM on general computers

### Simplified view of computer

<aside class="notes">

In general you have CPU and memory in a computer;

GPU has been developed as a graphics computing unit, it turned out to be useful
also for tasks where computing is a limit.

</aside>

### Running LLMs on consumer computers

<aside class="notes">

Commonly not possible to train useful model. 

</aside>


## LLM on HPC clusters

### HPC clusters

- Racked computer nodes;
- Parallel network storage;
- Infiniband/RoCE networking;

<aside class="notes"> 

HPC are designed for parallel computing; the hardware is
good at handing:

- fast communication between nodes ();
- fast access to storage (sometimes);
- many CPUs/GPUs in one node

</aside>

### Running LLMs on supercomputers

<aside class="notes"> 

HPC computing allows for 

</aside>

### Alvis hardware

<aside class="notes">

Alvis was build for 

</aside>


## Summrary

### To think about

<aside class="notes">



e       </aside>
