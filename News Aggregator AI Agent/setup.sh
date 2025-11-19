#!/usr/bin/env bash
# Setup script for News Aggregator AI Agent
# - Activates root .venv
# - Installs agent-specific requirements


#############################################
# 🚀 Usage Instructions (Helper Notes)
#
# 1️⃣ Activate virtual environment:
#     source .venv/bin/activate
#
# 2️⃣ Navigate into this agent folder:
#     cd "News Aggregator AI Agent"
#
# 3️⃣ Install this agent's dependencies manually (optional):
#     python -m pip install -r requirements.txt
#
# 4️⃣ Make the setup executable:
#     chmod +x setup.sh
#
# 5️⃣ Run the setup script:
#     ./setup.sh
#
# 6️⃣ Launch Jupyter Notebook to test your agent:
#     jupyter notebook
#
#############################################

set -e

# Go to the folder where this script lives
AGENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$AGENT_DIR"

echo "📂 Agent directory: $AGENT_DIR"

# Root project folder is the parent of this directory
PROJECT_ROOT="$(cd "$AGENT_DIR/.." && pwd)"
echo "🗂  Project root: $PROJECT_ROOT"

# Check that .venv exists
if [ ! -d "$PROJECT_ROOT/.venv" ]; then
  echo "⚠️  .venv not found in project root."
  echo "👉 Run './setup.sh' from $PROJECT_ROOT first to create the virtualenv."
  exit 1
fi

# Activate venv
echo "✅ Activating virtualenv..."
# shellcheck disable=SC1091
source "$PROJECT_ROOT/.venv/bin/activate"

# Install this agent's requirements
if [ -f "requirements.txt" ]; then
  echo "📦 Installing News Aggregator dependencies..."
  python -m pip install -r requirements.txt
else
  echo "⚠️  requirements.txt not found in $AGENT_DIR"
fi

echo "🎉 News Aggregator AI Agent setup complete."


