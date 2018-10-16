//
//  PostServices.swift
//  Bantu
//
//  Created by Steven Muliamin on 11/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

struct PostServices {
    static func getPosts(onComplete: @escaping ([Post]) -> ()){
        let newUrlString = GlobalSession.rootUrl + "/posts/"
        let url = URL(string: newUrlString)
        
        let dataTask = GlobalSession.session.dataTask(with: url!) { (data, response, error) in
            
            if let unwrappedError = error {
                print("Error = \(unwrappedError.localizedDescription)")
            } else if let unwrappedData = data {
                do {
                    // Ubah yg didapet jd json kyk di website, tapi pake = instead of : biasa
                    let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                    //                    print(json)
                    if let dictionary = json as? [String:Any] {
                        //                        print(dictionary)
                        var tempPosts: [Post] = []
                        let postsJSON = dictionary["data"] as! [[String:Any]]
                        for singlePost in postsJSON{
                            
                            let postId = singlePost["postId"] as! Int
                            let userId = singlePost["userId"] as! Int
                            let statusId = singlePost["statusId"] as! Int
                            let timeStamp = singlePost["timeStamp"] as! String
                            let schoolName = singlePost["schoolName"] as! String
                            let about = singlePost["about"] as! String
                            let studentNo = singlePost["studentNo"] as! Int
                            let teacherNo = singlePost["teacherNo"] as! Int
                            let address = singlePost["address"] as! String
                            let access = singlePost["access"] as! String
                            let notes = singlePost["notes"] as! String
                            let locationAOI = singlePost["locationAOI"] as! String
                            let locationName = singlePost["locationName"] as! String
                            let locationLocality = singlePost["locationLocality"] as! String
                            let locationAdminArea = singlePost["locationAdminArea"] as! String
                            let locationLatitude = singlePost["locationLatitude"] as! Double
                            let locationLongitude = singlePost["locationLongitude"] as! Double
                            
                            var schoolImages: [UIImage]
                            var roadImages: [UIImage]
                            var needs: [Needs]
                            
                            
                        }
                        onComplete(tempPosts)
                    }
                } catch {
                    print("Error convert JSON")
                }
            }
        }
        dataTask.resume()
    }
}
