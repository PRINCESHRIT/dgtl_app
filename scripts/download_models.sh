#!/bin/bash
# DGTL Healthcare - Model Download Script (Alternative)
# Downloads TFLite models from various sources

set -e

MODELS_DIR="../assets/models"
mkdir -p "$MODELS_DIR"

echo "🏥 DGTL Healthcare - TFLite Model Setup"
echo "======================================"

# Function to download with progress
download_with_progress() {
    local url=$1
    local filename=$2
    local target="$MODELS_DIR/$filename"
    
    echo "🔽 Downloading $filename..."
    
    if command -v wget &> /dev/null; then
        wget --progress=bar:force:noscroll -O "$target" "$url"
    elif command -v curl &> /dev/null; then
        curl -L --progress-bar -o "$target" "$url"
    else
        echo "❌ Neither wget nor curl found. Please install one of them."
        return 1
    fi
    
    echo "✅ Downloaded $filename"
}

# Method 1: Try official Google AI releases
echo "🎯 Method 1: Checking Google AI releases..."

EMBEDDING_GEMMA_URL="https://storage.googleapis.com/download.tensorflow.org/models/tflite/task_library/text_embedder/embedding_gemma_308m_e2b.tflite"
GEMMA_2B_URL="https://storage.googleapis.com/download.tensorflow.org/models/tflite/gemma_2b_it_gpu.tflite"

# Try downloading EmbeddingGemma
echo "📦 Attempting to download EmbeddingGemma 308M..."
if download_with_progress "$EMBEDDING_GEMMA_URL" "embedding-gemma-308m-e2b.tflite"; then
    echo "✅ EmbeddingGemma downloaded successfully"
else
    echo "⚠️  Official EmbeddingGemma URL not available"
fi

# Try downloading Gemma 2B
echo "📦 Attempting to download Gemma 2B IT..."
if download_with_progress "$GEMMA_2B_URL" "gemma-2b-it.tflite"; then
    echo "✅ Gemma 2B downloaded successfully"
else
    echo "⚠️  Official Gemma 2B URL not available"
fi

echo ""
echo "🔍 Checking downloaded models..."

# Verify models
for model_file in "$MODELS_DIR"/*.tflite; do
    if [[ -f "$model_file" ]]; then
        size=$(stat -f%z "$model_file" 2>/dev/null || stat -c%s "$model_file" 2>/dev/null || echo "0")
        if [[ $size -gt 1000 ]]; then
            echo "✅ $(basename "$model_file"): ${size} bytes (Valid)"
        else
            echo "❌ $(basename "$model_file"): ${size} bytes (Invalid - likely placeholder)"
        fi
    fi
done

echo ""
echo "📋 Manual Download Instructions:"
echo "================================"
echo ""
echo "If automatic download failed, you can manually download models:"
echo ""
echo "🔗 EmbeddingGemma 308M:"
echo "   - Hugging Face: https://huggingface.co/google/embedding-gemma-308m"
echo "   - Kaggle: https://www.kaggle.com/models/google/embedding-gemma-308m"
echo "   - Save as: assets/models/embedding-gemma-308m-e2b.tflite"
echo ""
echo "🔗 Gemma 2B Instruction-Tuned:"
echo "   - Hugging Face: https://huggingface.co/google/gemma-2b-it" 
echo "   - Kaggle: https://www.kaggle.com/models/google/gemma-2b-it"
echo "   - Save as: assets/models/gemma-2b-it.tflite"
echo ""
echo "⚠️  Note: Models are large (150MB-4GB). Ensure good internet connection."
echo ""
echo "🧪 Testing:"
echo "   Run: flutter test test/experimental/test_embedding_gemma.dart"
