//
//  NetworkServices.swift
//  DREKTORE
//
//  Created by Joshua on 3/5/17.
//  Copyright © 2017 Joshua. All rights reserved.
//

import Foundation
let serverAddress = "http://192.168.1.8:8080/v1.0/student/name/"

func searchStudents(withWord searchWord: String) {
    // Set up the URL request
    let endpoint: String = serverAddress + searchWord
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

            guard let infoArray = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String:Any]] else {
                print("error trying to convert data to JSON")
                return
            }
            //["parents": Curtis Frank, "city": Bellevue, "email": curtis@gmail.com, "id": 14, "address": 12115 NE 33rd ST, "phone": 425-345-9364, "grade": 7, "lastName": Frank, "firstName": John, "zipCode": 98005],
            var students = [Student]()
            for item in infoArray {
                let student = Student()
                
                student.firstName = item["firstName"] as! String
                print(student.firstName)
                student.lastName = item["lastName"] as! String
                student.parentName = item["parents"] as? String
                student.email = item["email"] as! String
                student.phoneNumber = item["phone"] as! String
                student.grade = item["grade"] as! Int
                student.address = item["address"] as? String
                print("address:\(String(describing: student.address))")
                student.city = item["city"] as? String
                student.zipCode = item["zipCode"] as? String
                students.append(student)
            }
            let sharedInstance =  DataContainer.sharedInstance
            sharedInstance.students = students
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SearchResultsReceived"), object: nil)
            
            
        } catch  {
            print("error trying to convert data to JSON")
            return
        }
    }
    
    task.resume()
}

func parseRawDataIntoSharedData (rawData input: [[String:Any]] ) {
    
}
