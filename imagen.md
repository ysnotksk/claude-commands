---
description: "Generate images using Google Cloud Imagen 4.0"
argument-hint: "<prompt description>"
allowed-tools: [Bash, Read]
---

# imagen

Generate images using Google Cloud's Imagen 4.0 API.

**Input**: $ARGUMENTS

## Instructions

Use the `imagen` CLI at `~/.local/bin/imagen` to generate images.

**Usage:** `imagen [OPTIONS] "PROMPT"`

**Options:**
- `-n COUNT` — Number of images to generate (1-4, default: 1)
- `-a RATIO` — Aspect ratio: `1:1`, `3:4`, `4:3`, `16:9`, `9:16` (default: `1:1`)
- `-o DIR` — Output directory (default: `$HOME`)

**Steps:**
1. Craft a detailed English prompt based on the user's request. Add descriptive details (lighting, style, composition) to improve quality.
2. Choose an appropriate aspect ratio based on the subject (e.g., `16:9` for landscapes, `9:16` for portraits, `1:1` for icons/avatars).
3. Run the command via Bash: `~/.local/bin/imagen -a RATIO "PROMPT"`
4. Read the saved PNG file to display it to the user.
5. Tell the user the saved file path.

**Cost:** ~$0.02 per image (~3 JPY). Mention this if the user generates many images.

**Example:**
```bash
~/.local/bin/imagen -a 16:9 -n 2 "A sunset over Tokyo, vibrant orange and purple sky, silhouette of Tokyo Tower"
```
