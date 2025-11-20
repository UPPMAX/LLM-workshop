import os
import base64
from openai import OpenAI

api_port = os.getenv("VLLM_API_PORT")

client = OpenAI(
    base_url=f"http://localhost:{api_port}/v1",
    api_key=""
)

with open("eso2105a.jpg", "rb") as image_file:
    data = base64.b64encode(image_file.read()).decode("utf-8")

messages = [
    {
        "role": "user",
        "content": [
            {"type": "text", "text": "What is shown in the image?"},
            {"type": "image_url", "image_url": {"url": f"data:image/png;base64,{data}"}},
        ],
    },
]

response = client.chat.completions.create(
    model="unsloth/Llama-3.2-11B-Vision-Instruct",
    messages=messages,
)
print(response)

