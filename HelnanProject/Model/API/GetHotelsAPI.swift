//
//  GetHotelsAPI.swift
//  HelnanProject
//
//  Created by Mahmoud on 6/1/18.
//  Copyright © 2018 CyanDH. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class GetAllHotels {
    
    class func getHotels(completion:@escaping (_ error :Error?, _ hotels: [GetHotelsTV]?)->Void){
        let url = "http://helnan.cyandh.com/api/Service/GetHotels?LangId=1"
       
        
        Alamofire.request(url, method: .get, parameters: nil, headers: nil).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                
                print(error)
                completion(error,nil)
            case .success(let value):
                let json = JSON(value)
                
                guard let dataArr = json.array else {
                    completion(nil,nil)
                       
                    
                    
                    return
                    
                }
//                print(json)
                var hotels = [GetHotelsTV]()
                for data in dataArr {
                    guard let data = data.dictionary else {return }
                    let hotel = GetHotelsTV()
                    hotel.name = data["Name"]?.string ?? "sss"
                    hotel.icon = data["Icon"]?.string ?? "sss"
                    hotel.id = data["ID"]?.int ?? 0
                    hotel.hotelImages = (data["HotelImages"]?.arrayObject as? [String])!
                    hotels.append(hotel)
//                    print(hotel.hotelImages)
                    
                    
                    
                    
                }
                completion(nil,hotels)
            }
            
        }
    }

    
    }
