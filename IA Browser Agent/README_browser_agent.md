# 🌐 Browser AI Agent (OpenAI + Playwright)

This folder contains a **Browser AI Agent** that can automatically open a web page, read its content, and summarize or reason about it using an OpenAI model. It runs in a Jupyter notebook and uses **Playwright** to control the browser programmatically.

---

## 🚀 What This Agent Does

The Browser AI Agent:

- Launches a headless browser using **Playwright**
- Navigates to a target URL (for example, a documentation page or article)
- Extracts relevant text from the page
- Sends the page content to an **OpenAI model** (via the official `openai` Python client)
- Asks the model to summarize, explain, or answer questions about the page
- Displays the final response back in the notebook

This is a simple example of an **AI-augmented browser workflow**: the agent does the browsing, the LLM does the thinking.

---

## 🧩 Main Technologies

- **Python 3.11+**
- **OpenAI Python SDK** (`openai`)
- **Playwright** (`playwright` and `playwright.async_api`)
- **Jupyter Notebook**
- **dotenv** (`python-dotenv`) to load the API key from a `.env` file
- `asyncio` for asynchronous browser control

---

## 🛠️ Setup & Installation

From the project root (`AI-Agent-LAB`), you can either use your existing virtual environment or create a new one.

### 1️⃣ Create and Activate a Virtual Environment (if needed)

```bash
python3 -m venv .venv
source .venv/bin/activate  # macOS / Linux
# .venv\Scripts\activate  # Windows (PowerShell or CMD)
```

### 2️⃣ Install Required Packages

Inside the virtual environment, install the dependencies:

```bash
pip install openai playwright python-dotenv jupyter
```

Then install Playwright browser binaries (Chromium, etc.):

```bash
playwright install
```

> 💡 You only need to run `playwright install` once per machine / environment.

### 3️⃣ Configure Your OpenAI API Key (.env)

In the `Browser AI Agent/` folder, create a file named `.env`:

```env
OPENAI_API_KEY=your_real_openai_key_here
```

> ⚠️ **Important:**  
> - Never commit your `.env` file or API keys to GitHub.  
> - `.gitignore` should already be configured to ignore `.env`.

---

## 📂 Project Structure (Browser AI Agent folder)

```text
AI-Agent-LAB/
└─ Browser AI Agent/
   ├─ browser_agent.ipynb   # Jupyter notebook with the Browser AI Agent code
   └─ README.md             # This documentation file
```

Your notebook typically contains logic similar to:

- Importing `asyncio`, `openai`, and `async_playwright`
- Using `async with async_playwright() as p:` to open a browser
- Navigating to a URL with `page.goto("https://example.com")`
- Extracting text via `page.inner_text("body")` or similar
- Sending that text to an LLM with a prompt like:  
  _"Summarize this page in 5 bullet points for a developer."_

---

## ▶️ How to Run the Browser AI Agent

1. Activate your virtual environment:

   ```bash
   cd AI-Agent-LAB
   source .venv/bin/activate
   ```

2. Start Jupyter Notebook:

   ```bash
   jupyter notebook
   ```

3. In the Jupyter interface, open:

   ```text
   Browser AI Agent/browser_agent.ipynb
   ```

4. Make sure your `.env` is present in `Browser AI Agent/` and contains `OPENAI_API_KEY`.

5. Run all cells in order (for example: **Kernel → Restart & Run All**).  
   The notebook will:
   - Launch Playwright
   - Open the target web page
   - Extract content
   - Call the OpenAI model
   - Display the AI-generated summary or answer in the notebook

---

## 🧠 High-Level Code Flow

A typical flow inside the notebook looks like:

1. **Load environment & configure OpenAI**  

   ```python
   from dotenv import load_dotenv
   import os
   import openai

   load_dotenv()
   client = openai.OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
   ```

2. **Define an async function that uses Playwright**  

   ```python
   from playwright.async_api import async_playwright
   import asyncio

   async def browse_and_summarize(url: str):
       async with async_playwright() as p:
           browser = await p.chromium.launch(headless=True)
           page = await browser.new_page()
           await page.goto(url)
           content = await page.inner_text("body")
           await browser.close()

           prompt = f"Summarize the following page for a developer:\n\n{content[:8000]}"
           response = client.chat.completions.create(
               model="gpt-4.1-mini",
               messages=[{"role": "user", "content": prompt}],
           )
           return response.choices[0].message.content
   ```

3. **Run the agent from the notebook**  

   ```python
   result = asyncio.run(browse_and_summarize("https://example.com"))
   print(result)
   ```

This pattern combines **headless browsing** with **LLM reasoning** in a clean, reproducible way.

---

## 🔒 Security Notes

- Keep API keys *only* in `.env`, never hard-coded in notebooks or scripts.
- Avoid sending sensitive or private pages to external LLM APIs.
- Review page content size and truncate if necessary before sending to the model.

---

## ✅ Next Ideas

You can extend this Browser AI Agent to:

- Answer questions about a documentation site
- Monitor changes on a page and summarize updates
- Extract structured data (links, titles, sections) then analyze with an LLM
- Chain browsing + multiple prompts for deeper reasoning

---

Happy hacking with your **Browser AI Agent**! 🚀
