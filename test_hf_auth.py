#!/usr/bin/env python3
"""
Test Hugging Face authentication and EmbeddingGemma model access
"""
import os
from huggingface_hub import HfApi, login

def test_authentication():
    """Test HF authentication and model access"""
    print("🔐 Hugging Face Authentication Test")
    print("=" * 50)
    
    # Prompt for token if not set
    token = os.getenv('HF_TOKEN')
    if not token:
        print("Enter your Hugging Face token:")
        token = input().strip()
    
    try:
        # Login with token
        login(token=token)
        print("✅ Authentication successful!")
        
        # Test API access
        api = HfApi()
        user = api.whoami()
        print(f"✅ Authenticated as: {user['name']}")
        
        # Test model access
        repo_id = "google/embeddinggemma-300m"
        print(f"\n📋 Testing access to {repo_id}")
        
        try:
            model_info = api.model_info(repo_id)
            print(f"✅ Model access successful!")
            print(f"Model tags: {model_info.tags}")
            print(f"Model size: {model_info.safetensors}")
            
            return True
            
        except Exception as e:
            print(f"❌ Model access failed: {e}")
            print("Make sure you've accepted the terms at: https://huggingface.co/google/embeddinggemma-300m")
            return False
            
    except Exception as e:
        print(f"❌ Authentication failed: {e}")
        return False

if __name__ == "__main__":
    success = test_authentication()
    if success:
        print("\n🎉 Ready to download EmbeddingGemma model!")
    else:
        print("\n❌ Please check your token and model access")
