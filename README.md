# AtlasGram - Instagram Clone

A SwiftUI-based Instagram clone featuring real-time image loading, fullscreen post viewing, and smooth gesture navigation.

## Features

- 📱 Instagram-like UI with timeline, stories, and profile views
- 🖼️ Real-time image loading from Unsplash API
- 📄 Pagination support for infinite scrolling
- 🔍 Fullscreen post viewing with zoom transitions
- 👆 Gesture navigation (swipe up/down for posts, swipe right to dismiss)
- 🎨 Clean MVVM architecture with separated data providers

## Setup

### 1. Unsplash API Configuration

This app uses the Unsplash API to fetch high-quality images. To use the API service:

#### Get Your Access Token
1. Go to [Unsplash Developers](https://unsplash.com/developers)
2. Create a new application
3. Copy your **Access Key** (this is your token)

#### Configure the Token
1. Open `Data/UnsplashService.swift`
2. Replace the placeholder token with your actual access key:

```swift
private let accessKey = "YOUR_UNSPLASH_ACCESS_KEY_HERE"
```

⚠️ **Important**: Never commit your actual API key to version control. Consider using environment variables or a config file that's gitignored.

#### API Usage Examples
```swift
// Search for photos
let photos = await UnsplashService.shared.searchPhotos(query: "portrait", page: 1, perPage: 20)

// Get random photos
let randomPhotos = await UnsplashService.shared.getRandomPhotos(count: 10, query: "lifestyle")
```

### 2. Local Data Setup

The app includes fallback local data and scripts to download images for offline development.

#### Available Scripts

**Download Post Images**
```bash
python3 download_posts.py
```
This script downloads sample post images to `Assets.xcassets/Posts/`

**Download Profile Images**
```bash

python3 download_profiles.py
```
This script downloads sample profile images to `Assets.xcassets/Profiles/`

#### Script Requirements
```bash
# Install required Python packages
pip3 install requests pillow
```

### 3. Data Provider Configuration

The app can switch between API and local data sources:

```swift
// In DataProvider.swift
class DataProvider: ObservableObject {
    @Published var useLocalData = false  // Set to true for local-only mode
    
    // Toggle data source
    func toggleDataMode() {
       useLocalData.toggle()
        let mode = useLocalData ? "Local" : "API"
        print("🔄 Switched to \(mode) mode")
    }
}
```

## Architecture

### Core Components

- **DataProvider**: Main data management with API/local toggle and pagination
- **UnsplashService**: Handles all API communication with Unsplash
- **LocalPostProvider**: Generates mock posts for offline development
- **LocalUserProvider**: Provides sample user data
- **RemoteImage**: Smart image loading component with local/remote support

### Key Files

```
insta-clone/
├── Data/
│   ├── UnsplashService.swift       # API service
│   ├── DataProvider.swift          # Main data manager
│   ├── LocalPostProvider.swift     # Local post generation
│   ├── LocalUserProvider.swift     # Local user data
│   └── Scripts/                    # Python download scripts
├── Views/
│   ├── FullScreenPostView.swift    # Fullscreen post container
│   ├── RemoteImage.swift          # Smart image loading
│   └── PostView.swift             # Timeline post component
└── tabs/
    ├── TimeLine/                  # Timeline tab components
    ├── Profile/                   # Profile tab components
    └── Search/                    # Search tab components
```

## Development

### Running the App

1. Open `insta-clone.xcodeproj` in Xcode
2. Configure your Unsplash API token (see setup above)
3. Build and run on iOS Simulator or device

### Testing Different Data Sources

```swift
// Use API data (requires internet + token)
dataProvider.useLocalData = false

// Use local data (offline development)
dataProvider.useLocalData = true
```

### Adding New Mock Data

To add more local posts or users:

1. **Posts**: Modify `LocalPostProvider.swift`
2. **Users**: Modify `LocalUserProvider.swift`
3. **Images**: Run download scripts or add manually to Assets.xcassets

## Gestures & Navigation

- **Timeline**: Scroll vertically, tap posts to open fullscreen
- **Fullscreen Posts**: 
  - Swipe up/down to navigate between posts
  - Swipe right to dismiss and return to timeline
  - Tap to show/hide overlays

## API Rate Limits

Unsplash API has the following limits:
- **Demo**: 50 requests per hour
- **Production**: 5000 requests per hour

The app implements intelligent caching and falls back to local data when limits are reached.

## Troubleshooting

### Common Issues

**Images not loading**
- Check your Unsplash API token
- Verify internet connection
- Check API rate limits

**Gestures not working**
- Ensure you're using the latest code with simultaneousGesture fixes
- Check console for gesture debug logs

**Scripts failing**
- Install Python requirements: `pip3 install requests pillow`
- Check internet connection for downloads
- Verify write permissions in Assets.xcassets folder

### Debug Mode

Enable debug logging by setting:
```swift
// In UnsplashService.swift
private let debugMode = true
```

This will log all API requests and responses to the console.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with both API and local data
5. Submit a pull request

## License

This project is for educational purposes. Please respect Unsplash's API terms of service and image licenses.