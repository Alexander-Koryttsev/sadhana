//
//  SadhanaEntryEditingVC.swift
//  Sadhana
//
//  Created by Alexander Koryttsev on 7/19/17.
//  Copyright © 2017 Alexander Koryttsev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SadhanaEntryEditingVC : BaseTableVC<SadhanaEntryEditingVM> {
    var cells = [FormCell]()

    override func viewDidLoad() {
        automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(94, 0, 50, 0)
        tableView.keyboardDismissMode = .interactive
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.contentOffset = CGPoint()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cells[indexPath.row].height()
    }

    override func bindViewModel() {
        super.bindViewModel()

        var previousResponsibleCell : ResponsibleCell?
        var firstResponsibleCell : ResponsibleCell?
        for field in viewModel.fields {
            var currentCell : FormCell?
            if let field = field as? VariableFieldVM {
                if field.variable.value is String? {
                    currentCell = TimeKeyboardFormCell(field)
                }
            }
            else if let field = field as? FieldsContainerVM {
                currentCell = CountContainerCell(field)
            }

            if let currentCell = currentCell {
                cells.append(currentCell)

                if let currentResponsibleCell = currentCell as? ResponsibleCell {
                    if let previousResponsibleCell = previousResponsibleCell {
                        previousResponsibleCell.resignActive.bind(to: currentResponsibleCell.becomeActive).disposed(by: disposeBag)
                        currentResponsibleCell.goBack.bind(to: previousResponsibleCell.becomeActive).disposed(by: disposeBag)
                    }
                    previousResponsibleCell = currentResponsibleCell

                    if firstResponsibleCell == nil {
                        firstResponsibleCell = currentResponsibleCell
                    }
                }
            }
        }

        if let firstResponsibleCell = firstResponsibleCell {
            firstResponsibleCell.goBack.subscribe(onNext:{ [weak self] () in
                self?.tableView.endEditing(true)
            }).disposed(by: disposeBag)
        }

        if let lastResponsibleCell = previousResponsibleCell {
            lastResponsibleCell.resignActive.subscribe(onNext:{ [weak self] () in
                self?.tableView.endEditing(true)
            }).disposed(by: disposeBag)
        }
    }
}
