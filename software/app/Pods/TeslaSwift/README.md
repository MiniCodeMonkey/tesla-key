[![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://swift.org)
[![Build Status](https://travis-ci.org/jonasman/TeslaSwift.svg?branch=master)](https://travis-ci.org/jonasman/TeslaSwift)
[![TeslaSwift](https://img.shields.io/cocoapods/v/TeslaSwift.svg)]()
# TeslaSwift
Swift library to access the Tesla Model S API based on [Unofficial Tesla Model S API](http://docs.timdorr.apiary.io/#)

Installation
============

####Manual

Copy `Sources` folder into your project

####CocoaPods
```ruby
	pod 'TeslaSwift', '~> 3.0'
```
####Swift Package Manager
You can use [Swift Package Manager](https://swift.org/package-manager/) and specify a dependency in `Package.swift` by adding this:
```swift
.Package(url: "https://github.com/jonasman/TeslaSwift.git", majorVersion: 3)
```

Usage
============
Import the module
```swift
	import TeslaSwift
```

Perform an authentication with your My Tesla credentials: 
```swift 
let api = TeslaSwift()
api.authenticate(email: email, password: password)
```
Use the promise to check the success: 
```swift 
.then { (result) -> Void in
	
	//LogedIn!
	
}.catch { (error) in 
	print("Error: \(error as NSError)")			
}
```


Example
===========
```swift

class ViewController {

  func showCars() {

    api.getVehicles()
		.then { (response) -> Void in
			
			self.data = response
			self.tableView.reloadData()
			
		}.catch { (error) in
			//Process error
   }
}
```    

Options
============
You can use the mock server by setting: `api.useMockServer = true`

You can enable debugging by setting: `api.debuggingEnabled = true`

Other Features
============
After the authentication is done. The library manages itself the access token. 
When the token expires the library will perform another authentication with your past credentials.

Roadmap
============
3.x
Add new API features and summon

Licence
============
        
The MIT License (MIT)

Copyright (c) 2016 João Nunes

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
