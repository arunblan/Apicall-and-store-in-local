//
//  HttpUtility.swift
//  userDetails
//
//  Created by lilac infotech on 09/08/21.
//

import Foundation

struct HttpUtility
{
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                //parse the responseData here
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _=completionHandler(result)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                }
            }

        }.resume()
    }
    
    func registerUser(completionHandler:@escaping(_ result: String)-> Void)
    {
        //register user
        var urlRequest = URLRequest(url: URL(string: "https://demo1994730.mockable.io/register")!)
        urlRequest.httpMethod = "post"
        let dataDictionary = [""]

        do {
            let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)

            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        } catch let error {
            debugPrint(error.localizedDescription)
        }

        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if(data != nil && data?.count != 0)
            {

                let response = String(data: data!, encoding: .utf8)
                debugPrint(response!)
                _ = completionHandler(response ?? "")
            }
        }.resume()
    }
}
