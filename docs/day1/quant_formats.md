# Quantization and number formats

A common LLM model can be identified by the following sections of its name.

- Name-version: `Llama-3.3`
- Model size: `70B`
- Fine-tuning labels: `Instruct`, `Chat`
- Quantization: `w4a16`

It is common for LLMs to be quantized after training. The quantization of LLMs
is relevant to the model's compatibility with different implementations, as well
its its performance, both in terms of accuracy and speed. This section will
focus on explaining details of different floating point number formats and
quantization methods.

## Floating point (FP) numbers

Floating point number generally follows a IEEE standard format. However, details
like the representation of negative zeros (NZ) and infinite values might be
different.[^1]

[^1]: [Notes on on fp8 support][onnx-fp8] by ONNX.
[onnx-fp8]: https://onnx.ai/onnx/technical/float8.html

ML applications tend to tolerate numerical precision, and might benefit from a difference
exponent/mantissa layout. So a number of different alternative formats have been developed for
them. As a rule of thumb, ML tasks favor a larger proportion of exponents, the exponent also
determines the range of numbers that can be represented by the format, and thus influence the
quantization procedure.[^2]

[^2]: [Google's notes on bfloat16]
[google-bf16](https://cloud.google.com/blog/products/ai-machine-learning/bfloat16-the-secret-to-high-performance-on-cloud-tpus)

### Common FP formats

|                 | hardware accel.    | note                                             |
|-----------------|--------------------|--------------------------------------------------|
| fp16/32/64      | most gpus?         | Standard IEEE 754 floating point formats         |
| fp8 (E4M3/E5M2) | hardware dependent | Recent IEEE 754 format, different versions exist |
| bf16            | most gpus?         | Google's floating point format                   |
| tf32            | nvidia-gpus        | Designed for use with tensorcores on Nvidia GPUs |
| nf4             |                    |                                                  |

[^3]: [Data types support][amd-fp-formats] by AMD RocM.
[amd-fp-formats]: https://rocm.docs.amd.com/en/latest/reference/precision-support.html

## Integer numbers

### Common Integer formats

|                 | hardware accel.    | note                                             |
|-----------------|--------------------|--------------------------------------------------|
| fp16/32/64      | most gpus?         | Standard IEEE 754 floating point formats         |
| fp8 (E4M3/E5M2) | hardware dependent | Recent IEEE 754 format, different versions exist |
| bf16            | most gpus?         | Google's floating point format                   |
| tf32            | nvidia-gpus        | Designed for use with tensorcores on Nvidia GPUs |

## Quantization methods

- Symmetric quantization
- Range mapping & clipping

### Quantization methods


|               | Target Formats | implementations |
|---------------|----------------|-----------------|
| GPTQ          |                | vllm            |
| HQQ           |                |                 |
| Optium-quanto |                |                 |
| SmoothQuant   | W8A8(INT8)     | vllm            |
| AutoAWQ       | W4A16(INT4)    |                 |

https://github.com/vllm-project/llm-compressor

### Quantization formats

|      |
|------|
| GGUF |
| bnb  |


### Compatibility with inference

[hf-compat-table]: https://huggingface.co/docs/transformers/main/en/quantization/overview
[vllm-compat-table]: https://docs.vllm.ai/en/latest/features/quantization/supported_hardware.html

## Things not coverred here

Sparsification implementations: [llm-compressor]

[llm-compressor]: https://github.com/vllm-project/llm-compressor/blob/main/examples/sparse_2of4_quantization_fp8/README.md


## Take home messages

FP/INT formats:

- different standards exists;
- performance depends on hardware;

Quantization methods:

- can benefit from QAT;
- different formats exist;

Compatibility:

- depends on number format, quantization method, and implementation.

[Visual guide to quantization][visual-guide] by Maarten Grootendorst.
[visual-guide]: https://newsletter.maartengrootendorst.com/p/a-visual-guide-to-quantization
