#!/usr/bin/env python3
"""
Posts Image Downloader - Python Version
Downloads beautiful portrait images for Instagram posts
"""

import os
import sys
import json
import requests
import time
from pathlib import Path

# Configuration
ACCESS_KEY = "igMYkMHqvrVd3AfbaB6AOWhSX87FRmGSDHj2b70uHRo"  # Replace with your actual key
POSTS_DIR = "insta-clone/Assets.xcassets/Posts"
BASE_URL = "https://api.unsplash.com"

def check_requirements():
    """Check if all requirements are met"""
    if ACCESS_KEY == "YOUR_UNSPLASH_ACCESS_KEY_HERE":
        print("❌ Please set your Unsplash Access Key in the script")
        print("Get one at: https://unsplash.com/developers")
        return False
    
    if not os.path.exists(POSTS_DIR):
        print(f"❌ Posts directory not found: {POSTS_DIR}")
        return False
        
    try:
        import requests
    except ImportError:
        print("❌ Please install requests: pip install requests")
        return False
    
    return True

def get_beautiful_portrait():
    """Get a beautiful portrait/lifestyle photo from Unsplash"""
    # Rotate through different queries for variety
    queries = [
        'beautiful portrait lifestyle',
        'fashion portrait model',
        'natural beauty portrait',
        'lifestyle photography woman',
        'aesthetic portrait girl',
        'elegant portrait photography',
        'artistic portrait beautiful',
        'lifestyle model portrait',
        'natural light portrait',
        'beautiful woman photography'
    ]
    
    # Select query based on current time for variety
    query = queries[int(time.time()) % len(queries)]
    
    params = {
        'client_id': ACCESS_KEY,
        'query': query,
        'orientation': 'portrait',
        'w': 500,
        'h': 700,
        'content_filter': 'high',  # High quality images only
        'order_by': 'popular'      # Get popular images
    }
    
    try:
        response = requests.get(f"{BASE_URL}/photos/random", params=params, timeout=10)
        response.raise_for_status()
        data = response.json()
        return data.get('urls', {}).get('regular')  # Use regular size for better quality
    except requests.RequestException as e:
        print(f"❌ API request failed: {e}")
        return None

def download_image(url, filepath):
    """Download image from URL to filepath"""
    try:
        response = requests.get(url, timeout=15)
        response.raise_for_status()
        
        with open(filepath, 'wb') as f:
            f.write(response.content)
        return True
    except requests.RequestException as e:
        print(f"❌ Download failed: {e}")
        return False

def find_existing_image(post_dir):
    """Find existing image file in post directory"""
    image_extensions = ['.jpg', '.jpeg', '.png']
    for ext in image_extensions:
        for file in Path(post_dir).glob(f"*{ext}"):
            return str(file)
    return None

def get_post_count():
    """Count how many post directories exist"""
    if not os.path.exists(POSTS_DIR):
        return 0
    
    count = 0
    for item in os.listdir(POSTS_DIR):
        if item.startswith('post_') and item.endswith('.imageset') and os.path.isdir(os.path.join(POSTS_DIR, item)):
            count += 1
    
    return count

def replace_post_image(post_num):
    """Replace post image for a specific post"""
    print(f"📥 Downloading post_{post_num} beautiful image...")
    
    # Get beautiful portrait from Unsplash
    image_url = get_beautiful_portrait()
    if not image_url:
        print(f"❌ Failed to get image URL for post_{post_num}")
        return False
    
    # Prepare paths
    post_dir = os.path.join(POSTS_DIR, f"post_{post_num}.imageset")
    if not os.path.exists(post_dir):
        print(f"⚠️  Directory not found: {post_dir}")
        return False
    
    # Find existing image file
    existing_image = find_existing_image(post_dir)
    
    # Download to temporary file
    temp_file = f"/tmp/post_{post_num}.jpg"
    if not download_image(image_url, temp_file):
        return False
    
    # Replace existing image or create new one
    if existing_image:
        os.replace(temp_file, existing_image)
        print(f"✅ Successfully replaced post_{post_num} image")
    else:
        new_path = os.path.join(post_dir, f"post_{post_num}.jpg")
        os.replace(temp_file, new_path)
        print(f"✅ Created new post_{post_num} image")
    
    return True

def main():
    """Main function"""
    print("🚀 Starting posts image download from Unsplash...")
    print(f"📁 Target directory: {POSTS_DIR}")
    
    if not check_requirements():
        sys.exit(1)
    
    # Count existing post directories
    post_count = get_post_count()
    if post_count == 0:
        print("❌ No post directories found!")
        sys.exit(1)
    
    print(f"📊 Found {post_count} post directories to update")
    
    success_count = 0
    
    # Download images for all posts
    for i in range(1, post_count + 1):
        if replace_post_image(i):
            success_count += 1
        
        # Rate limiting - wait between requests
        if i < post_count:  # Don't wait after the last request
            time.sleep(1.5)  # Slightly longer delay for reliability
    
    print()
    print("🎉 Posts image download complete!")
    print("📋 Summary:")
    print(f"   - Successfully downloaded {success_count}/{post_count} post images")
    print(f"   - Replaced existing post_1 to post_{post_count} images")
    print("   - Images are portrait format (minimum 500x700px)")
    print("   - All images are beautiful lifestyle/portrait photos")
    print()
    print("💡 Next steps:")
    print("   1. Open your Xcode project")
    print("   2. Clean build folder (Cmd+Shift+K)")
    print("   3. Run the app to see new beautiful post images!")

if __name__ == "__main__":
    main()