#!/usr/bin/env python3
"""
DGTL Healthcare App - TFLite Model Download Script
Downloads official Google Gemma models for on-device AI processing
"""

import os
import requests
import subprocess
from pathlib import Path
import hashlib

# Model configurations
MODELS = {
    "embedding-gemma-308m": {
        "filename": "embedding-gemma-308m-e2b.tflite",
        "huggingface_repo": "google/embedding-gemma-308m",
        "expected_size": 150_000_000,  # ~150MB
        "sha256": None,  # Will be updated when available
        "description": "EmbeddingGemma 308M for text embeddings"
    },
    "gemma-2b-it": {
        "filename": "gemma-2b-it.tflite", 
        "huggingface_repo": "google/gemma-2b-it",
        "expected_size": 2_500_000_000,  # ~2.5GB
        "sha256": None,
        "description": "Gemma 2B Instruction-Tuned for text generation"
    }
}

def download_from_huggingface(repo_id: str, filename: str, target_path: str):
    """Download model from Hugging Face Hub"""
    print(f"🔽 Downloading {filename} from {repo_id}...")
    
    try:
        # Using huggingface_hub library (install with: pip install huggingface_hub)
        from huggingface_hub import hf_hub_download
        
        downloaded_path = hf_hub_download(
            repo_id=repo_id,
            filename=filename,
            cache_dir="./cache",
            local_dir_use_symlinks=False
        )
        
        # Move to target location
        os.makedirs(os.path.dirname(target_path), exist_ok=True)
        subprocess.run(["cp", downloaded_path, target_path], check=True)
        print(f"✅ Downloaded {filename} successfully")
        return True
        
    except ImportError:
        print("❌ huggingface_hub not installed. Install with: pip install huggingface_hub")
        return False
    except Exception as e:
        print(f"❌ Download failed: {e}")
        return False

def download_direct_url(url: str, target_path: str, expected_size: int):
    """Download model from direct URL with progress"""
    print(f"🔽 Downloading from {url}...")
    
    try:
        response = requests.get(url, stream=True)
        response.raise_for_status()
        
        os.makedirs(os.path.dirname(target_path), exist_ok=True)
        
        total_size = int(response.headers.get('content-length', 0))
        downloaded_size = 0
        
        with open(target_path, 'wb') as f:
            for chunk in response.iter_content(chunk_size=8192):
                if chunk:
                    f.write(chunk)
                    downloaded_size += len(chunk)
                    
                    if total_size > 0:
                        progress = (downloaded_size / total_size) * 100
                        print(f"\r📊 Progress: {progress:.1f}%", end="", flush=True)
        
        print(f"\n✅ Downloaded successfully ({downloaded_size:,} bytes)")
        return True
        
    except Exception as e:
        print(f"❌ Download failed: {e}")
        return False

def verify_model(file_path: str, expected_size: int, sha256_hash: str = None):
    """Verify downloaded model integrity"""
    if not os.path.exists(file_path):
        return False
    
    file_size = os.path.getsize(file_path)
    print(f"📏 File size: {file_size:,} bytes (expected: {expected_size:,})")
    
    # Size check with 10% tolerance
    size_ratio = file_size / expected_size
    if size_ratio < 0.9 or size_ratio > 1.1:
        print(f"⚠️  File size unexpected (ratio: {size_ratio:.2f})")
        return False
    
    # SHA256 verification if provided
    if sha256_hash:
        print("🔍 Verifying file integrity...")
        actual_hash = hashlib.sha256()
        with open(file_path, 'rb') as f:
            for chunk in iter(lambda: f.read(4096), b""):
                actual_hash.update(chunk)
        
        if actual_hash.hexdigest() != sha256_hash:
            print(f"❌ SHA256 mismatch!")
            return False
    
    print("✅ Model verification passed")
    return True

def main():
    """Download all required TFLite models"""
    print("🏥 DGTL Healthcare - TFLite Model Downloader")
    print("=" * 50)
    
    assets_dir = Path(__file__).parent.parent / "assets" / "models"
    assets_dir.mkdir(parents=True, exist_ok=True)
    
    for model_name, config in MODELS.items():
        print(f"\n📦 Processing {config['description']}...")
        target_path = assets_dir / config['filename']
        
        # Skip if already exists and valid
        if verify_model(str(target_path), config['expected_size'], config.get('sha256')):
            print(f"✅ {config['filename']} already exists and is valid")
            continue
        
        # Try Hugging Face download first
        success = download_from_huggingface(
            config['huggingface_repo'],
            config['filename'], 
            str(target_path)
        )
        
        if success:
            verify_model(str(target_path), config['expected_size'], config.get('sha256'))
        else:
            print(f"⚠️  Could not download {config['filename']} automatically")
            print(f"   Manual download required from: https://huggingface.co/{config['huggingface_repo']}")
    
    print("\n🎉 Model download process complete!")
    print("\n💡 Next steps:")
    print("   1. Verify models are working with: flutter test test/experimental/test_embedding_gemma.dart")
    print("   2. Run the app to test AI functionality")

if __name__ == "__main__":
    main()
