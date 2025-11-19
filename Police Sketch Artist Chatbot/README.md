# 👮 Police Sketch Artist Chatbot — Gemini API (Jupyter Notebook)

This project demonstrates how to build an interactive **LLM-powered chatbot** using the **Google Gemini API** inside a Jupyter Notebook.  
The chatbot behaves like a **police sketch artist**, asking precise, progressive questions to refine a suspect description based on user-provided clues.

---

## 📘 Project Overview

The goal is to simulate a structured police interview.  
You provide an initial clue (e.g., _“He looks like a Viking”_), and the chatbot continues with targeted follow-up questions about:

- Hair  
- Eyes  
- Facial structure  
- Beard / mustache  
- Clothing  
- Distinguishing features  

This notebook demonstrates:

- Integration with **Gemini 2.5 Flash** (or another available Gemini chat model)  
- Secure API key loading via `.env`  
- A fully interactive **chat UI** using `ipywidgets`  
- Multi-turn conversation memory with `chat_history`  
- A guided system prompt that enforces “sketch artist” behavior  
- Clean, extensible architecture suitable for future upgrades  

---

## 🧩 Features

### ✅ Interactive Chat UI (Jupyter)

A lightweight interface built with `ipywidgets`, including:

- Input text box  
- Send button  
- Scrollable chat window  
- Automatic line-wrapping (no truncated text)  
- Auto-scrolling for long responses  

---

### ✅ Conversation Memory

Chat history is stored using:

```python
chat_history = []
```

This allows the model to maintain context and refine the description over multiple turns.

---

### ✅ Extra Commands

Users can also type:

- `history` → show full conversation  
- `exit` or `quit` → end the session  

---

### ✅ Smart Follow-Up Questions

The chatbot behaves like a real sketch artist:

- Asks focused clarifying questions  
- Builds the description step-by-step  
- Guides the user through key visual traits (hair, face, eyes, beard, clothes, etc.)  

---

## 🔐 Environment Variable Setup

Your Gemini API key is stored securely inside a `.env` file, **never** hard-coded in the notebook.

Example `.env`:

```env
GEMINI_API_KEY=your_api_key_here
```

The notebook loads it with:

```python
from dotenv import load_dotenv
import os

load_dotenv()
api_key = os.getenv("GEMINI_API_KEY")
```

If the key is missing, the script fails fast with a clear error.

---

## 🛠️ Installation & Environment Setup

Follow these steps to run the project locally.

---

### 1️⃣ Create a Project Folder

```bash
mkdir police-sketch-chatbot
cd police-sketch-chatbot
```

---

### 2️⃣ Create and Activate a Virtual Environment

Create an isolated Python environment so this project doesn’t interfere with your global packages.

```bash
python3 -m venv .venv
```

Activate it:

```bash
# macOS / Linux
source .venv/bin/activate

# Windows (PowerShell)
# .venv\Scripts\Activate.ps1
```

After activation, your terminal prompt should start with `(.venv)` — this means the virtual environment is active and ready.

---

### 3️⃣ Install Required Dependencies

Install the libraries used by the notebook:

```bash
pip install google-generativeai python-dotenv ipywidgets jupyter
```

Enable widgets support for Jupyter (needed once):

```bash
jupyter nbextension enable --py widgetsnbextension
```

---

### 4️⃣ Add Your `.env` File

Create a file named `.env` in the project root:

```bash
touch .env
```

Open it and add:

```env
GEMINI_API_KEY=your_api_key_here
```

Replace `your_api_key_here` with your real Gemini API key.

---

### 5️⃣ Launch Jupyter Notebook

```bash
jupyter notebook
```

Then open **`ChatBot.ipynb`** from the Jupyter interface and run the cells in order.

---

## 🧠 How the Chat Logic Works

For each user message:

1. The text is validated (no empty input).  
2. The message is appended to `chat_history`.  
3. A combined prompt is built: **previous details + new detail**.  
4. The prompt is sent to Gemini using `model.generate_content(...)`.  
5. Gemini returns a focused follow-up question.  
6. The chat area is updated and auto-scrolled to the latest message.  

This creates a natural, iterative sketch-artist style conversation.

---

## 🧪 Example Interaction

**You:**  
He looks like a Viking.

**Bot:**  
Tell me about his hair. Is it long, short, shaved, or something else?

**You:**  
Long blond hair.

**Bot:**  
Is it straight, wavy, or braided?

**You:**  
Wavy.

**Bot:**  
Got it. Does he have facial hair—a full beard, stubble, or is he clean-shaven?

---

## 📦 Project Structure

A minimal structure might look like this:

```text
├── ChatBot.ipynb
├── README.md
├── .env
└── .venv/
```

- `ChatBot.ipynb` — main Jupyter Notebook with UI + Gemini logic  
- `.env` — contains your `GEMINI_API_KEY`  
- `.venv/` — Python virtual environment (not committed to Git)  

---

## 🧩 Technologies Used

- **Google Gemini API** (e.g., `gemini-2.5-flash` or similar)  
- **Python 3.10+**  
- **Jupyter Notebook**  
- **ipywidgets** for the chat interface  
- **python-dotenv** for environment management  

---

## ✔️ Ideal Use Cases

- Practicing **prompt engineering**  
- Learning how to integrate **Gemini** into Python projects  
- Building custom LLM chatbots with UI in notebooks  
- Teaching demonstrations or workshops  
- Prototyping agentic / interview-style assistants  

---

## 🏁 Conclusion

This project provides a clean, secure, and fully functional implementation of a **Gemini-powered police sketch artist chatbot**.  
It’s easy to run, easy to extend, and serves as a solid foundation for more advanced multi-agent or RAG-based systems.

Feel free to fork the project, customize the prompts, or integrate additional logic such as image generation, storage, or more complex workflows.
