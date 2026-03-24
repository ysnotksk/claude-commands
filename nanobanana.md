---
description: "Generate images using Google Gemini"
argument-hint: "<prompt description>"
allowed-tools: [Bash, Read]
---

# nanobanana

Generate images using Google's Gemini image generation API (`gemini-2.5-flash-image`).

**Input**: $ARGUMENTS

## Instructions

Use the `nanobanana` CLI at `~/.local/bin/nanobanana` to generate images.

**Usage:** `nanobanana [OPTIONS] "PROMPT"`

**Options:**
- `-n COUNT` — Number of images to generate (1-4, default: 1)
- `-a RATIO` — Aspect ratio: `1:1`, `3:4`, `4:3`, `16:9`, `9:16` (default: `1:1`)
- `-o DIR` — Output directory (default: `$HOME`)

**Steps:**
1. Craft a detailed English prompt based on the user's request. Add descriptive details (lighting, style, composition) to improve quality.
2. Choose an appropriate aspect ratio based on the subject (e.g., `16:9` for landscapes, `9:16` for portraits, `1:1` for icons/avatars).
3. Run the command via Bash: `~/.local/bin/nanobanana -o . -a RATIO "PROMPT"`
4. Read the saved PNG file to display it to the user.
5. Tell the user the saved file path.

**Example:**
```bash
source ~/.env_common && ~/.local/bin/nanobanana -o . -a 16:9 -n 2 "A sunset over Tokyo, vibrant orange and purple sky, silhouette of Tokyo Tower"
```
