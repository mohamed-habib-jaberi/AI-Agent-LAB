#!/usr/bin/env bash
# ============================================================
# setup.sh – Environment setup for AI-Agent-LAB (Gemini Chatbot)
# ------------------------------------------------------------
# What it does:
#   1. Creates a virtual environment (.venv)
#   2. Activates it
#   3. Installs required Python packages:
#        - jupyter
#        - ipywidgets
#        - python-dotenv
#        - google-generativeai
#   4. Enables ipywidgets in Jupyter Notebook
#   5. Creates a .env file if missing (without exposing real API key)
#
# Usage:
#   chmod +x setup.sh
#   ./setup.sh
# ============================================================

set -e  # Stop on first error

echo "🔧 Setting up environment for AI-Agent-LAB …"

# 1) Go to the folder where this script lives (project root)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"
echo "📂 Project root: $PROJECT_ROOT"

# 2) Choose Python binary (default: python3)
PYTHON_BIN="${PYTHON_BIN:-python3}"
echo "🐍 Using Python: $PYTHON_BIN"

# 3) Create virtual environment if not exists
if [ ! -d ".venv" ]; then
  echo "📦 Creating virtual environment (.venv)…"
  "$PYTHON_BIN" -m venv .venv
else
  echo "✅ Virtual environment .venv already exists, reusing it."
fi

# 4) Activate virtual environment
echo "✅ Activating virtual environment…"
# shellcheck disable=SC1091
source .venv/bin/activate

# 5) Upgrade pip inside venv
echo "⬆️  Upgrading pip inside venv…"
python -m pip install --upgrade pip

# 6) Install required packages
echo "📦 Installing required Python packages…"
python -m pip install \
  jupyter \
  ipywidgets \
  python-dotenv \
  google-generativeai

# 7) Enable ipywidgets extension for classic Jupyter Notebook
echo "🔗 Enabling ipywidgets extension for Jupyter…"
jupyter nbextension enable --py widgetsnbextension --sys-prefix || true

# 8) Create .env file if missing
if [ ! -f ".env" ]; then
    echo "🧪 Creating .env file…"
    cat <<EOF > .env
# Environment variables for AI-Agent-LAB
# Replace YOUR_REAL_KEY_HERE with your actual Gemini API key

GEMINI_API_KEY=YOUR_REAL_KEY_HERE
EOF
    echo "✅ .env file created. Please update it with your real Gemini API key."
else
    echo "ℹ️  .env already exists — not modifying it."
fi

echo
echo "✅ Setup complete!"
echo
echo "Next steps:"
echo "  1) Activate the venv when you open a new terminal:"
echo "       source .venv/bin/activate"
echo "  2) Start Jupyter Notebook:"
echo "       jupyter notebook"
echo "  3) Open ChatBot.ipynb and run all cells."
echo
echo "🎉 You’re ready to use the Police Sketch Artist Chatbot (Gemini)."