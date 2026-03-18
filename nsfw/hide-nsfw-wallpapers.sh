#!/bin/bash

# Script lives inside NSFW
FOLDER="./"  # current folder

echo "🔎 Checking files in $FOLDER ..."

# Counters
total=0
hidden_count=0
already_hidden=0
skipped_count=0

for FILE in "$FOLDER"/*; do
    BASENAME=$(basename "$FILE")
    
    # Skip directories
    [[ -d "$FILE" ]] && continue
    
    ((total++))
    
    # Skip this script or any .sh files
    [[ "$BASENAME" == *.sh ]] && { 
        echo "⏭ Skipping script file: $BASENAME"; 
        ((skipped_count++)); 
        continue; 
    }
    
    if [[ "$BASENAME" == .* ]]; then
        echo "✅ Already hidden: $BASENAME"
        ((already_hidden++))
        continue
    fi
    
    # Hide the file
    mv "$FILE" "$FOLDER/.$BASENAME"
    echo "🕶 Hid file: $BASENAME → .$BASENAME"
    ((hidden_count++))
done

echo "--------------------------------"
echo "Total files checked: $total"
echo "Files already hidden: $already_hidden"
echo "Files just hidden: $hidden_count"
echo "Files skipped (.sh): $skipped_count"
echo "✅ Done!"
