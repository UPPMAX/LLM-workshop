---
title: "Introduction to Alvis"
author: "NAISS"
date: 2025-09-30
fontsize: 10pt
tags:
  - Introduction
---

## Introduction
TODO

### Overview of the landscape
- Start by talking about the current up-swing in interest
- Take a step back and give a bit of the history:
    - [Darthmout Summer Research Project](http://jmc.stanford.edu/articles/dartmouth/dartmouth.pdf)(can be skipped)
    - NLP and how do deal with text as inputs (mention bag-of-words, n-grams? as example of very simple models?)
    - Transformers (Attention Is All You Need)
    - GPT-3 (surprisingly much better than GPT-2)
    - ChatGPT (the public starts to notice, the current hype begins)
- What has changed?
    - [Performance against training compute](https://ourworldindata.org/grapher/ai-performance-knowledge-tests-vs-training-computation)
    - [Compute graph over time](https://ourworldindata.org/grapher/artificial-intelligence-training-computation?time=2015-03-17..latest&country=Pandemonium+%28morse%29~Predictive+Coding+NN~LSTM~Neural+LM~NPLM~Hierarchical+LM~KN-LM~SB-LM~RNN+LM~LSTM+LM~DistBelief+NNLM~RNN%2Bweight+noise%2Bdynamic+eval~RCTM~RNTN~Word2Vec+%28large%29~TransE~RNNsearch-50*~Large+regularized+LSTM~Seq2Seq+LSTM~SPN-4%2BKN5~SNM-skip~genCNN+%2B+dyn+eval~Search-Proven+Best+LSTM~LSTM-Char-Large~Variational+%28untied+weights%2C+MC%29+LSTM+%28Large%29~Named+Entity+Recognition+model~Part-of-sentence+tagging+model~VD-RHN~GNMT~Pointer+Sentinel-LSTM+%28medium%29~Zoneout+%2B+Variational+LSTM+%28WT2%29~VD-LSTM%2BREAL+Large~BIDAF~NAS+with+base+8+and+shared+embeddings~MoE-Multi~Transformer+%282017%29~ConvS2S+%28ensemble+of+8+models%29~AWD-LSTM+-+3-layer+LSTM+%28tied%29+%2B+continuous+cache+pointer+%28WT2%29~EI-REHN-1000D~GL-LWGC-AWD-MoS-LSTM+%2B+dynamic+evaluation+%28WT2%29~ISS~AWD-LSTM%2BWT%2BCache%2BIOG+%28WT2%29~Fraternal+dropout+%2B+AWD-LSTM+3-layer+%28WT2%29~AWD-LSTM-MoS+%2B+dynamic+evaluation+%28WT2%2C+2017%29~2-layer-LSTM%2BDeep-Gradient-Compression~ULM-FiT~QRNN~ENAS~4+layer+QRNN+%28h%3D2500%29~LSTM+%28Hebbian%2C+Cache%2C+MbPA%29~Dropout-LSTM%2BNoise%28Bernoulli%29+%28WT2%29~aLSTM%28depth-2%29%2BRecurrentPolicy+%28WT2%29~DARTS~Big+Transformer+for+Back-Translation~%28ensemble%29%3A+AWD-LSTM-DOC+%28fin%29+%C3%97+5+%28WT2%29~Transformer+%2B+Simple+Recurrent+Unit~LSTM%2BNeuralCache~Transformer+%28Adaptive+Input+Embeddings%29+WT103~BERT-Large~TrellisNet~Mesh-TensorFlow+Transformer+2.9B+%28translation%29~Mesh-TensorFlow+Transformer+4.9B+%28language%29~Fine-tuned-AWD-LSTM-DOC+%28fin%29~Multi-cell+LSTM~Transformer-XL+%28257M%29~GPT-2+%281.5B%29~SciBERT~FAIRSEQ+Adaptive+Inputs~Cross-lingual+alignment~WeNet+%28Penn+Treebank%29~BERT-Large-CAS+%28PTB%2BWT2%2BWT103%29~AWD-LSTM-DRILL+%2B+dynamic+evaluation%E2%80%A0+%28WT2%29~XLNet~Transformer-XL+Large+%2B+Phrase+Induction~AWD-LSTM+%2B+MoS+%2B+Partial+Shuffled~Tensorized+Transformer+%28257M%29~RoBERTa+Large~Megatron-BERT~Megatron-LM+%288.3B%29~DistilBERT~T5-11B~T5-3B~Base+LM+%2B+kNN+LM+%2B+Continuous+Cache~XLM-RoBERTa~CamemBERT~Sandwich+Transformer~Transformer-XL+DeFINE+%28141M%29~MMLSTM~Meena~TaLK+Convolution~ALBERT-xxlarge~Turing-NLG~Feedback+Transformer~TransformerXL+%2B+spectrum+control~Tensor-Transformer%281core%29%2BPN+%28WT103%29~ELECTRA~ATLAS~UnifiedQA~NAS%2BESS+%28156M%29~GPT-3+175B+%28davinci%29~GShard+%28dense%29~DeLighT~ERNIE-GEN+%28large%29~LUKE~mT5-XXL~GBERT-Large~German+ELECTRA+Large~KEPLER~CPM-Large~DensePhrases~CT-MoS+%28WT2%29~ERNIE-Doc+%28247M%29~Switch~SRU%2B%2B+Large~Generative+BST~PLUG~ByT5-XXL~EMDR~DeBERTa~Adaptive+Input+Transformer+%2B+RD~ERNIE+3.0~Codex~Jurassic-1-Jumbo~XLMR-XXL~FLAN+137B~PermuteFormer~PLATO-XL~Megatron-Turing+NLG+530B~Yuan+1.0~T0-XXL~base+LM%2BGNN%2BkNN~S4~CodeT5-base~Gopher+%28280B%29~GLaM~Contriever~XGLM-7.5B~ERNIE+3.0+Titan~InstructGPT+175B~AlphaCode~RETRO-7B~GPT-NeoX-20B~LaMDA~ST-MoE~PolyCoder~Segatron-XL+large%2C+M%3D384+%2B+HCP~Chinchilla~PaLM+%28540B%29~Sparse+all-MLP~OPT-175B~UL2~DITTO~Minerva+%28540B%29~CodeT5-large~NLLB~BLOOM-176B~AlexaTM+20B~GLM-130B~BlenderBot+3~Flan-PaLM+540B~Flan-T5+11B~U-PaLM+%28540B%29~Mogrifier+RLSTM+%28WT2%29~Fusion+in+Encoder~GPT-3.5~Hybrid+H3-2.7B~LLaMA-65B~Falcon-40B~PanGu-%CE%A3~BloombergGPT~Incoder-6.7B~StarCoder~PaLM+2~InternLM~Claude+2~Llama+2-70B~Llama+2-7B~Jais~Falcon-180B~FinGPT-13B~CODEFUSION+%28Python%29~Skywork-13B~Yi-34B~Grok-1~Nemotron-3-8B~Inflection-2~Qwen-72B~Llama+Guard~Qwen1.5-72B~MegaScale+%28Production%29~Mistral+Large~Aramco+Metabrain+AI~Inflection-2.5~DBRX~Llama+3-70B~Qwen2-72B~Nemotron-4+340B~DeepSeek-Coder-V2+236B~Llama+3.1-405B~Mistral+Large+2~AFM-on-device~AFM-server~Qwen2.5-72B~Doubao-pro~Hunyuan-Large~Llama+3.3~EXAONE+3.5+32B~DeepSeek-V3~DeepSeek-R1~QwQ-32B~GPT-1~QT-Opt~iGPT-L~iGPT-XL~CLIP+%28ViT+L%2F14%40336px%29~M6-T~ALIGN~Zidong+Taichu~Swin+Transformer+V2+%28SwinV2-G%29~N%C3%9CWA~Flamingo~Gato~BEIT-3~PaLI~Galactica~VALL-E~BLIP-2+%28Q-Former%29~GPT-4~LLaVA~InstructBLIP~ONE-PEACE~Amazon+Titan~ChatGLM3-6B~LLaVA+1.5~CogVLM-17B~GPT-4+Turbo~MultiBand+Diffusion~SPHINX+%28Llama+2+13B%29~Volcano+13B~Gemini+1.0+Pro~Gemini+1.0+Ultra~CogAgent~FunSearch~Gemini+1.5+Pro~Claude+3+Opus~MM1-30B~Reka+Core~GPT-4o~OpenVLA~Claude+3.5+Sonnet~GPT-4o+mini~Grok-2~NVLM-D+72B~NVLM-H+72B~NVLM-X+72B~Amazon+Nova+Pro~Grok-3~Claude+3.7+Sonnet)
    - (Something about Instruct tuning, RLHF? To explain why current hype started?)
    - (Something about scaling test time compute?)
- Brief intro to hardware (might fit better later)?
    - Alvis
    - GPUs slow but parallel
    - Multi-GPU
    - Batch queue system
- Conclusion of introduction
    - Briefly sketch what runs in background of chatbots on websites (or if using APIs) (bakom kulisserna)
    - "This part is what we'll be learning today"
