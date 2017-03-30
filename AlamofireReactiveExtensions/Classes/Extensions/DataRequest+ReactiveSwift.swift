//
//  DataRequest+ReactiveSwift.swift
//  Pods
//
//  Created by George Kaimakas on 29/03/2017.
//
//

import Alamofire
import Foundation
import ReactiveSwift
import Result

extension DataRequest: ReactiveExtensionsProvider {}

public extension Reactive where Base: DataRequest {
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - parameter queue:             The queue on which the completion handler is dispatched.
    ///
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func response(queue: DispatchQueue? = nil) -> SignalProducer<DefaultDataResponse, NoError> {
        return SignalProducer{ (observer, disposable) in
            self.base.response(queue: queue) { (defaultResponse: DefaultDataResponse) in
                observer.send(value: defaultResponse)
                observer.sendCompleted()
            }
        }
    }
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - parameter queue:              The queue on which the completion handler is dispatched.
    /// - parameter responseSerializer: The response serializer responsible for serializing the request, response,
    ///                                 and data.
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func response<T: DataResponseSerializerProtocol>(
        queue: DispatchQueue? = nil,
        responseSerializer: T) -> SignalProducer<DataResponse<T.SerializedObject>, NoError> {
        
        return SignalProducer{ (observer, disposable) in
            self.base.response(queue: queue,
                               responseSerializer: responseSerializer,
                               completionHandler: { (dataResponse: DataResponse<T.SerializedObject>) in
                                
                                observer.send(value: dataResponse)
                                observer.sendCompleted()
            })
        }
    }
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func responseData(
        queue: DispatchQueue? = nil) -> SignalProducer<DataResponse<Data>, NoError> {
            
            return SignalProducer{ (observer, disposable) in
                self.base.responseData(queue: queue,
                                       completionHandler: { (data: DataResponse<Data>) in
                                        observer.send(value: data)
                                        observer.sendCompleted()
                })
            }
    }
    
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - parameter encoding:          The string encoding. If `nil`, the string encoding will be determined from the
    ///                                server response, falling back to the default HTTP default character set,
    ///                                ISO-8859-1.
    ///
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func responseString(
        queue: DispatchQueue? = nil,
        encoding: String.Encoding? = nil) -> SignalProducer<DataResponse<String>, NoError> {
        
        return SignalProducer{ (observer, disposable) in
            self.base.responseString(queue: queue,
                                     encoding: encoding,
                                     completionHandler: { (data: DataResponse<String>) in
                                        observer.send(value: data)
                                        observer.sendCompleted()
            })
        }
    }
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - parameter options:           The JSON serialization reading options. Defaults to `.allowFragments`.
    ///
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func responseJSON(
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments) -> SignalProducer<DataResponse<Any>, NoError> {
        
        return SignalProducer{ (observer, disposable) in
            self.base.responseJSON(queue: queue,
                                   options: options,
                                   completionHandler: { (data: DataResponse<Any>) in
                                    observer.send(value: data)
                                    observer.sendCompleted()
            })
        }
    }
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - parameter options:           The property list reading options. Defaults to `[]`.
    /// - parameter completionHandler: A closure to be executed once the request has finished.
    ///
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func responsePropertyList(
        queue: DispatchQueue? = nil,
        options: PropertyListSerialization.ReadOptions = []) -> SignalProducer<DataResponse<Any>, NoError> {
        
        return SignalProducer { (observer, disposable) in
            self.base.responsePropertyList(queue: queue,
                                           options: options,
                                           completionHandler: { (data: DataResponse<Any>) in
                                            
                                            observer.send(value: data)
                                            observer.sendCompleted()
            })
        }
    }
}

public extension SignalProducer where Value: DataRequest, Error == NoError {
    
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - parameter queue:             The queue on which the completion handler is dispatched.
    ///
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func response(queue: DispatchQueue? = nil) -> SignalProducer<DefaultDataResponse, NoError> {
        
        return flatMap(.latest) { $0.reactive.response(queue: queue) }
    }
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - parameter queue:              The queue on which the completion handler is dispatched.
    /// - parameter responseSerializer: The response serializer responsible for serializing the request, response,
    ///                                 and data.
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func response<T: DataResponseSerializerProtocol>(
        queue: DispatchQueue? = nil,
        responseSerializer: T) -> SignalProducer<DataResponse<T.SerializedObject>, NoError> {
        
        return flatMap(.latest) { $0.reactive.response(queue: queue, responseSerializer: responseSerializer) }
    }
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func responseData(
        queue: DispatchQueue? = nil) -> SignalProducer<DataResponse<Data>, NoError> {
        
        return flatMap(.latest) { $0.reactive.responseData(queue: queue) }
    }
    
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - parameter encoding:          The string encoding. If `nil`, the string encoding will be determined from the
    ///                                server response, falling back to the default HTTP default character set,
    ///                                ISO-8859-1.
    ///
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func responseString(
        queue: DispatchQueue? = nil,
        encoding: String.Encoding? = nil) -> SignalProducer<DataResponse<String>, NoError> {
        
        return flatMap(.latest) { $0.reactive.responseString(queue: queue, encoding: encoding) }
    }
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - parameter options:           The JSON serialization reading options. Defaults to `.allowFragments`.
    ///
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func responseJSON(
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments) -> SignalProducer<DataResponse<Any>, NoError> {
        
        return flatMap(.latest) { $0.reactive.responseJSON(queue: queue, options: options) }
    }
    
    /// Creates a `SignalProducer` that sends a value once the request has finished.
    ///
    /// - parameter options:           The property list reading options. Defaults to `[]`.
    /// - parameter completionHandler: A closure to be executed once the request has finished.
    ///
    /// - returns: The `SignalProducer`.
    @discardableResult
    public func responsePropertyList(
        queue: DispatchQueue? = nil,
        options: PropertyListSerialization.ReadOptions = []) -> SignalProducer<DataResponse<Any>, NoError> {
        
        return flatMap(.latest) { $0.reactive.responsePropertyList(queue: queue, options: options) }
    }
}
