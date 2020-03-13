//
//  CategoryDetailViewModel.swift
//  MedStoreApp
//
//  Created by Paresh Prajapati on 13/03/20.
//  Copyright © 2020 SolutionAnalysts. All rights reserved.
//

import UIKit
import RxSwift

class CategoryDetailViewModel: NSObject {
    let id: String
    let disposeBag = DisposeBag()
    let categoryList: BehaviorSubject<[Category]> = BehaviorSubject(value: [])
    
    init(categoryId: String) {
        id = categoryId
    }
    
    func getCategoryDetail() -> Observable<Category?> {
        return ApiHelper.load(resource: Category.detailFor(id: id))
    }
}
