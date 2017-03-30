//
//  SessionManager+ReactiveSwift.swift
//  Pods
//
//  Created by George Kaimakas on 29/03/2017.
//
//

import Alamofire
import Foundation
import ReactiveSwift
import Result

extension SessionManager: ReactiveExtensionsProvider {}

public extension Reactive where Base: SessionManager {
    
    
    // MARK: - Data Request
    
    /// Creates a ``SignalProducer<DataRequest, NoError>` to retrieve the contents of the specified `url`, `method`, `parameters`, `encoding`
    /// and `headers`.
    ///
    /// - parameter url:        The URL.
    /// - parameter method:     The HTTP method. `.get` by default.
    /// - parameter parameters: The parameters. `nil` by default.
    /// - parameter encoding:   The parameter encoding. `URLEncoding.default` by default.
    /// - parameter headers:    The HTTP headers. `nil` by default.
    ///
    /// - returns: The created `SignalProducer<DataRequest, NoError>`.
    @discardableResult
    public func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil) -> SignalProducer<DataRequest, NoError> {
            
            return SignalProducer(value: self.base.request(url,
                                                           method: method,
                                                           parameters: parameters,
                                                           encoding: encoding,
                                                           headers: headers))
    }
    
    
    /// Creates a `SignalProducer<DataRequest, NoError>` to retrieve the contents of a URL based on the specified `urlRequest`.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter urlRequest: The URL request.
    ///
    /// - returns: The created `DataRequest`.
    @discardableResult
    public func request(_ urlRequest: URLRequestConvertible) -> SignalProducer<DataRequest, NoError> {
        return SignalProducer(value: self.base.request(urlRequest))
    }
    
    // MARK: - Download Request
    
    // MARK: URL Request
    
    /// Creates a `SignalProducer<DownloadRequest, NoError>` to retrieve the contents the specified `url`, `method`, `parameters`, `encoding`,
    /// `headers` and save them to the `destination`.
    ///
    /// If `destination` is not specified, the contents will remain in the temporary location determined by the
    /// underlying URL session.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter url:         The URL.
    /// - parameter method:      The HTTP method. `.get` by default.
    /// - parameter parameters:  The parameters. `nil` by default.
    /// - parameter encoding:    The parameter encoding. `URLEncoding.default` by default.
    /// - parameter headers:     The HTTP headers. `nil` by default.
    /// - parameter destination: The closure used to determine the destination of the downloaded file. `nil` by default.
    ///
    /// - returns: The created `SignalProducer<DownloadRequest, NoError>`.
    @discardableResult
    public func download(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        to destination: DownloadRequest.DownloadFileDestination? = nil) -> SignalProducer<DownloadRequest, NoError> {
            
            return SignalProducer(value: self.base.download(url,
                                                            method: method,
                                                            parameters: parameters,
                                                            encoding: encoding,
                                                            headers: headers,
                                                            to: destination))
    }
    
    
    /// Creates a `SignalProducer<DownloadRequest, NoError>` to retrieve the contents of a URL based on the specified `urlRequest` and save
    /// them to the `destination`.
    ///
    /// If `destination` is not specified, the contents will remain in the temporary location determined by the
    /// underlying URL session.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter urlRequest:  The URL request
    /// - parameter destination: The closure used to determine the destination of the downloaded file. `nil` by default.
    ///
    /// - returns: The created `SignalProducer<DownloadRequest, NoError>`.
    @discardableResult
    public func download(
        _ urlRequest: URLRequestConvertible,
        to destination: DownloadRequest.DownloadFileDestination? = nil) -> SignalProducer<DownloadRequest, NoError> {
            
            return SignalProducer(value: self.base.download(urlRequest,
                                                            to: destination))
    }
    
    
    // MARK: Resume Data
    
    /// Creates a `SignalProducer<DownloadRequest, NoError>` from the `resumeData` produced from a previous request cancellation to retrieve
    /// the contents of the original request and save them to the `destination`.
    ///
    /// If `destination` is not specified, the contents will remain in the temporary location determined by the
    /// underlying URL session.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// On the latest release of all the Apple platforms (iOS 10, macOS 10.12, tvOS 10, watchOS 3), `resumeData` is broken
    /// on background URL session configurations. There's an underlying bug in the `resumeData` generation logic where the
    /// data is written incorrectly and will always fail to resume the download. For more information about the bug and
    /// possible workarounds, please refer to the following Stack Overflow post:
    ///
    ///    - http://stackoverflow.com/a/39347461/1342462
    ///
    /// - parameter resumeData:  The resume data. This is an opaque data blob produced by `URLSessionDownloadTask`
    ///                          when a task is cancelled. See `URLSession -downloadTask(withResumeData:)` for
    ///                          additional information.
    /// - parameter destination: The closure used to determine the destination of the downloaded file. `nil` by default.
    ///
    /// - returns: The created `SignalProducer<DownloadRequest, NoError>`.
    @discardableResult
    public func download(
        resumingWith resumeData: Data,
        to destination: DownloadRequest.DownloadFileDestination? = nil) -> SignalProducer<DownloadRequest, NoError> {
            
        return SignalProducer(value: self.base.download(resumingWith: resumeData,
                                                        to: destination))
    }

    // MARK: - Upload Request
    
    // MARK: File
    
    /// Creates a `SignalProducer<UploadRequest, NoError>` from the specified `url`, `method` and `headers` for uploading the `file`.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter file:    The file to upload.
    /// - parameter url:     The URL.
    /// - parameter method:  The HTTP method. `.post` by default.
    /// - parameter headers: The HTTP headers. `nil` by default.
    ///
    /// - returns: The created `SignalProducer<UploadRequest, NoError>`.
    @discardableResult
    public func upload(
        _ fileURL: URL,
        to url: URLConvertible,
        method: HTTPMethod = .post,
        headers: HTTPHeaders? = nil) -> SignalProducer<UploadRequest, NoError> {
            
            return SignalProducer(value: self.base.upload(fileURL,
                                                          to: url,
                                                          method: method,
                                                          headers: headers))
    }
    
    
    /// Creates a `SignalProducer<UploadRequest, NoError>` from the specified `urlRequest` for uploading the `file`.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter file:       The file to upload.
    /// - parameter urlRequest: The URL request.
    ///
    /// - returns: The created `SignalProducer<UploadRequest, NoError>`.
    @discardableResult
    public func upload(_ fileURL: URL, with urlRequest: URLRequestConvertible) -> SignalProducer<UploadRequest, NoError> {
        
        return SignalProducer(value: self.base.upload(fileURL,
                                                      with: urlRequest))
    }
    
    // MARK: Data
    
    /// Creates a `SignalProducer<UploadRequest, NoError>` from the specified `url`, `method` and `headers` for uploading the `data`.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter data:    The data to upload.
    /// - parameter url:     The URL.
    /// - parameter method:  The HTTP method. `.post` by default.
    /// - parameter headers: The HTTP headers. `nil` by default.
    ///
    /// - returns: The created `SignalProducer<UploadRequest, NoError>`.
    @discardableResult
    public func upload(
        _ data: Data,
        to url: URLConvertible,
        method: HTTPMethod = .post,
        headers: HTTPHeaders? = nil) -> SignalProducer<UploadRequest, NoError> {
            
            return SignalProducer(value: self.base.upload(data,
                                                          to: url,
                                                          method: method,
                                                          headers: headers))
    }
    
    
    
    /// Creates a `SignalProducer<UploadRequest, NoError>` from the specified `urlRequest` for uploading the `data`.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter data:       The data to upload.
    /// - parameter urlRequest: The URL request.
    ///
    /// - returns: The created `SignalProducer<UploadRequest, NoError>`.
    @discardableResult
    public func upload(_ data: Data, with urlRequest: URLRequestConvertible) -> SignalProducer<UploadRequest, NoError> {
        
        return SignalProducer(value: self.base.upload(data,
                                                      with: urlRequest))
    }
    
    // MARK: InputStream
    
    /// Creates a `SignalProducer<UploadRequest, NoError>` from the specified `url`, `method` and `headers` for uploading the `stream`.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter stream:  The stream to upload.
    /// - parameter url:     The URL.
    /// - parameter method:  The HTTP method. `.post` by default.
    /// - parameter headers: The HTTP headers. `nil` by default.
    ///
    /// - returns: The created `SignalProducer<UploadRequest, NoError>`.
    @discardableResult
    public func upload(
        _ stream: InputStream,
        to url: URLConvertible,
        method: HTTPMethod = .post,
        headers: HTTPHeaders? = nil)
        -> SignalProducer<UploadRequest, NoError> {
            
            return SignalProducer(value: self.base.upload(stream,
                                                          to: url,
                                                          method: method,
                                                          headers: headers))
    }
    
    /// Creates a `SignalProducer<UploadRequest, NoError>` from the specified `urlRequest` for uploading the `stream`.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter stream:     The stream to upload.
    /// - parameter urlRequest: The URL request.
    ///
    /// - returns: The created `SignalProducer<UploadRequest, NoError>`.
    @discardableResult
    public func upload(_ stream: InputStream, with urlRequest: URLRequestConvertible) -> SignalProducer<UploadRequest, NoError> {
        
        return SignalProducer(value: self.base.upload(stream,
                                                      with: urlRequest))
    }
    
    #if !os(watchOS)
    
    // MARK: - Stream Request
    
    // MARK: Hostname and Port
    
    /// Creates a `SignalProducer<StreamRequest, NoError>` for bidirectional streaming using the `hostname` and `port`.
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - parameter hostName: The hostname of the server to connect to.
    /// - parameter port:     The port of the server to connect to.
    ///
    /// - returns: The created `SignalProducer<StreamRequest, NoError>`.
    @discardableResult
    @available(iOS 9.0, macOS 10.11, tvOS 9.0, *)
    public func stream(withHostName hostName: String, port: Int) -> SignalProducer<StreamRequest, NoError> {
        
        return SignalProducer(value: self.base.stream(withHostName: hostName, port: port))
    }
    
    #endif
}
