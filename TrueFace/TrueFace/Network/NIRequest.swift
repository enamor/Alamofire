//
//  NIRequest.swift
//  TrueFace
//
//  Created by zhouen on 2017/4/6.
//  Copyright © 2017年 zhouen. All rights reserved.
//

import UIKit
import Alamofire


public typealias Success = (_ response : [String : Any])->()
public typealias Failure = (_ error : Error)->()

class NIRequest: NSObject {
    
    ///单例写法（此处无需单例 直接用类方法）
    static let shared = NIRequest()
    private override init() {
        // 初始化一些内容
    }
    
    
}


// MARK: -------- GET POST
extension NIRequest {
    /// GET请求
    class func getRequest(
        _ urlString: String,
        params: Parameters? = nil,
        success: @escaping Success,
        failure: @escaping Failure)
    {
        request(urlString, params: params, method: .get, success, failure)
    }
    
    /// POST请求
    class func postRequest(
        _ urlString: String,
        params: Parameters? = nil,
        success: @escaping Success,
        failure: @escaping Failure)
    {
        
        request(urlString, params: params, method: .post, success, failure)
    }
    
    private class func request(
        _ urlString: String,
        params: Parameters? = nil,
        method: HTTPMethod,
        _ success: @escaping Success,
        _ failure: @escaping Failure)
    {
        
        Alamofire.request(urlString, method: method, parameters: params)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let value = response.result.value as? [String: AnyObject] {
                        success(value)
                    }
                case .failure(let error):
                    failure(error)
                }
        }
        
    }
    
}

// MARK: -------- 上传(可多文件上传)
extension NIRequest {
    
    
    /// 单文件上传
    ///
    /// - Parameters:
    ///   - urlString:
    ///   - data: 二进制文件
    ///   - name: 和后台约定字段名称
    ///   - fileName: xx.png xx.jpg xx.zip...
    class func upLoadImage(
        _ urlString: String,
        data: Data,
        name: String = "image",
        fileName: String = "image.png",
        params: Parameters? = nil,
        success: @escaping Success,
        failure: @escaping Failure)
    {
        upLoadFiles(urlString, data: [data], names: [name], fileNames: [fileName], params: params, success: success, failure: failure)
    }
    
    /// 上传多文件
    ///
    /// - Parameters:
    ///   - urlString: url
    /// - parameter data:     The data to encode into the multipart form data.
    /// - parameter name:     The name to associate with the data in the `Content-Disposition` HTTP header.
    
    class func upLoadFiles(
        _ urlString: String,
        data: [Data],
        names: [String]? = nil,
        fileNames: [String]? = nil,
        params: Parameters? = nil,
        success: @escaping Success,
        failure: @escaping Failure)
    {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                assert(names?.count == fileNames?.count, "names.count != fileNames.count There may be problems")
                
                for i in 0..<data.count {
                    let data_name = names?[i] ?? "image\(i)"
                    let file_name = fileNames?[i] ?? "image\(i).png"
                    
                    //"image/png"
                    multipartFormData.append(data[i], withName: data_name ,fileName: file_name, mimeType: "multipart/form-data")
                }
                
                //参数添加
                if let params = params {
                    for (key, value) in params {
                        multipartFormData.append(((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                        
                    }
                }
                
        },
            to: urlString,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: Any]{
                            success(value)
                        }
                    }
                case .failure(let encodingError):
                    failure(encodingError)
                }
            }
        )
        
    }
    
    
}
