//
//  Note.swift
//  Kodluyoruz-NoteAppRx
//
//  Created by XCODE on 13.09.2019.
//  Copyright © 2019 XCODE. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var detail: String = ""
    @objc dynamic var date: String = ""
    
    convenience init(id: String, title: String, detail: String, date: String){
        self.init()
        self.id = id
        self.title = title
        self.detail = detail
        self.date = date
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
