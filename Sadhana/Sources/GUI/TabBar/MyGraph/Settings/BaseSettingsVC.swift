//
//  BaseSettingsVC.swift
//  Sadhana
//
//  Created by Alexander Koryttsev on 2/28/18.
//  Copyright © 2018 Alexander Koryttsev. All rights reserved.
//

class BaseSettingsVC : BaseTableVC <BaseSettingsVM> {
    
    var sections = [[FormCell]]()

    init(_ viewModel:VM) {
        super.init(viewModel, style: .grouped)
    }

    override func bindViewModel() {
        super.bindViewModel()
        viewModel.updates.subscribe(onNext: { [unowned self] (_) in
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }).disposed(by: disposeBag)
        
        viewModel.sections.forEach { (section) in
            var cells = [FormCell]()
            section.items.forEach({ (fieldVM) in
                cells.append(FormFactory.cell(for: fieldVM))
            })
            sections.append(cells)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    override func reloadData() {
        sections.forEach { (section) in
            section.forEach({ (cell) in
                cell.reloadData()
            })
        }
    }

    func field(at indexPath: IndexPath) -> FormFieldVM {
        return viewModel.sections[indexPath.section].items[indexPath.row]
    }

    // MARK: - Table Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection sectionIndex: Int) -> String? {
        let section = viewModel.sections[sectionIndex]
        var title : String

        if section.shown,
            section.title.count > 0 {
            title = section.title
        }
        else {
            title = " "
        }
        
        return title
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section][indexPath.row]
    }

    // MARK: - Table Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let field = self.field(at: indexPath)
        if let action = field.action {
            if action() {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = viewModel.sections[section]
        
        var height = CGFloat(0)
        if section.shown {
            height += 30
            
            if section.title.count > 0 {
                height += 14
            }
        }
        
        return height
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = viewModel.sections[indexPath.section]
        if !section.shown {
            return 0
        }
        let field = self.field(at:indexPath)
        if field is SettingInfo {
            return 80
        }
        return 44;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var title:String? {
        get { return viewModel.title }
        set {}
    }
}