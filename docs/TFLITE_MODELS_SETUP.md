# DGTL Healthcare - TFLite Models Setup Guide

## 🎯 Quick Start

### Option 1: Automated Python Script (Recommended)
```bash
cd scripts
pip install huggingface_hub requests
python3 download_models.py
```

### Option 2: Shell Script  
```bash
cd scripts
./download_models.sh
```

### Option 3: Manual Download

## 📦 Required Models

### 1. EmbeddingGemma 308M (Priority: HIGH)
**File**: `assets/models/embedding-gemma-308m-e2b.tflite`
**Size**: ~150-300MB  
**Purpose**: Text embeddings for RAG vector search

**Download Sources**:
- 🤗 [Hugging Face](https://huggingface.co/google/embedding-gemma-308m)
- 🏆 [Kaggle Models](https://www.kaggle.com/models/google/embedding-gemma-308m)
- 📱 [Google AI Studio](https://aistudio.google.com/app/prompts/new_chat)

### 2. Gemma 2B Instruction-Tuned (Priority: MEDIUM)
**File**: `assets/models/gemma-2b-it.tflite`
**Size**: ~2-4GB
**Purpose**: AI text generation for medical responses

**Download Sources**:
- 🤗 [Hugging Face](https://huggingface.co/google/gemma-2b-it)
- 🏆 [Kaggle Models](https://www.kaggle.com/models/google/gemma-2b-it)
- 📱 [Google AI Studio](https://aistudio.google.com/app/prompts/new_chat)

## 🔧 Manual Download Instructions

### Step 1: Download Models
1. Visit the Hugging Face or Kaggle links above
2. Look for `.tflite` files in the model repositories  
3. Download the TensorFlow Lite versions specifically
4. Save to the exact paths shown above

### Step 2: Verify Downloads
```bash
# Check file sizes (should be substantial)
ls -lh assets/models/

# Verify they're binary files, not text
file assets/models/*.tflite
```

### Step 3: Test Integration
```bash
# Run AI embedding tests
flutter test test/experimental/test_embedding_gemma.dart

# Run complete RAG tests  
flutter test test/experimental/test_rag_service.dart
```

## 🚨 Important Notes

### Model Sizes
- **EmbeddingGemma**: Essential for RAG functionality (~150MB)
- **Gemma 2B**: Optional for advanced responses (~2-4GB)

### Fallback Behavior
Your app will work even without models due to intelligent fallbacks:
- ✅ **Without models**: Template responses + semantic embeddings
- ✅ **With embedding model**: Vector search + template responses  
- ✅ **With both models**: Full AI generation + vector search

### Privacy Benefits
- 🔒 **On-device processing**: No data sent to external servers
- 🔐 **HIPAA compliant**: Patient data never leaves the device
- ⚡ **Fast inference**: Local models eliminate network latency

## 🧪 Testing After Download

### 1. Quick Test
```dart
// This should now work with real models
final embeddingService = EmbeddingGemmaService();
await embeddingService.initialize();
final embedding = await embeddingService.generateEmbedding("chest pain");
print("Embedding generated: ${embedding.length} dimensions");
```

### 2. Full RAG Test
```dart
final ragService = DgtlRagService();  
await ragService.initialize();
final response = await ragService.performRag(
  query: "What should I do about swelling?",
  context: "Patient has CKD stage 3",
);
print("AI Response: ${response.generatedResponse}");
```

## 🔗 Alternative Sources

### If Official Sources Unavailable:
1. **MediaFire/Google Drive**: Community-shared models
2. **GitHub Releases**: Check TensorFlow Lite model releases
3. **Docker Images**: Some contain pre-built models
4. **Local Conversion**: Convert from original PyTorch/JAX models

### Convert Your Own Models:
```bash
# If you have access to original Gemma models
pip install transformers torch tensorflow
python convert_to_tflite.py --model google/gemma-2b-it --output gemma-2b-it.tflite
```

## 📞 Support

If you encounter issues:
1. Check file sizes match expected ranges
2. Verify files are binary (.tflite format)  
3. Run test scripts to validate functionality
4. Check console logs for specific error messages

The app is designed to work gracefully even without models, so you can proceed with development while models download in the background.
