#!/bin/bash
# TheNeuralVault-Market-Intelligence — Task Runner
# Usage: bash run-intelligence.sh
# Runs full intelligence sweep across all four verticals

TIMESTAMP=$(date +%Y-%m-%d-%H%M)
OUTPUT_FILE="intel/brief-${TIMESTAMP}.md"
MEMORY_FILE="memory/intelligence-log.md"

mkdir -p intel memory

echo "============================================"
echo "TheNeuralVault-Market-Intelligence"
echo "Starting intelligence sweep: $TIMESTAMP"
echo "============================================"

python3 intelligence.py "$OUTPUT_FILE"

echo ""
echo "Syncing to Google Drive..."
rclone copy intel/ NeuralVault:theneuralvault/intel/
rclone copy memory/ NeuralVault:theneuralvault/memory/market-intelligence/

echo "Logging run..."
echo "$(date) | Brief: $OUTPUT_FILE" >> "$MEMORY_FILE"

echo ""
echo "============================================"
echo "Intelligence sweep complete."
echo "Brief saved: $OUTPUT_FILE"
echo "Synced to Drive: NeuralVault:theneuralvault/intel/"
echo "============================================"
