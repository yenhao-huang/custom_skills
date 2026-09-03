# iPhone Photo Search Survey Snapshot

Snapshot date: 2026-02-24. Verify current product capabilities, repository
activity, pricing, and popularity before using this reference for a present-day
recommendation.

## Personal Project

- Workspace: `~/Desktop/apple_query_any_img`
- Goal: private semantic search over the iPhone photo library
- Proposed stack: ColNomic embeddings, Qdrant vector search, Swift/iOS Photos
  integration

## Commercial Baselines

- Apple Photos: on-device classification, OCR, faces, scenes, and system-level
  integration; limited model customization.
- Google Photos: strong cloud-backed natural-language search and cross-device
  support, with cloud-upload privacy tradeoffs.
- Amazon Photos: cloud photo storage with basic object and face search.

## Open-source Baselines

- Queryable: offline iOS semantic search using CLIP or MobileCLIP; the closest
  product-shaped baseline for local photo-library search.
- CLIP-Finder2: native iOS and Core ML semantic photo search.
- Immich: self-hosted photo management with CLIP search, PostgreSQL/pgvector,
  face recognition, and mobile apps.
- PhotoPrism: self-hosted photo management focused on classification, faces,
  and metadata.
- photo-similarity-search: Apple Silicon, MLX, and CLIP in a Python web app.
- PicQuery: offline Android CLIP search with multilingual relevance.
- Ente: encrypted photo backup with device-side ML features.

## Vector Search Options

- Qdrant: supports HNSW, quantization, and multi-vector retrieval; fits the
  current project direction.
- Pinecone: managed cloud service with operational simplicity and external
  storage/privacy tradeoffs.
- Milvus: scalable open-source vector database with a heavier operational
  footprint.

## Differentiation Hypothesis

The project may differentiate through newer multimodal embeddings, efficient
vector indexing, local or self-hosted privacy, and native iPhone photo-library
integration. Validate this hypothesis against current products before making a
market claim.

## Dated Tool Candidates

- `apple-docs-mcp`: Apple documentation and WWDC search
- `Claude-Project-Coordinator`: multi-project Xcode coordination; verify Codex
  support before use
- `swift-patterns-mcp` and `swift-mcp`: Swift and SwiftUI guidance
- `ios-preview-mcp`: SwiftUI build and screenshot workflows; verify Codex
  support before use
- `instruments-mcp-server`: Instruments profiling
- `McpSwitcher` and `mcpmate/desktop`: local MCP configuration management

Candidate URLs:

- `https://github.com/kimsungwhee/apple-docs-mcp`
- `https://github.com/M-Pineapple/Claude-Project-Coordinator`
- `https://github.com/efremidze/swift-patterns-mcp`
- `https://github.com/onmyway133/swift-mcp`
- `https://github.com/noahzs/ios-preview-mcp`
- `https://github.com/nemanjavlahovic/instruments-mcp-server`
