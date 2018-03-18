//
//  Category.swift
//  Todoey
//
//  Created by 이종익 on 2018. 3. 13..
//  Copyright © 2018년 sow4063. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
