#!/bin/bash
set -e


# clone all repos
repos=("Bogie-Api" "Bogie-Database" "Bogie-ETL")
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
git -C Bogie-Database checkout dev || true
git -C Bogie-ETL checkout dev || true
git -C Bogie-JupyterNotebook checkout dev || true

# build local images
docker build -t api:dev ./Bogie-Api
docker build -t db:dev ./Bogie-Database
docker build -t etl:dev ./Bogie-ETL

echo "✅ Dev environment ready"