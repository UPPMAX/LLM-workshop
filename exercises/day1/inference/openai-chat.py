import os
from openai import OpenAI

api_port = os.getenv("API_PORT")
client = OpenAI(
    base_url=f"http://localhost:{api_port}/v1",
    api_key=""
)

model_list = client.models.list()
print(model_list)

print("========================================================================")

response = client.chat.completions.create(
    model="openai/gpt-oss-20b",
    messages=[{"role": "user", "content": "why is the sky blue?"}]
)
print(response)

