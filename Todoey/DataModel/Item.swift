//
//  Item.swift
//  Todoey
//
//  Created by 이종익 on 2018. 3. 13..
//  Copyright © 2018년 sow4063. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
