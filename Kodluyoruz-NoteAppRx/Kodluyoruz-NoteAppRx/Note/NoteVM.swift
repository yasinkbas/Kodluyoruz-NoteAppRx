//
//  NoteVM.swift
//  Kodluyoruz-NoteAppRx
//
//  Created by XCODE on 14.09.2019.
//  Copyright © 2019 XCODE. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

class NoteVM {
    
    let api = RealmAPI()
    
    let disposeBag = DisposeBag()
    
    var selectedDate = BehaviorRelay<String>(value: Date().string(dateFormat: .ddMMyyyy))
    var notes = BehaviorRelay<Results<Note>?>(value: nil)
    
    func deleteNote(note: Note){
        api.deleteObject(object: note)
    }
    
    func getNotesBySelectedDate() {
        let notes = self.api.getNotesBySelectedDate(selectedDate: selectedDate.value)
        self.notes.accept(notes)
    }
    
}

