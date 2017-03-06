//
//  NetworkServices.swift
//  DREKTORE
//
//  Created by Joshua on 3/5/17.
//  Copyright © 2017 Joshua. All rights reserved.
//

import Foundation

func searchStudents() {
    // Set up the URL request
    let endpoint: String = "http://104.199.122.125:8080/v1.0/student/name/f"
    guard let url = URL(string: endpoint) else {
        print("Error: cannot create URL")
        return
    }
    let urlRequest = URLRequest(url: url)
    
    // make the request
    let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) {
        (data, response, error) in
        // check for any errors
        guard error == nil else {
            print("error calling GET on /student/name/f")
            print(error!)
            return
        }
        // make sure we got data
        guard let responseData = data else {
            print("Error: did not receive data")
            return
        }
        // parse the result as JSON, since that's what the API provides
        do {

            guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String:Any]] else {
                print("error trying to convert data to JSON")
                return
            }
            // now we have the todo, let's just print it to prove we can access it
            print("The todo is:\(todo)")
        } catch  {
            print("error trying to convert data to JSON")
            return
        }
    }
    
    task.resume()
}
