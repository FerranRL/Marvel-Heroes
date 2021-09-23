# Marvel Heroes
Marvel Heroes is an App that accesses the Marvel character catalog and shows us the details of each of the characters.

# Requirements 📋

In order to run the project it is necessary to execute "pod install" in the project directory to install the dependencies. If you do not have cocoapods installed, you can install it by following the instructions on this page: https://cocoapods.org/.

# Installation 🔧
Open the Marvel Heroes.xcworkspace file in Xcode for everything to work properly. Otherwise the Pod dependencies would not work.

It is necessary to add the public and private keys of the Marvel API, since for security reasons these are not included in the project.

To add the keys, you must go to current Scheme and fill the Environment Variables "MARVEL_PRIVATE_KEY" and "MARVEL_PUBLIC_KEY" by the corresponding keys. Keys can be obtained by registering on the page “https://developer.marvel.com/".

# Project Info 🛠️
- Xcode 12.5 
- Swift 5.3 
- Architecture MVVM 
- Swift Package Manager 
- Cocoapods 

# Screenshots

![image](https://user-images.githubusercontent.com/43423120/134497280-e0f9a37b-84b1-45db-ba5b-bfc1dc598750.png)



# Third party packages

The following packages have been used:

## Alamofire 5.4.3 

Incorporated through Swift Package Libraries. Specific library for Swift, which allows us to make requests to a web server fulfilling and exploiting all the capabilities of HTTP. Used for requests to the Marvel API.

## KingFisher 6.3.0

Incorporated through Swift Package Libraries. Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web. It provides you a chance to use a pure-Swift way to work with remote images in your next app. Used for get the images from the Marvel API.

## SwiftHash

Incorporated through Cocoapods. Library that allows us to do an MD5 encryption in requests to the Marvel API.

## Lottie

Incorporated through Cocoapods. Lottie is a library that renders After Effects animations in real time, and allows native apps to use animations as easily as they use static assets. Lottie uses animation data exported as JSON files from an open-source After Effects extension called Bodymovin.

