//
//   Category.swift
//  MedStoreApp
//
//  Created by Paresh Prajapati on 13/03/20.
//  Copyright © 2020 SolutionAnalysts. All rights reserved.
//

import Foundation

struct Category: Decodable {
    let id: String
    let employee_name: String
    let employee_salary: String
    let employee_age: String
    let profile_image: String
}

extension Category {
    static func detailFor(id: String) -> Resource<Category>  {
        let url = URL(string: "http://dummy.restapiexample.com/api/v1/employees/\(id)")!
        return Resource(url: url)
    }
    static var empty: Category {
        return Category(id: "", employee_name: "", employee_salary: "", employee_age: "", profile_image: "")
    }
}

struct Categories: Decodable {
    let data: [Category]
    let status:String
    
}

extension Categories {
    
    static var all: Resource<Categories> = {
        let url = URL(string: "http://dummy.restapiexample.com/api/v1/employees")!
        return Resource(url: url)
    }()

    static var empty: Categories {
        return Categories(data: [Category(id: "", employee_name: "", employee_salary: "", employee_age: "", profile_image: "")], status: "fail")
    }
    
    
    
}
