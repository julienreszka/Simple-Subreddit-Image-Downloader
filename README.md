# Simple Subreddit Image Downloader

Tired of all of those reddit downloaders which want you to install tons of dependencies and then don't work anyway? Me too.

_Simple Subreddit Image Downloader_ is bash script which:

- downloads ALL images from specified subreddit in full size
- Linux/MacOS/Windows
- Parallel download

This script just downloads all directly linked images in subreddit. It can also download with a specific sort. For more complex usage, use other reddit image downloader.

# Requirements

- bash (cygwin is OK)
- curl
- jq

## Installation

```bash
brew install jq # MacOS

```

## Make it executable

```bash
chmod +x download-subreddit-images.sh
```

# Usage

```

Usage: ./download-subreddit-images.sh <subreddit_name> [hot|new|rising|top|controversial] [all|year|month|week|day] [limit]
Examples: ./download-subreddit-images.sh starterpacks new week 10
          ./download-subreddit-images.sh funny top all 50"
```

Script downloads images to `<subreddit_name>` folder in current directory. If you want to change that, you need to edit destination in rdit.sh for now.
