#!/usr/bin/env python3
"""
Secure Hugging Face authentication utilities
"""
import os
import sys
from huggingface_hub import login, hf_hub_download

def get_hf_token():
    """Get HF token from environment or .env file"""
    # First try environment variable
    token = os.getenv('HF_TOKEN')
    
    if not token:
        # Try to read from .env file
        try:
            with open('.env', 'r') as f:
                for line in f:
                    if line.strip().startswith('HF_TOKEN='):
                        token = line.strip().split('=', 1)[1]
                        break
        except FileNotFoundError:
            pass
    
    if not token or token == 'your_huggingface_token_here':
        raise ValueError("HF_TOKEN not found. Please set environment variable or create .env file")
    
    return token

def authenticate_hf():
    """Authenticate with Hugging Face"""
    try:
        token = get_hf_token()
        login(token=token, write_permission=False)
        return True
    except Exception as e:
        print(f"Authentication failed: {e}", file=sys.stderr)
        return False

def test_model_access(model_id="google/embeddinggemma-300m"):
    """Test if we can access the specified model"""
    try:
        if not authenticate_hf():
            return False
            
        config_path = hf_hub_download(repo_id=model_id, filename="config.json")
        print(f"SUCCESS: Model accessible at {config_path}", file=sys.stderr)
        return True
        
    except Exception as e:
        print(f"Model access failed: {e}", file=sys.stderr)
        return False

if __name__ == "__main__":
    if test_model_access():
        print("Authentication successful!")
    else:
        print("Authentication failed!")
        sys.exit(1)
