---
title: LLM formats
icon: octicons/file-binary-24
---

<section data-visibility="hidden" markdown=1>

This section is available as slides which is presented on the workshop. This
text version include some additional notes. You can also access the slide
version [here](../llm_formats-slides).

</section>

## Overview

<aside class="notes" markdown="1">

This section cover the following:

</aside>

- Formats of LLM models
- Formats of numbers
- Quantization of LLM
- Quantization and performance

## Formats of LLM models

### So you want to use a LLM model

<aside class="notes" markdown="1">

Today most LLMs are published on HugginFace. Searching for a base model, you
will find variants with all kinds of labels. These labels tells a lot about how
the models are prepared and how efficient will they run on the target
hardware. This session will cover the most of the jargons in those names.

</aside>

![](figures/hf-search-models.png){ style="height=360px" }


### What the name means

- `Llama-3.3`: model (architecture)
- `70B`: size / number of parameters
- `Instruct`: fine-tuning
- `AWQ-INT4`: quantization
- `GGUF`: model format

<aside class="notes" markdown="1">

Models architecture and size are often the first consideration when working on
LLM.  But equally important are the format of models and the quantization
method. Modern acceleration devices cater for the lower precision need of
machine learning models, depending on the device you want to run on, quantized
models might give significant speed up. We will first go through the **file
formats**, then detail the quantization methods and **number formats**.

</aside>

### File-formats of LLMs

<aside class="notes" markdown="1">

LLM models commonly consists of metadata such as the metadata, quantization
methods, and the tensor themselves. The following shows the layout of the gguf
file format.

</asisde>

