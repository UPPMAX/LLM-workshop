import base64
import requests
from PIL import Image
from transformers import AutoProcessor, AutoModelForImageTextToText, MllamaForConditionalGeneration

model_name = "/mimer/NOBACKUP/Datasets/LLM/huggingface/hub/models--unsloth--Llama-3.2-11B-Vision-Instruct/snapshots/677b0c1b7008230a0fb88708c5550748e72b9a83/"

model = AutoModelForImageTextToText.from_pretrained(
    model_name,
    torch_dtype="auto",
    device_map="auto",
)
processor = AutoProcessor.from_pretrained(model_name)

url = "https://cdn.eso.org/images/screen/eso2105a.jpg"
image = Image.open(requests.get(url, stream=True).raw)

messages = [
    {
        "role": "user",
        "content": [
            {"type": "image"},
            {"type": "text", "text": "What is shown in the image"}
        ]
    }
]

input_text = processor.apply_chat_template(messages, add_generation_prompt=True)
inputs = processor(
    image,
    input_text,
    add_special_tokens=False,
    return_tensors="pt"
).to(model.device)

output = model.generate(**inputs, max_new_tokens=30)
print(processor.decode(output[0]))

print("======================================================================")

messages = [
    {
        "role": "user",
        "content": [
            {"type": "image", "url": url},
            {"type": "text", "text": "What is shown in the image?"},
        ],
    },
]

processed_chat = processor.apply_chat_template(messages, add_generation_prompt=True, tokenize=True, return_dict=True, return_tensors="pt")
print(list(processed_chat.keys()))

out = model.generate(**processed_chat.to(model.device), max_new_tokens=128)
print(processor.decode(out[0]))

print("======================================================================")

# wget https://cdn.eso.org/images/screen/eso2105a.jpg
with open("eso2105a.jpg", "rb") as image_file:
    data = base64.b64encode(image_file.read()).decode("utf-8")

messages = [
    {
        "role": "user",
        "content": [
            {"type": "text", "text": "What is shown in the image?"},
            {"type": "image", "url": f"data:image/png;base64,{data}"},
        ],
    },
]

processed_chat = processor.apply_chat_template(messages, add_generation_prompt=True, tokenize=True, return_dict=True, return_tensors="pt")
print(list(processed_chat.keys()))

out = model.generate(**processed_chat.to(model.device), max_new_tokens=128)
print(processor.decode(out[0]))
