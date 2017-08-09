//
//  EditingVM.swift
//  Sadhana
//
//  Created by Alexander Koryttsev on 7/19/17.
//  Copyright © 2017 Alexander Koryttsev. All rights reserved.
//

import Foundation
import RxSwift

class EditingVM: BaseVM {
    let router : EditingRouter
    let save = PublishSubject<Void>()
    let cancel = PublishSubject<Void>()

    private let context = Local.service.newSubViewForegroundContext()

    init(_ router : EditingRouter) {
        self.router = router

        super.init()

        cancel.subscribe(onNext:{
            router.hideSadhanaEditing()
        }).disposed(by: disposeBag)

        save.subscribe(onNext:{ [weak self] () in
            if self == nil { return }
            var signals = [Observable<Bool>]()
            //TODO:filter
            //TODO:thread safe
            var entries = [ManagedEntry]()
            for entry in self!.context.registeredObjects {
                if let entry = entry as? ManagedEntry {
                    if entry.dateCreated == entry.dateUpdated,
                        entry.ID == nil {
                        self!.context.delete(entry)
                        continue
                    }
                    entries.append(entry)
                }
            }

            for entry in entries {
                if entry.shouldSynch {
                    let strongSelf = self!
                    let signal : Single<Int32> = Remote.service.send(entry).do(onNext: { (ID) in
                        entry.ID = ID
                        entry.dateSynched = Date()
                        strongSelf.context.saveRecursive()
                    })
                    signals.append(signal
                        .track(self!.errors)
                        .asBoolObservable())
                }
            }

            self!.context.saveRecursive()
            _ = Observable.merge(signals).subscribe()
        })
            .disposed(by: disposeBag)
    }

    func viewModelForEntryEditing(before vm: EntryEditingVM) -> EntryEditingVM? {
        return viewModelForEntryEditing(vm.date.yesterday)
    }

    func viewModelForEntryEditing(after vm: EntryEditingVM) -> EntryEditingVM? {
        return viewModelForEntryEditing(vm.date.tomorrow)
    }

    func viewModelForEntryEditing(_ forDate: Date? = Date()) -> EntryEditingVM? {
        return forDate! <= Date() ? EntryEditingVM(date: forDate!, context: context) : nil
    }
}