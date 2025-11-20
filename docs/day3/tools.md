---
title: Tools and Reasoning
author: NAISS
icon: fontawesome/solid/diagram-project
---


<!--
# Tools and reasoning
<style type="text/css" rel="stylesheet">
.reveal section {
  text-align: center;
}
</style>
> There is a tool for every task, and a task for every tool.
- Tywin Lannister
-->

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

### Model Context Protocol (MCP)
- Standard for how to interface with tools
- MCP Clients are those which want to use a tool
- MCP Server is what handles the tool
- By following the protocol, you don't need an implementation per server-client
  combination

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
4. Tool use (MCP server)
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
    - xml, json, special tokens, ...

## Using MCP based tools
- Inference Engine
- MCP Client
    - stdio
    - SSE
    - Streamable-HTTP

### Enabling Tool Calls in vLLM
- <https://docs.vllm.ai/en/stable/features/tool_calling.html#automatic-function-calling>
- `--enable-auto-tool-choice`
- `--tool-call-parser=<supported-parser-name>`

### Connecting to an MCP Server from Chainlit: stdio
- The MCP Client (Chainlit) launches the tool
    - Chainlit config limits what executables can be used
    - Recommended to be careful with what you add here
- The MCP client will launch the tools as a subprocess
    - As your user
    - Don't (let the AI) run unknown code
- Examples:
    - `npx -y @modelcontextprotocol/server-filesystem /dev/shm /tmp`
    - `mcp run -t stdio mcp_server.py`

### Connecting to an MCP Server from Chainlit: HTTP
- SSE deprecated in favor of Streamable HTTP
- For connecting to existing MCP Server
- Authentication tokens typically needed
- Required:
    - HTTP adress
    - Possibly a header with authentication token

## Writing tools according to MCP
- The Python SDK for MCP Servers
- <https://github.com/modelcontextprotocol/python-sdk?tab=readme-ov-file#quickstart>
<!-- TODO -->

## Exercises
1. Using tools via MCPs in Chainlit
2. Developing your own MCP server
<!--3. (Optional) connecting to HuggingFace MCP with a token--> <!-- Alternatively, run a dummy mcp on the github pages -->

### Using tools via MCPs in Chainlit
1. Edit `~/.chainlit/config.toml` under `[features.mcp.studio]` change to `allowed_executables = [ "npx", "uvx", "mcp" ]`
1. Copy the the quick start example from the Python MCP SDK <https://github.com/modelcontextprotocol/python-sdk?tab=readme-ov-file#quickstart>
2. Prepare the custom Chainlit runtime environment for this exercise: `cp /mimer/NOBACKUP/groups/llm-workshop/exercises/day3/tools/portal/chainlit/use_existing_vllm.sh ~/portal/chainlit/`
3. Launch a Chainlit interactive session from <https://alvis.c3se.chalmers.se> with the `use_existing_vllm.sh` runtime and 1 CPU core.
4. Press the plug symbol to add an MCP Server
    1. Select `stdio` as transport
    2. Give it a name
    3. Add command `mcp run -t stdio <path to mcp server file here>`

### Developing your own MCP server
- Based on the Getting Started example write your own MCP tool. 
- Note that if you launch it from inside the container, you will be limited to what is in the container
- Optionally, install mcp in a venv and launch an SSE instead of stdio and use that:
    - You will need to forward the port for the SSE to the compute node you're running Chainlit on
