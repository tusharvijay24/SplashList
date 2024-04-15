This iOS application allows users to browse and view images fetched from the Unsplash API. The app efficiently loads and caches images for a smooth user experience.

Prerequisites
Before running the application, ensure you have the following installed:
* Xcode 15.3
* Swift 5
* Internet connection to fetch images from the Unsplash API
* Open the Image Viewer.xcodeproj file in Xcode.
* Build and run the project using the Xcode simulator or connect your iOS device and run the app directly. 
Usage
Upon launching the app, you will be presented with a grid of images fetched from the Unsplash API. You can perform the following actions:
* Scroll vertically to browse through the images.
* Pull down to refresh the content and fetch new images.
* Scroll to the bottom to automatically load more images as you reach the end of the current list.
Features
* Asynchronous image loading from the Unsplash API.
* Caching mechanism to store images in memory and disk cache for efficient retrieval.
* Graceful error handling for network errors and image loading failures.
* Dynamic layout adjusts based on the device screen size and orientation.
