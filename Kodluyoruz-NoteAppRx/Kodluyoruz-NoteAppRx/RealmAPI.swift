//
//  RealmAPI.swift
//  Kodluyoruz-NoteAppRx
//
//  Created by XCODE on 14.09.2019.
//  Copyright © 2019 XCODE. All rights reserved.
//

import Foundation
import RealmSwift

class RealmAPI {
    
    private var db: Realm!
    
    init() {
        do {
            db = try Realm()
        } catch let error {
            print(error)
        }
    }
    
    func addObject<T: Object>(object: T){
        do {
            try db.write {
                db.add(object)
            }
        }catch let error {
            print(error)
        }
    }
    
    func deleteObject<T: Object>(object: T){
        do {
            try db.write {
                db.delete(object)
            }
        }catch let error {
            print(error)
        }
    }
    
    func updateNote(note: Note, title: String, detail: String){
        do {
            try db.write {
                note.detail = detail
                note.title = title
                db.add(note, update: .modified)
            }
        }catch let error {
            print(error)
        }
    }
    
    func getNotesBySelectedDate(selectedDate: String) -> Results<Note> {
        return db.objects(Note.self).filter("date = '\(selectedDate)'")
    }
    
    
}
