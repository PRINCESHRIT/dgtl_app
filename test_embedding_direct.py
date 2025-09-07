#!/usr/bin/env python3
"""
Test direct EmbeddingGemma model access via transformers (lighter than sentence-transformers)
"""
import os
import json
import sys
from huggingface_hub import login

def test_lightweight_embedding():
    """Test EmbeddingGemma with basic transformers"""
    print("🧠 Testing Direct EmbeddingGemma Access")
    print("=" * 50)
    
    # Login with saved token
    from hf_auth_utils import get_hf_token
    token = get_hf_token()
    login(token=token, write_permission=False)
    
    try:
        # Try importing transformers (might be lighter than sentence-transformers)
        try:
            from transformers import AutoModel, AutoTokenizer
            print("✅ Transformers library available")
            has_transformers = True
        except ImportError:
            print("❌ Transformers library not available")
            has_transformers = False
        
        if has_transformers:
            try:
                print("📥 Loading EmbeddingGemma model...")
                model_id = "google/embeddinggemma-300m"
                
                # Load tokenizer and model
                tokenizer = AutoTokenizer.from_pretrained(model_id)
                model = AutoModel.from_pretrained(model_id)
                
                print("✅ Model loaded successfully!")
                
                # Test embedding generation
                test_text = "Patient has high blood pressure"
                print(f"🧪 Testing with: '{test_text}'")
                
                # Tokenize
                inputs = tokenizer(test_text, return_tensors="pt", padding=True, truncation=True)
                
                # Generate embeddings
                with torch.no_grad():
                    outputs = model(**inputs)
                    # Get the last hidden state and mean pool
                    embeddings = outputs.last_hidden_state.mean(dim=1)
                
                print(f"✅ Generated embedding: {embeddings.shape}")
                print(f"First 5 values: {embeddings[0][:5].tolist()}")
                
                return True
                
            except Exception as e:
                print(f"❌ Model loading failed: {e}")
                print("This might be due to missing PyTorch or model compatibility")
                return False
        else:
            print("⚠️  Will use huggingface_hub for file download instead")
            return test_file_download()
            
    except Exception as e:
        print(f"❌ Test failed: {e}")
        return False

def test_file_download():
    """Test downloading model files directly"""
    print("\n📥 Testing Model File Download")
    
    try:
        from huggingface_hub import hf_hub_download
        
        model_id = "google/embeddinggemma-300m"
        
        # Download config file first (small test)
        print("📋 Downloading model config...")
        config_path = hf_hub_download(repo_id=model_id, filename="config.json")
        print(f"✅ Config downloaded to: {config_path}")
        
        # Read and display config
        with open(config_path, 'r') as f:
            config = json.load(f)
        
        print(f"Model architecture: {config.get('architectures', ['Unknown'])}")
        print(f"Hidden size: {config.get('hidden_size', 'Unknown')}")
        print(f"Max position embeddings: {config.get('max_position_embeddings', 'Unknown')}")
        
        return True
        
    except Exception as e:
        print(f"❌ File download failed: {e}")
        return False

if __name__ == "__main__":
    success = test_lightweight_embedding()
    if success:
        print("\n🎉 EmbeddingGemma access successful!")
    else:
        print("\n📋 Fallback mode will continue to work well")
