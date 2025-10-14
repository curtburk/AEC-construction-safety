#!/bin/bash

echo "=================================="
echo "Construction Safety Demo Installer"
echo "=================================="
echo ""

# Check Python version
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed."
    echo "Please install with: sudo apt-get install python3 python3-pip python3-venv"
    exit 1
fi

echo "✓ Python 3 found: $(python3 --version)"

# Create virtual environment
echo ""
echo "Creating virtual environment..."
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install backend dependencies
echo ""
echo "Installing dependencies..."
cd backend
pip install -r requirements.txt

# Try to download model for offline use
echo ""
echo "Attempting to download model for offline use..."
echo "This will take a few minutes and requires internet (one-time only)..."

python3 -c "
from transformers import pipeline
import os

model_path = './model/ConstructionSafetyQA-1.2B-V1'
if not os.path.exists(model_path):
    try:
        print('Downloading model (approximately 2.4GB)...')
        pipe = pipeline('text-generation', model='ConstructionSafetyQA-1.2B-V1')
        pipe.save_pretrained(model_path)
        print('✓ Model downloaded and cached for offline use!')
    except Exception as e:
        print(f'⚠️  Could not download model: {e}')
        print('Demo will run in offline fallback mode.')
else:
    print('✓ Model already cached locally!')
" || echo "⚠️  Model download skipped. Demo will use offline responses."

cd ..

echo ""
echo "=================================="
echo "✅ Installation Complete!"
echo "=================================="
echo ""
echo "To start the demo: ./start_demo.sh"
echo ""