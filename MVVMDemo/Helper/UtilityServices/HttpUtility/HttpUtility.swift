//
//  HttpUtility.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//

import Foundation


struct HttpUtility
{
    let loading : LoadingView?
    
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void)
    {
        loading?.showLoadingView()
        debugPrint("url : \(requestUrl)")
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            self.loading?.hideLoadingView()
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                do {
                    let result = try JSONDecoder().decode(T.self, from: responseData!)
                    _=completionHandler(result)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error)")
                }
            }
        }.resume()
    }
}

