//
//  OtherGraphVC.swift
//  Sadhana
//
//  Created by Alexander Koryttsev on 8/22/17.
//  Copyright © 2017 Alexander Koryttsev. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Crashlytics

class OtherGraphVC : GraphVC<OtherGraphVM> {

    override func viewDidLoad() {
        refreshControl = UIRefreshControl()
        super.viewDidLoad()
        tableView.allowsSelection = false
        viewModel.refresh.onNext(())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Answers.logContentView(withName: "Other Graph", contentType: nil, contentId: nil, customAttributes: ["UserID" : viewModel.userID])
    }

    override func bindViewModel() {
        super.bindViewModel()
        viewModel.firstPageRunning.drive(refreshControl!.rx.isRefreshing).disposed(by: disposeBag)

        viewModel.dataDidReload.asDriver(onErrorJustReturn: ()).drive(onNext: { [unowned self] () in
            self.reloadData()
        }).disposed(by: disposeBag)

        viewModel.pageDidUpdate.asDriver(onErrorJustReturn: 0).drive(onNext: { [unowned self] (section) in
            if let paths = self.tableView.indexPathsForVisibleRows {
                for path in paths {
                    if path.section == section {
                        if let cell = self.tableView.cellForRow(at: path) {
                            self.setUp(cell, at: path)
                        }
                    }
                }
            }
        }).disposed(by: disposeBag)
        
        title = viewModel.userName
    }

}