#!/usr/bin/env python3
"""
Download EmbeddingGemma 300M model from official Hugging Face repository
Requires Hugging Face authentication to accept terms of use
"""
import os
import requests
from huggingface_hub import HfApi, login, snapshot_download
from pathlib import Path

def check_authentication():
    """Check if user is authenticated with Hugging Face"""
    try:
        api = HfApi()
        user = api.whoami()
        print(f"✅ Authenticated as: {user['name']} ({user.get('email', 'no email')})")
        return True
    except Exception as e:
        print(f"❌ Not authenticated: {e}")
        return False

def download_official_embedding_gemma():
    """Download the official EmbeddingGemma 300M model"""
    repo_id = "google/embeddinggemma-300m"
    model_dir = "models/embeddinggemma-300m"
    
    print("🚀 Downloading Official EmbeddingGemma 300M Model")
    print("=" * 50)
    
    # Check authentication
    if not check_authentication():
        print("\n📋 Authentication Required:")
        print("1. Create a Hugging Face account: https://huggingface.co/join")
        print("2. Visit model page: https://huggingface.co/google/embeddinggemma-300m")
        print("3. Accept the terms of use")
        print("4. Generate an access token: https://huggingface.co/settings/tokens")
        print("5. Run: huggingface-cli login")
        return False
    
    try:
        # Create model directory
        Path(model_dir).mkdir(parents=True, exist_ok=True)
        
        print(f"\n📁 Downloading to: {model_dir}")
        
        # Download the model files
        downloaded_files = snapshot_download(
            repo_id=repo_id,
            local_dir=model_dir,
            local_dir_use_symlinks=False,
            resume_download=True
        )
        
        print(f"✅ Successfully downloaded {len(os.listdir(model_dir))} files")
        
        # List downloaded files
        print("\n📋 Downloaded Files:")
        for file in sorted(os.listdir(model_dir)):
            file_path = os.path.join(model_dir, file)
            if os.path.isfile(file_path):
                size_mb = os.path.getsize(file_path) / (1024 * 1024)
                print(f"  • {file} ({size_mb:.1f} MB)")
        
        # Check for TensorFlow Lite models
        tflite_files = [f for f in os.listdir(model_dir) if f.endswith('.tflite')]
        if tflite_files:
            print(f"\n🎯 Found TensorFlow Lite models: {tflite_files}")
        else:
            print("\n⚠️  No .tflite files found. You may need to convert from PyTorch/SafeTensors")
        
        return True
        
    except Exception as e:
        print(f"❌ Download failed: {e}")
        return False

def convert_to_tflite_if_needed():
    """Convert PyTorch model to TensorFlow Lite if needed"""
    model_dir = "models/embeddinggemma-300m"
    
    # Check if we already have a .tflite file
    tflite_files = [f for f in os.listdir(model_dir) if f.endswith('.tflite')]
    if tflite_files:
        print(f"✅ TensorFlow Lite model already available: {tflite_files[0]}")
        return True
    
    print("\n🔄 Converting to TensorFlow Lite...")
    print("Note: This requires additional dependencies:")
    print("  pip install torch sentence-transformers tensorflow")
    
    try:
        from sentence_transformers import SentenceTransformer
        import tensorflow as tf
        
        # Load the model
        model = SentenceTransformer("google/embeddinggemma-300m")
        
        # This is a placeholder - actual conversion would be more complex
        print("⚠️  TensorFlow Lite conversion for EmbeddingGemma requires specialized tools")
        print("Consider using the PyTorch model with sentence-transformers library")
        
        return False
        
    except ImportError as e:
        print(f"❌ Missing dependencies: {e}")
        return False

def main():
    print("📥 EmbeddingGemma Official Model Downloader")
    print("=" * 50)
    
    # Download the model
    if download_official_embedding_gemma():
        print("\n🎉 Download completed successfully!")
        
        # Try to convert to TensorFlow Lite
        convert_to_tflite_if_needed()
        
        print("\n📋 Next Steps:")
        print("1. Update your Flutter app to use the downloaded model")
        print("2. Consider using sentence-transformers for embeddings")
        print("3. Implement embedding generation with the official model")
        
    else:
        print("\n❌ Download failed. Please check authentication and try again.")

if __name__ == "__main__":
    main()
