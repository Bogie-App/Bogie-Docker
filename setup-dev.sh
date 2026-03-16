#!/bin/bash
set -e


# clone all repos
repos=("Bogie-Api")
for r in "${repos[@]}"; do
  if [ ! -d "$r" ]; then
    git clone https://github.com/Bogie-App/$r.git "$r"
  else
    echo "$r exists, pulling latest..."
    git -C "$r" pull
  fi
done

# dev branch checkout
git -C Bogie-Api checkout dev || true

# build local images
docker build -t api:dev ./Bogie-Api

echo "✅ Dev environment ready"