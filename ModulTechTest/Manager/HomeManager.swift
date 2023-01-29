//
//  HomeManager.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 27/1/2023.
//

import Foundation
import UIKit

class HomeManager {
    
    public static func getDevices(completion: @escaping HomeResponseClosure) {
        
        guard let URL_GET_DEVICES = URL(string: AppConstants.GET_DEVICES_URL) else {
            completion(false, nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URL_GET_DEVICES) { (data, response, error) in
            guard let dataResponse = data, error == nil, let resp = response as? HTTPURLResponse
                else {
                    print(error?.localizedDescription ?? "Response Error")
                    completion(false, nil)
                    return
            }
            
            if resp.statusCode == 200 {
    
                // decoding from JSON to model
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(HomeResponse.self, from: dataResponse)
                    completion(true, model)
                    
                }
                catch let parsingError {
                    print("Error", parsingError)
                    completion(false, nil)
                }
            }
            else {
                completion(false, nil)
            }
    }
        task.resume()
    }
}
