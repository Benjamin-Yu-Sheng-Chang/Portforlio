#!/usr/bin/env bash
# Regenerates notes-index.json from the notes/ folder.
# Run from the repo root:  ./generate-notes-index.sh
set -euo pipefail
cd "$(dirname "$0")"

python3 - <<'EOF'
import json, os, time

entries = []
for name in sorted(os.listdir("notes")):
    path = os.path.join("notes", name)
    if name.startswith(".") or not os.path.isfile(path):
        continue
    entries.append({
        "name": name,
        "date": time.strftime("%Y-%m-%d", time.localtime(os.path.getmtime(path))),
    })

with open("notes-index.json", "w") as f:
    json.dump({"notes": entries}, f, indent=2)
    f.write("\n")

print(f"wrote notes-index.json ({len(entries)} entries)")
EOF
