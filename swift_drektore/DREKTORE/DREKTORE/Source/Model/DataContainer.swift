//
//  DataContainer.swift
//  DREKTORE
//
//  Created by Joshua on 3/5/17.
//  Copyright © 2017 Joshua. All rights reserved.
//

import Foundation

class DataContainer {
    
    static let sharedInstance : DataContainer = {
        let instance = DataContainer(arrayStudents: [], arrayFavorites: [])
        return instance
    }()
    
    var students = [Student]()
    var favorites = [Student]()
    
    //MARK: Init Array
    
    init( arrayStudents : [Student], arrayFavorites: [Student]) {
        students = arrayStudents
        favorites = arrayFavorites
    }
    
    func cleanData() {
        students.removeAll()
        favorites.removeAll()
    }
}
