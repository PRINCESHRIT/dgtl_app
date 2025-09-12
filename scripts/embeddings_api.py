#!/usr/bin/env python3
"""
Lightweight EmbeddingGemma API for Dart integration
Uses huggingface_hub directly without heavy dependencies
"""
import json
import sys
from huggingface_hub import login, InferenceClient

# Your authenticated token
from hf_auth_utils import get_hf_token
HF_TOKEN = get_hf_token()

def initialize_client():
    """Initialize Hugging Face client with authentication"""
    login(token=HF_TOKEN, write_permission=False)
    return InferenceClient(model="google/embeddinggemma-300m", token=HF_TOKEN)

def generate_embedding(text, prompt_template="task: search result | query:"):
    """Generate embedding for a single text"""
    try:
        client = initialize_client()
        
        # Apply medical prompt template
        prompted_text = f"{prompt_template} {text}"
        
        # Use Hugging Face Inference API
        result = client.feature_extraction(prompted_text)
        
        # Convert to list if needed
        if isinstance(result, list):
            return result
        else:
            return result.tolist() if hasattr(result, 'tolist') else list(result)
            
    except Exception as e:
        print(f"ERROR: {e}", file=sys.stderr)
        return None

def generate_batch_embeddings(texts, prompt_template="task: search result | query:"):
    """Generate embeddings for multiple texts"""
    try:
        client = initialize_client()
        
        embeddings = []
        for text in texts:
            prompted_text = f"{prompt_template} {text}"
            result = client.feature_extraction(prompted_text)
            
            if isinstance(result, list):
                embeddings.append(result)
            else:
                embeddings.append(result.tolist() if hasattr(result, 'tolist') else list(result))
        
        return embeddings
        
    except Exception as e:
        print(f"ERROR: {e}", file=sys.stderr)
        return None

def main():
    """Main CLI interface for Dart integration"""
    if len(sys.argv) < 2:
        print("Usage: python3 embeddings_api.py <command> [args...]")
        print("Commands:")
        print("  single <text> - Generate embedding for single text")
        print("  batch <json_array> - Generate embeddings for array of texts")
        return
    
    command = sys.argv[1]
    
    if command == "single" and len(sys.argv) >= 3:
        text = sys.argv[2]
        embedding = generate_embedding(text)
        if embedding:
            print(json.dumps(embedding))
        else:
            sys.exit(1)
            
    elif command == "batch" and len(sys.argv) >= 3:
        try:
            texts = json.loads(sys.argv[2])
            embeddings = generate_batch_embeddings(texts)
            if embeddings:
                print(json.dumps(embeddings))
            else:
                sys.exit(1)
        except json.JSONDecodeError as e:
            print(f"ERROR: Invalid JSON: {e}", file=sys.stderr)
            sys.exit(1)
            
    elif command == "test":
        # Quick test
        print("🧪 Testing EmbeddingGemma API", file=sys.stderr)
        test_text = "Patient has high blood pressure"
        embedding = generate_embedding(test_text)
        if embedding:
            print(f"✅ Success! Generated {len(embedding)}D embedding", file=sys.stderr)
            print(json.dumps(embedding[:5]))  # First 5 values
        else:
            print("❌ Test failed", file=sys.stderr)
            sys.exit(1)
    else:
        print("Invalid command or arguments", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
