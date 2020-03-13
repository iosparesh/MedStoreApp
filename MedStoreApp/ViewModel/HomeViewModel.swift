//
//  HomeViewModel.swift
//  MedStoreApp
//
//  Created by Paresh Prajapati on 13/03/20.
//  Copyright © 2020 SolutionAnalysts. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class HomeViewModel: NSObject {
    let disposeBag = DisposeBag()
    let categoryList:BehaviorRelay<[Category]> = BehaviorRelay(value: [])
    func getCategoryList() -> Observable<Categories?> {
        return ApiHelper.load(resource: Categories.all)
    }
    
    func getCategories() {
        ApiHelper.load(resource: Categories.all)
            .subscribe(onNext: { [weak self] result in
                if let result = result {
                    self?.categoryList.accept(result.data)
                }
            }).disposed(by: self.disposeBag)
        
    }
}
