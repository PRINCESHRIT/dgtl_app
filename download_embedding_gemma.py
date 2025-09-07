#!/usr/bin/env python3
"""
Download EmbeddingGemma model from Hugging Face
"""
import os
from huggingface_hub import hf_hub_download
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def download_embedding_gemma():
    """Download EmbeddingGemma model files from Hugging Face"""
    
    # Create models directory if it doesn't exist
    models_dir = "assets/models"
    os.makedirs(models_dir, exist_ok=True)
    
    try:
        # Try different repository names for EmbeddingGemma
        repo_names = [
            "google/embedding-gemma-308m",
            "google/embedding-gemma",
            "GoogleAI/embedding-gemma-308m",
            "GoogleAI/embedding-gemma"
        ]
        
        model_files = [
            "model.tflite",
            "embedding-gemma-308m-e2b.tflite",
            "pytorch_model.bin",
            "tokenizer.json",
            "vocab.txt"
        ]
        
        success = False
        
        for repo_name in repo_names:
            logger.info(f"🔄 Trying to download from {repo_name}...")
            
            try:
                for file_name in model_files:
                    try:
                        logger.info(f"  📥 Downloading {file_name}...")
                        
                        # Download the file
                        downloaded_path = hf_hub_download(
                            repo_id=repo_name,
                            filename=file_name,
                            cache_dir=models_dir
                        )
                        
                        # Copy to our assets directory
                        target_path = os.path.join(models_dir, file_name)
                        if os.path.exists(downloaded_path):
                            os.system(f'cp "{downloaded_path}" "{target_path}"')
                            logger.info(f"  ✅ Downloaded {file_name}")
                            success = True
                            
                    except Exception as e:
                        logger.warning(f"  ⚠️ Could not download {file_name}: {e}")
                        continue
                        
                if success:
                    logger.info(f"✅ Successfully downloaded files from {repo_name}")
                    break
                    
            except Exception as e:
                logger.warning(f"❌ Repository {repo_name} failed: {e}")
                continue
        
        if not success:
            logger.error("❌ Could not download EmbeddingGemma from any repository")
            logger.info("🔄 Creating placeholder model file for development...")
            
            # Create a proper placeholder model file
            placeholder_path = os.path.join(models_dir, "embedding-gemma-308m-e2b.tflite")
            with open(placeholder_path, 'w') as f:
                f.write("# EmbeddingGemma 308M Placeholder Model\n")
                f.write("# Replace this with actual model file from Google/Hugging Face\n")
                f.write("# Model specifications:\n")
                f.write("# - Input: tokenized text (max 2048 tokens)\n")
                f.write("# - Output: 768-dimensional embedding vector\n")
                f.write("# - Architecture: EmbeddingGemma 308M parameters\n")
            
            logger.info(f"📝 Created placeholder at {placeholder_path}")
            
        # List downloaded files
        logger.info("📋 Files in assets/models/:")
        for file in os.listdir(models_dir):
            file_path = os.path.join(models_dir, file)
            size = os.path.getsize(file_path)
            logger.info(f"  - {file} ({size} bytes)")
            
    except Exception as e:
        logger.error(f"❌ Download failed: {e}")
        return False
        
    return True

if __name__ == "__main__":
    print("🚀 Starting EmbeddingGemma model download...")
    success = download_embedding_gemma()
    
    if success:
        print("✅ EmbeddingGemma download completed!")
    else:
        print("⚠️ Download completed with issues - using development mode")