![](figures/gguf.png){ style="max-height:360px" }  
Image from [huggingface](https://huggingface.co/docs/hub/gguf).


### Common formats of LLMs

- bin/pth/tf: "raw" ML library formats;
- safetensors: used by huggingface;
- ggml/gguf: developed by [llama.cpp](https://github.com/ggml-org/llama.cpp)
  (supports many qunatization formats);
- [llamafile](https://mozilla-ai.github.io/llamafile): by mozilla, single-file
  format, executable.

In the repo you can find detailed model information for some model formats,
[example](https://huggingface.co/QuantStack/Qwen-Image-Edit-2509-GGUF?show_file_info=Qwen-Image-Edit-2509-Q2_K.gguf).

<aside class="notes" markdown="1">

Models published on different formats are optimized for different usages. They
can be converted to one another (which is typically implemented as model loaders
by inference engines,
[example](https://docs.vllm.ai/en/stable/api/vllm/model_executor/model_loader/gguf_loader.html)).

raw formats used by ML formats might be handy for re-training. Some of them
contain pickled data so might execute arbitrary code (in contrary to "safe"
formats).

Newer formats like GGUF/safetensors are suitable for common model architectures
(different engines will support them if the architecture is known). They are
memory-mapped, which are especially useful for [disk offloading].

[disk offloading]: https://huggingface.co/docs/accelerate/package_reference/big_modeling#accelerate.disk_offload

</aside>

### Picking a model

<aside class="notes" markdown="1">

While not strictly a requirement, it is usually less trouble to get a model in
your desired format. The other part of the model name is usually tell you the 
quantization method and the number formats in the model.

In the following, we will introduce the quantization procedure and how that
impacts the performance (both in terms of speed and accuracy) and hardware
compatibility.

</aside>


<div markdown="1" class="no-mkdocs">

- Quantization method;
- Number format;
- Hardware compatibility.

</div>


## Formats of numbers

### Why do we care?

- ML tolerates lower numerical precision;
- Quantization allow you to run larger models;
- To eliminate expensive communication;

### Number formats - floating point

<aside class="notes" markdown="1">

Floating point number is the most common way one represents a real number in a
computer. A floating point number uses a fixed number of bits and represents a
number in terms of an exponent and mantissa (significand).

</aside>

![](figures/float16.png){ style="height:360px" }  
Image source: [Maarten Grootendorst](https://newsletter.maartengrootendorst.com/p/a-visual-guide-to-quantization)


### Floating point formats - cont. 1

<aside class="notes" markdown="1">

The mantissa determines the significant digits of a FP number, and the exponent
determines the range. Standard FP numbers typically aim to strike a balance
between accuracy and range. 

</aside>

![](figures/number-format.svg){ style="height:360px" }  
Image source: [Hamzael Shafie](https://hamzaelshafie.bearblog.dev/paged-attention-from-first-principles-a-view-inside-vllm)

<aside class="notes" markdown="1">

For ML application, it is beneficial to use a reduced precision format with the
same number of exponents, as that simplifies the quantization procedure, and it
has been
[claimed](https://cloud.google.com/blog/products/ai-machine-learning/bfloat16-the-secret-to-high-performance-on-cloud-tpus)
that "neural networks are far more sensitive to the size of the exponent than
that of the mantissa".

</aside>


### Floating point formats - cont. 2

<aside class="notes" markdown="1">


As an example, converting from FP32 to BF16 will be trivial as the dynamic range
is the same. One would only need to discard mantissa from FP32. In contrary,
conversion from FP32 to FP16 will require scaling or clipping the number. With
implication to be decided.

While not detailed here, integers are also used as quantization targets. Besides
the dynamic range, note that integers numbers will also have different scales as
compared to FP numbers.

</aside>

![](figures/number-ranges.png){ style="height:360px" }  
Image source: [Maarten Grootendorst](https://newsletter.maartengrootendorst.com/p/a-visual-guide-to-quantization)

### Hardware Compatibility

<aside class="notes" markdown="1"> 

Acceleration of floating point operations requires also support from hardware
vendor or custom implementations of numeric kernels. Newer number formats are
not necessarily accelerated by the GPU and might get converted back depending on
implementation.

Below lists some commonly used FP formats and their hardware support status:

</aside>

|                             | hardware accel. | note        |
|-----------------------------|-----------------|-------------|
| fp16/32/64                  | most gpus       | IEEE 754    |
| fp8 [(E4M3/E5M2)][onnx-fp8] | hooper          | Recent IEEE |
| bf16                        | most gpus       | Google's    |
| tf32                        | nvidia-gpus     | Nvidia      |
| int4/8                      | most GPUs       |             |

[onnx-fp8]: https://onnx.ai/onnx/technical/float8.html

See also [Data types support][amd-fp-formats] by AMD RocM.

[amd-fp-formats]: https://rocm.docs.amd.com/en/latest/reference/precision-support.html

### Rule of thumb

- [Google's bf16] if unsure  
  (same range as fp32, less mantissa, good compatibility);
- training usually done in fp32/bf16;
- int4/8 is good for inference (on older GPUs).

[Google's bf16]: https://cloud.google.com/blog/products/ai-machine-learning/bfloat16-the-secret-to-high-performance-on-cloud-tpus

## Quantization methods

### Quantization target

![](figures/mixed_precision_hopper.jpg)

- Weight/activation/mixed percision (w8a16);
- KV-cache;
- Non-uniform;

<aside class="notes" markdown="1">

weights is usually the first thing to quantize, it is also the most supported
way of quantizing the model. Depending on the hardware, it might or might not
support converting the tensors between precision or doing tensor operations
natively.

For instance, FP8 is not officially support on Ampere GPUs (A40 and A100). While
there exist implementations that makes [w8a16][vllm-fp8] operations available,
quantizating KV cache to FP8 currently [need hardware
support](https://discuss.vllm.ai/t/kv-cache-quantizing/749).

[vllm-fp8]: https://docs.vllm.ai/en/v0.5.2/quantization/fp8.html

Models can also been quantized
[non-uniformly](https://docs.vllm.ai/projects/llm-compressor/en/latest/examples/quantization_non_uniform/)

</aside>

### (A)symmetric qunatization

![](figures/quantization_symmetry.webp)

- linear transformation;
- depend on original range;
- position of zero.

<aside class="notes" markdown="1">

One important aspect when quantizing the models is the distribution of the
model, the easiest way is to simply scale the parameters by a factor.

To minimize loss of precision, we could map the parameters according to the
max/min values of the parameter, rather than the number-format range. There, we
need to choose whether we shift the zero point in the transform (but introduces
complexity in computation).

</aside>


### Clipping

![](figures/clipping.webp)

<aside class="notes" markdown="1">

we can also choose to clip out the outlier to same more precision.

</aside>


### Calibration for weight quantization

<aside class="notes" markdown="1">

For parameters of the model We can simply quantize them, since we know their
distribution. But given some small dataset but we can also improved the accuracy
but estimating how important each parameter it. A popular way to do that is the
GPTQ method.

</aside>

![](figures/gptq.webp)

Illustration of GPTQ method, where quantization are done to minimize the error,
weighed by according to the inverse Hessian (sensitivity).


### Calibration for activation qunatization

![](figures/dynamic_calibration.webp)

Can be dynamic or static.

<aside class="notes" markdown="1">

To also quantize the activation function, we need to estimate the range of
activation, that has to be done by passing data to the model and collect
minima/maximi. We can do that either dynamically (during inference) or
statically (with a calibration set).

</aside>

### Post-training quantization methods (PTQ)

- Weights and/or activation;
- Calibration/accuracy trade off;
- Not detailed here: sparsification.

![](figures/sparse-matrix.png)


<aside class="notes" markdown="1">

Models may also be sparsified to reduce the required computation, this is
commonly known as weight pruning. But some GPUs also support efficient
evaluation of sparse matrices if the sparsity follow certain pattern (example
with [llm-compressor]);

[llm-compressor]: https://github.com/vllm-project/llm-compressor/blob/main/examples/sparse_2of4_quantization_fp8/README.md

So far we covered mostly the so-called PTQ method when we do/can not run the
training (for a complete list with compatibility see [vLLM guide]).

[vLLM guide]: https://github.com/vllm-project/llm-compressor/blob/main/docs/guides/compression_schemes.md

</aside>

### Quantization aware training (QAT)

QAT introduce quantization error during training;

![](figures/qat.webp){ style="max-height:100px;" }
![](figures/qat_back.webp){ style="max-height:300px;" }

<aside class="notes" markdown="1">

But we can also get higher accuracy by using the Quantization aware training
(QAT) method. There we do the training and perform the
quantization/dequantization; which this the first thing we gain is that we can
actually optimize the quantization parameters as part of the training process.

</aside>

### Quantization aware training (QAT) - cont.

![](figures/qat_theory.webp)

<aside class="notes" markdown="1">

The reason why it might work better, is that by introducing the quantization
error in the training process, we force the model to land in a local minima
where it is less sensitive to model parameters. So even the original model
performs worth, the quantized model works better

</aside>


## Summary

### When choosing a model

+ Know the hardware/implementation compatibility;
+ Find the right model/format/qunatization;
+ Quantize if needed;
+ Look up/run benchmarks.

### Other useful links

Benchmarks:

- [derek135/quantization-benchmarks](https://huggingface.co/datasets/derekl35/quantization-benchmarks)
