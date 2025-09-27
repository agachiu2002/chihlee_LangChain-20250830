#gradio介紹 https://github.com/roberthsu2003/gradio?tab=readme-ov-file
# https://www.gradio.app/playground --chatbot

import random
import gradio as gr

def random_response(message, history):
    return random.choice(["Yes", "No"])

demo = gr.ChatInterface(random_response, type="messages", autofocus=False)

if __name__ == "__main__":
    demo.launch()
