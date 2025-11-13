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

### Interafaces schematic
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
4. Tool use (MCP)
5. Tool response (stdio/http)
6. Tokens

## Using MCP based tools

## Writing tools according to MCP

## Exercises
1. Interact with an MCP manually
2. Write your own MCP (note on security)
3. Use both through Chainlit in Alvis OnDemand portal
