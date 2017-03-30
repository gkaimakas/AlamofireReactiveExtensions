# AlamofireReactiveExtensions

Want to use ReactiveSwift with Alamofire? AlamofireReactiveExtensions has you covered. It provides a list of extensions that bridge Alamofire's callbacks with ReactiveSwift's SignalProducers. You can even easily apply ReactiveSwift's operators to your responses, combine multiple requests or execute requests consecutively.'

The project currently provides extensions for:
1. `SessionManager`
2. `DataRequest`
3. `DownloadRequest` 
4. `UploadRequest`

For requests `AlamofireReactiveExtensions` provides the following functions:
1. `request(queue:)`
2. `request(queue:,responseSerializer)`
3. `responseData(queue:)`
4. `responseString(queue:, encoding:)`
5. `responseJSON(queue:s options:)`
6. `responsePropertyList(queue:, options:)`

SessionManager supports the following functions:
1. `request(_:, method:, parameters:, encoding:, headers:)`
2. `request(_:)`
3. `download(_:, method:, parameters:, encoding:, headers:, to)`
4. `download(_:, to:)`
5. `download(resumingWith:, to:)`
6. `upload(_:, to:, method:, headers:)`
7. `upload(_:, with:)`
8. `upload(_:, to:, method:, headers: )`
9. `upload(_:, with:)`
10. `upload(_:, to:, method:, headers:)`
11. `stream(withHostName:, port:)`

### Installation

`AlamofireReactiveExtensions` is available through `CocoaPods`

````
pod 'AlamofireReactiveExtensions'
````



### Usage
`ReactiveSwift` extensions are located behind the `reactive` property that is available in `SessionManager`, `DataRequest`, `DownloadRequest`, `UploadRequest`.

You can use `reactive` with a `SessionManager`
````
SessionManager.
.default
.reactive
.request("your url goes here")
.responseString()
.map{ $0.value }
.startWithValues { print( $0 ?? "") }
````

or if you use the shortcuts available in `Alamofire` you can use it immediately on a request:
````
Alamofire.request("your url goes here")
.reactive
.responseString()
.map{ $0.value }
.startWithValyes { print( $0 ?? "" ) }
````

Each `SignalProducer` returned from `AlamofireReactiveExtensions` cannot fail since the callbacks in `Alamofire` do not return errors. The convertion of the `NoError` response producer to a producer that can fail is left to the user.

