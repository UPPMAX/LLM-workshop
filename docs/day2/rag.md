---
tags:
  - rag
  - retrieval augmented generation
icon: material/database-search
---

# Retrieval Augmented Generation (RAG)

???- info "Learning outcomes"

    - Understand the key components of RAG applications by looking at what popular open-source RAG libraries provide
    - Perform a simple RAG task 

![RAG meme](./figures/rag_is_dead.jpg){ align=right width=300 }

* LLMs are not trained on your personal data or fairly recent data.

* RAG can help provide richer and accurate responses based on external knowledge.

* It incurs significantly lower computation cost compared to long-context LLMs.

* We will learn RAG through the lens of popular open-source RAG libraries, viz. [LangChain](https://www.langchain.com/langchain) and [LlamaIndex](https://www.llamaindex.ai/llamaindex). 

## Basics

???- info "RAG figures"
    
    ???- info "Naive RAG"
        
        ![Naive RAG](./figures/naive_rag.png)

    ???- info "Naive Retrieval System"
        ![Naive Retrieval](./figures/naive_retrieval.png)


## Stages in RAG 🔄

<div class="annotate" markdown>

!!!- note inline end "Atomic unit"

    - LangChain's atomic unit is a Document.
    - LlamaIndex's atomic unit is a Node. A collection of Nodes consitutes a Document.

### Loading 📥

Loading/Parsing data from source and creating well-formatted _Documents_ with metadata. (1)  
This step includes splitting texts such that it can be embedded into lower dimensions.
```mermaid
flowchart LR
  A[Text/image + metadata] --> B[Chunking/Splitting] --> C[Document]
```
<br> 

!!!- note inline end "Document parsing sequence"

    - LangChain creates Documents first and then performs chunking.
    - LlamaIndex performs chunking first, that becomes a Node and then creates Documents of multiple Nodes.

### Indexing 📊

Creating data structure and/or reducing dimensions of the data for easy querying of data.(2)

```mermaid
flowchart LR
  A[Document] --> B[Embeddings]
```

### Storing 💾

 Storing _Documents_, metadata and embeddings in a persistant manner (Ex. Vector Stores). (3)

```mermaid
flowchart LR
  A[Document] --> C[Vector Store/Storage Context]
  B[Embeddings] --> C
```

### Querying ❓

Retrieving relavent _Documents_ for a user _Query_ and feeding it to LLM for added context. (4)

```mermaid
flowchart LR
  A[Vector Store/Storage Context] --> D[LLM + tools]
  B[Query] --> D
  C[Prompt] --> D
  D --> E[Response]
```

### Evaluation 📈

Trace inspection, meterics, comparisons to test if full pipeline gives desired results. (5)

</div>

1. LlamaIndex ex.: [SimpleDirectoryReader class](https://developers.llamaindex.ai/python/framework/module_guides/loading/simpledirectoryreader)  
LangChain ex.: [document_loaders module](https://docs.langchain.com/oss/python/integrations/document_loaders), [langchain_text_splitters module](https://docs.langchain.com/oss/python/integrations/splitters)

2. LlamaIndex ex.: [VectorStoreIndex class](https://developers.llamaindex.ai/python/framework/module_guides/indexing/vector_store_index)  
LangChain ex.: [Embeddings class](https://reference.langchain.com/python/langchain_core/embeddings/?_gl=1*vnaur7*_gcl_au*NDUyNDc5MjE5LjE3NjE1Nzk0NTI.*_ga*NjQzNjgwODkuMTc2MTgzNDY5NA..*_ga_47WX3HKKY2*czE3NjE4MzQ2OTQkbzEkZzEkdDE3NjE4MzYzODIkajEzJGwwJGgw)

3. LlamaIndex ex.: StorageContext  
LangChain ex.: VectorStore

4. LlamaIndex ex.: RetrieverQueryEngine class  
LangChain ex.: Retriever class  

5. LlamaIndex ex.: LLM-Evaluator  
LangChain ex.: LangSmith, QAEvalChain

* Retrieval techniques
* QA/chat
* Misc: Reranker model, GraphRAG, RAPTOR, EraRAG, multimodal

https://learn.deeplearning.ai/courses/langchain-chat-with-your-data/lesson/snupv/introduction


???- info "Resources 📚"

    - Recommended papers on RAG:

        - [Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks](https://arxiv.org/abs/2005.11401)
        - [REALM: Retrieval-Augmented Language Model Pre-Training](https://arxiv.org/pdf/2002.08909)
        - [Dense Passage Retrieval for Open-Domain Question Answering](https://aclanthology.org/2020.emnlp-main.550)
        - [Improving language models by retrieving from trillions of tokens](https://arxiv.org/abs/2112.04426)

    - Popular libraries and software suite:
        - [llama_index](https://github.com/run-llama/llama_index)
        - [LangChain](https://github.com/langchain-ai/langchain)
        - [RAGFlow](https://github.com/infiniflow/ragflow)

!!!- info "When and when not to use RAG ⚖️"

    <div class="annotate" markdown>

    * It was found[^1] that RAG lags behing Long-Context LLMs in the following scenarios: (1)
        * Query requiring multi-step reasoning.
        * General queries to which embeddings model does not perform well.
        * Long and complex queries.
        * Implicit queries requiring the reader to connect the dots.

    * Way easier than just fine-tuning on personal data.
    * Allows smaller models with shorter context memory to be on par with larger models. Therefore, saving compute and memory cost on GPUs.

    </div>  
    
    1. ![RAG failure reasons](./figures/rag_failures.png)  

## Agentic RAG 🤖

* An LLM-powered agent **decides** when and how to retrieve during reasoning. This gives more flexibility in the decision making process by the system but low control over it by the engineer.
* Router
* Tool calling
* Multistep reasoning with tools

(More about Agents will be covered in Day 3.)


https://learn.deeplearning.ai/courses/building-agentic-rag-with-llamaindex/lesson/yd6nd/introduction

!!!- info "Some more useful techniques in retrieval pipelines 🛠️"

    - Rerankers
        - [article](https://www.answer.ai/posts/2024-09-16-rerankers.html) on rerankers
    - GraphRAG (Knowledge graphs?)
    - RAPTOR
    - EraRAG


[^1]: Retrieval Augmented Generation or Long-Context LLMs? A Comprehensive Study and Hybrid Approach [arXiv](https://arxiv.org/html/2407.16833v1)
