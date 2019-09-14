//
//  NoteDetailVM.swift
//  Kodluyoruz-NoteAppRx
//
//  Created by XCODE on 14.09.2019.
//  Copyright © 2019 XCODE. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NoteDetailVM {
    
    static let NoteDetailPlaceholder = "Note Detail"
    let api = RealmAPI()
    
    var title = BehaviorRelay<String?>(value: nil)
    var detail = BehaviorRelay<String?>(value: nil)
    
    let disposeBag = DisposeBag()
    
    var selectedDate: String!
    let selectedNote = BehaviorRelay<Note?>(value: nil)
    
    init(selectedNote: Note? = nil, selectedDate: String? = nil) {
        self.selectedNote.accept(selectedNote)
        self.selectedDate = selectedDate
    }
    
    
    func updateNote(note: Note, title: String, detail: String) {
        api.updateNote(note: note, title: title, detail: detail)
    }
    
    func addNote(note: Note) {
        api.addObject(object: note)
    }
}
