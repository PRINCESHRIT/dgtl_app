# Security Setup for HuggingFace Authentication

## Overview
This project now uses secure environment-based authentication for HuggingFace model access, replacing hardcoded tokens for enhanced security.

## Setup Instructions

### 1. Environment Configuration
Copy the example environment file:
```bash
cp .env.example .env
```

Edit `.env` and add your actual HuggingFace token:
```bash
# .env
HF_TOKEN=hf_your_actual_token_here
```

### 2. Token Security
- The `.env` file is automatically ignored by git (see `.gitignore`)
- Never commit tokens to version control
- Use environment variables in production: `export HF_TOKEN=your_token`

### 3. Authentication Files
- `hf_auth_utils.py`: Secure authentication utilities
- `simple_official_test.py`: Updated to use secure token access
- All Python scripts now use environment-based authentication

### 4. Testing Authentication
Test if your setup is working:
```bash
python3 hf_auth_utils.py
```

### 5. Dart Integration
The Dart `HybridEmbeddingService` no longer contains hardcoded tokens. 
Authentication is handled by the Python utility which reads from environment variables.

## Migration from Hardcoded Tokens

All files have been updated to remove hardcoded tokens:
- ✅ `simple_official_test.py` - uses `hf_auth_utils.get_hf_token()`
- ✅ `embeddings_api.py` - uses `hf_auth_utils.get_hf_token()`
- ✅ `test_embedding_direct.py` - uses `hf_auth_utils.get_hf_token()`
- ✅ `lib/core/ai/hybrid_embedding_service.dart` - removed hardcoded token
- ✅ `PHASE_1_4_AUTHENTICATED_STATUS.md` - token redacted

## Production Deployment

For production environments:
1. Set environment variable: `export HF_TOKEN=your_production_token`
2. Remove `.env` file from production servers
3. Use container secrets or cloud provider secret management
4. Never log or expose tokens in application output

## Security Benefits

1. **No tokens in source code**: All authentication moved to environment
2. **Git safety**: `.env` files are ignored by version control  
3. **Environment flexibility**: Different tokens for dev/staging/prod
4. **Audit trail**: Token usage centralized in `hf_auth_utils.py`
5. **Fallback protection**: System gracefully handles authentication failures

## Troubleshooting

If authentication fails:
1. Check if `.env` file exists and contains valid token
2. Verify token has access to `google/embeddinggemma-300m` model
3. Test with: `python3 hf_auth_utils.py`
4. System will automatically fall back to local embeddings if needed

