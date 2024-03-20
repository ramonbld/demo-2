#!/bin/bash

# Check if submodule name is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <submodule_name>"
    exit 1
fi

submodule_name=$1
submodule_path="submodules/$submodule_name"

# Fetch latest changes from the submodule's main branch
git submodule update --init --remote -- $submodule_path

# Check if there are any changes
if ! git diff --quiet --exit-code $submodule_path; then
    git config user.name "GitHub Actions"
    git config user.email "actions@github.com"
    # Commit the changes
    git add $submodule_path
    git commit -m "Update submodule $submodule_name"

    # Push the changes to the remote repository
    git push origin main
    echo "Submodule $submodule_name updated and pushed successfully."
else
    echo "No changes detected in submodule $submodule_name."
fi