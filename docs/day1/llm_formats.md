---
title: LLM formats
icon: octicons/file-binary-24
---

## Overview

- Formats of LLM models
- Formats of numbers
- Quantization of LLM
- Quantization and performance

## Formats of LLM models

### So you want to use a LLM model

<img src="./figures/hf-search-models.png" alt="my caption" style="maxheight: 90%;"/>

<aside class="notes">

It is common for LLMs to be quantized after training. The quantization of
LLMs is relevant to the model's compatibility with different implementations, as
well its its performance, both in terms of accuracy and speed. This section will
focus on explaining details of different floating point number formats and
quantization methods.

</aside>

### What the name means

- `Llama-3.3`: model (architecture)
- `70B`: size / number of parameters
- `Instruct`: fine-tuning
- `AWQ-INT4`: quantization style
- `GGUF`: model format

<aside class="notes">

Models architecture and size are often the first consideration when working on
LLM.  But equally important are the format of models and the quantization
method. Modern acceleration devices cater for the lower precision need of
machine learning models, depending on the device you want to run on, quantized
models might give significant speed up.

</asisde>

### **file-formats** of LLMs

- pth/tf: "raw" ML library formats
- ggml: older format
- gguf: developed by llama cpp author
- safetensors: by huggingface
- llamafile: by mozilla, single-file format

<aside class="notes">

Models are published on different formats and they are optimized for different
usages, raw formats used by ML formats might need to be converted to the
inference engine. Newer formats that are memory-mapped, which are especially
useful for [disk offloading].

[disk offloading]: https://huggingface.co/docs/accelerate/package_reference/big_modeling#accelerate.disk_offload

</asisde>

### Things to think about:

- What models to use?
- Where do I train/run the model?
  + enough GPU?
  + 
  + GPU support my quantiztion?
- Efficiency of loading.

<aside class="notes">
Most people publish models on 

</asisde>

## Formats of numbers

### Why do we care?

- ML tolerates lower numerical precision;
- Number formats also determines "distributioin of information";

<aside class="notes">

ML applications tend to tolerate numerical precision, and might benefit from a difference
exponent/mantissa layout. So a number of different alternative formats have been developed for
them. 

</aside>

### Floating point formats


### Floating point formats (cont.)

|                 | hardware accel.    | note                                             |
|-----------------|--------------------|--------------------------------------------------|
| fp16/32/64      | most gpus          | Standard IEEE 754 floating point formats         |
| fp8 (E4M3/E5M2) | hardware dependent | Recent IEEE 754 format, different versions exist |
| bf16            | most gpus          | Google's floating point format                   |
| tf32            | nvidia-gpus        | Designed for use with tensorcores on Nvidia GPUs |
| nf4             |                    |                                                  |
| int4            |                    |                                                  |
| int8            |                    |                                                  |

[^3]: [Data types support][amd-fp-formats] by AMD RocM.
[amd-fp-formats]: https://rocm.docs.amd.com/en/latest/reference/precision-support.html

<aside class="notes">

Floating point number generally follows a IEEE standard format. However, details
like the representation of negative zeros (NZ) and infinite values might be
different.[^1]

[^1]: [Notes on on fp8 support][onnx-fp8] by ONNX.
[onnx-fp8]: https://onnx.ai/onnx/technical/float8.html

</aside>

### Rule of thumb

- ML tasks favor a larger proportion of exponents;
- [Google's bf16] (same range as fp32, less mantissa);
- training usually done in fp32/16;

[Google's bf16]: https://cloud.google.com/blog/products/ai-machine-learning/bfloat16-the-secret-to-high-performance-on-cloud-tpus

## Quantization methods

### Terminologies

- Techniques:
  + PTQ (Post-Training Quantization)
  + QAT (Quantization-Aware Training)
- Distribution
  + (A)symmetric quantization
  + (Non-)uniform quantization

[Visual guide to quantization][visual-guide] by Maarten Grootendorst.
[visual-guide]: https://newsletter.maartengrootendorst.com/p/a-visual-guide-to-quantization

### Post-training quantization methods

- SmoothQuant
- GPTQ
- AutoAWQ

For a comparison of number formats see [vLLM guide].

[vLLM guide]: https://github.com/vllm-project/llm-compressor/blob/main/docs/guides/compression_schemes.md

<aside class="notes">

The major differences between PTQ methods are the need for calibration dataset,
target number formats (which relates to GPU compatibility) and as a result the
loss of accuracy.

</aside>

### Quantization aware training


<aside class="notes">

Difference between QAT and PAT is that a full training (with back-propogation
at the training accuracy) is done ()

</aside>

### Quantization formats

- AWQ
- GPTQ
- Marlin (GPTQ/AWQ/FP8)
- INT8 (W8A8)
- FP8 (W8A8)
- BitBLAS
- ...

Quantization adds another dimension to the formats of LLM models;
be careful with both hardware and software compatibility.

### Sparsification

Models may also be diversified to (example with [llm-compressor]), 
some GPUs also support efficient evaluation of sparse ;

[llm-compressor]: https://github.com/vllm-project/llm-compressor/blob/main/examples/sparse_2of4_quantization_fp8/README.md

	
### Evaluation of quantization results


Useful benchmarks:

- [derek135/quantization-benchmarks](https://huggingface.co/datasets/derekl35/quantization-benchmarks)
- 


## Summary

### When choosing a model

+ Know the hardware/implementation compatibility;
+ Find the right model/format/qunatization;
+ Quantize if needed;
+ Look up/run benchmarks.
