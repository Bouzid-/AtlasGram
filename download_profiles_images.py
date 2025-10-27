#!/usr/bin/env python3
"""
Profile Image Downloader - Python Version
Downloads 20 profile images from Unsplash API
"""

import os
import sys
import json
import requests
import time
from pathlib import Path

# Configuration
ACCESS_KEY = "igMYkMHqvrVd3AfbaB6AOWhSX87FRmGSDHj2b70uHRo"  # Replace with your actual key
PROFILES_DIR = "insta-clone/Assets.xcassets/Profiles"
BASE_URL = "https://api.unsplash.com"

def check_requirements():
    """Check if all requirements are met"""
    if ACCESS_KEY == "YOUR_UNSPLASH_ACCESS_KEY_HERE":
        print("❌ Please set your Unsplash Access Key in the script")
        print("Get one at: https://unsplash.com/developers")
        return False
    
    if not os.path.exists(PROFILES_DIR):
        print(f"❌ Profiles directory not found: {PROFILES_DIR}")
        return False
        
    try:
        import requests
    except ImportError:
        print("❌ Please install requests: pip install requests")
        return False
    
    return True

def get_random_portrait():
    """Get a random portrait photo from Unsplash"""
    params = {
        'client_id': ACCESS_KEY,
        'query': 'portrait person face headshot',
        'orientation': 'portrait',
        'w': 400,
        'h': 400,
        'content_filter': 'high'  # High quality images only
    }
    
    try:
        response = requests.get(f"{BASE_URL}/photos/random", params=params, timeout=10)
        response.raise_for_status()
        data = response.json()
        return data.get('urls', {}).get('small')
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

def find_existing_image(user_dir):
    """Find existing image file in user directory"""
    image_extensions = ['.jpg', '.jpeg', '.png']
    for ext in image_extensions:
        for file in Path(user_dir).glob(f"*{ext}"):
            return str(file)
    return None

def replace_profile_image(user_num):
    """Replace profile image for a specific user"""
    print(f"📥 Downloading user_{user_num} profile image...")
    
    # Get random portrait from Unsplash
    image_url = get_random_portrait()
    if not image_url:
        print(f"❌ Failed to get image URL for user_{user_num}")
        return False
    
    # Prepare paths
    user_dir = os.path.join(PROFILES_DIR, f"user_{user_num}.imageset")
    if not os.path.exists(user_dir):
        print(f"⚠️  Directory not found: {user_dir}")
        return False
    
    # Find existing image file
    existing_image = find_existing_image(user_dir)
    
    # Download to temporary file
    temp_file = f"/tmp/user_{user_num}.jpg"
    if not download_image(image_url, temp_file):
        return False
    
    # Replace existing image or create new one
    if existing_image:
        os.replace(temp_file, existing_image)
        print(f"✅ Successfully replaced user_{user_num} profile image")
    else:
        new_path = os.path.join(user_dir, f"user_{user_num}.jpg")
        os.replace(temp_file, new_path)
        print(f"✅ Created new user_{user_num} profile image")
    
    return True

def main():
    """Main function"""
    print("🚀 Starting profile image download from Unsplash...")
    print(f"📁 Target directory: {PROFILES_DIR}")
    
    if not check_requirements():
        sys.exit(1)
    
    success_count = 0
    
    # Download 20 profile images
    for i in range(1, 21):
        if replace_profile_image(i):
            success_count += 1
        
        # Rate limiting - wait between requests
        if i < 20:  # Don't wait after the last request
            time.sleep(1.2)  # Slightly longer delay for reliability
    
    print()
    print("🎉 Profile image download complete!")
    print("📋 Summary:")
    print(f"   - Successfully downloaded {success_count}/20 profile images")
    print("   - Replaced existing user_1 to user_20 images")
    print("   - Images are square format (400x400px)")
    print("   - All images are portrait photos of people")

if __name__ == "__main__":
    main()