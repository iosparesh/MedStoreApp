//
//  CategoryDetailVC.swift
//  MedStoreApp
//
//  Created by Paresh Prajapati on 13/03/20.
//  Copyright © 2020 SolutionAnalysts. All rights reserved.
//

import UIKit

class CategoryDetailVC: BaseViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var viewModel: CategoryDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetail()
    }
    func fetchDetail() {
        let result = viewModel.getCategoryDetail().share()
        .retry(3)
        .asDriver(onErrorJustReturn: Category.empty)
        
        result.debug("Count value").map {
            "Name of Employee:  \($0?.employee_name ?? "")"
        }.drive(self.nameLabel.rx.text).disposed(by: viewModel.disposeBag)
    }
    
}
