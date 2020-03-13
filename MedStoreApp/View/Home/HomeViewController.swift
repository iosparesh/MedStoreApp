//
//  HomeViewController.swift
//  MedStoreApp
//
//  Created by Paresh Prajapati on 13/03/20.
//  Copyright © 2020 SolutionAnalysts. All rights reserved.
//

import UIKit
import RxCocoa


class HomeViewController: BaseViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
//        setUpTableView()
        setUpCatTableView()
        viewModel.getCategories()
    }

    
    func setUpCatTableView() {
        viewModel.categoryList.debug().bind(to: categoryTableView.rx.items(cellIdentifier: "CategoryCell", cellType: CategoryCell.self)) { row, model, cell in
            cell.categoryNameLabel.text = model.employee_name
            cell.productsLabel.text = model.employee_salary
            cell.typeLable.text = model.id
        }.disposed(by: viewModel.disposeBag)
        
        categoryTableView.rx.modelSelected(Category.self).map{ $0.id }.subscribe(onNext: { [weak self] id in
            self?.redirectToDetail(id: id)
        }).disposed(by: viewModel.disposeBag)
    }
    
    func setUpTableView() {
        
        let result = viewModel.getCategoryList().share()
        .retry(3)
            .asDriver(onErrorJustReturn: Categories.empty)
        
        result.map {
            ($0?.data ?? [Category(id: "", employee_name: "", employee_salary: "", employee_age: "", profile_image: "")])
        }.drive(categoryTableView.rx.items(cellIdentifier: "CategoryCell", cellType: CategoryCell.self)) { row, model, cell in
            cell.categoryNameLabel.text = model.employee_name
            cell.productsLabel.text = model.employee_salary
            cell.typeLable.text = model.id
//            cell.categoryImage.
        }.disposed(by: viewModel.disposeBag)
        
        categoryTableView.rx.modelSelected(Category.self).map{ $0.id }.subscribe(onNext: { [weak self] id in
            self?.redirectToDetail(id: id)
        }).disposed(by: viewModel.disposeBag)
    
    }
    func redirectToDetail(id: String) {
        let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailVC") as! CategoryDetailVC
        detailVc.viewModel = CategoryDetailViewModel(categoryId: id)
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
}
