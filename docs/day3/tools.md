---
title: Tools and Reasoning
icon: fontawesome/solid/diagram-project
---

# Tools and reasoning
> There is a tool for every task, and a task for every tool.
- Tywin Lannister

<!--
## Overview
- The general idea
- Start from CoT
- ReAct
- ToolFormer
- MCPs
- ACPs
- Exercises
    - Run LLM with reasoning/CoT
    - Write a very simple MCP
        - Try talking to it yourself
    - Use that MCP with ReAct:ish
-->

## The general idea
- Just chat
- Chat + reasoning
- Chat + reasoning + tool use
- Examples of tool use

### A Basic Chatbot
![Basic chat interface](figures/basic_chat.svg)

### A Reasoning Chatbot
- [Chain of Thought](https://arxiv.org/abs/2201.11903)
![Reasoning chat interface](figures/reasoning_chat.svg)

### A ReActive Chatbot
- [ReAct](https://arxiv.org/abs/2210.03629)
![ReAct chat interface](figures/react_chat.svg)

### Examples of tool use
- Weather services
- Searching the internet
- Interacting with local files
- Playing games
- RAG (sometimes considered separate)
- Image generation

## Interfaces
- How to different part interface with each other
    - Human and LLM
    - LLM and tool 

### Interafaces and protocols
![Interface schematic](figures/chat_interface_and_mcp.svg)

### Human and LLM
1. Text input
2. HTTP request
3. Tokens (tokenizer.encode)
4. Next token (LLM)
5. Text (tokenizer.decode)
6. HTTP stream
7. Text output

### LLM and tools
1. Tokens
2. Text (tokenizer + chat template)
3. Tool request (stdio/http)
4. Tool use (Model Context Protocol (MCP) server)
5. Tool response (stdio/http)
6. Tokens

## The Model Context Protocol server
- <https://modelcontextprotocol.io/docs/learn/server-concepts>
- Can provide
    1. Tools: Functions callable by the LLM
    2. Resources: Read only access to files or databases
    3. Prompts: Already prepared and ready for use
- The MCP defines the structure of input/output for tool calls
- The MCP does **not** define the structure the LLM should output

## How the model calls a tool
- Forced structured output or
- Model specific embedded structured output

### Forced structured output
- [Structured decoding](https://blog.vllm.ai/2025/01/14/struct-decode-intro.html) to influence model output
- Not compatible with ReAct, only Act.
- In vLLM: Named/Required Function Calling
- Compatible with any model

### Automatic Function Calling
- Models are trained/finetuned to use structured output
- Compatible with ReAct
- Structure is model specific, inference engine must support it

## Using MCP based tools
<!-- TODO?
- How the inference engine identifies tool calls
- The JSON-RCP used in MCP
- Launching a Streamable HTTP MCP server
- Launching a stdio MCP server
-->


### Enabling Tool Calls in vLLM


## Writing tools according to MCP
- The Python SDK for MCP Servers

## Exercises
1. Interact with an MCP server manually
2. Write your own tool according to MCP (note on security)
3. Use both through Chainlit in Alvis OnDemand portal
