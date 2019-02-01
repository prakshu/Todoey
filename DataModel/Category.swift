//
//  Category.swift
//  Todoey
//
//  Created by Prakshi Bector on 27/1/19.
//  Copyright © 2019 Prakshi Bector. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    //So now we have the Ford relationship each category having a list of items and the reverse category.Each item has a parent category that is of the type category and it comes from that property calleditems.
    //each category has a one to many relationship with a list of items and each item has an inverse relationship to a category called the parent category.
//    let array = [1,2,3]
//    let array1 : [Int] = [1,2,3]
//    let array2 = [Int]()
//    let array3 : Array<Int> = [1,2,3]
    //    let array3 = Array<Int>()

    
}
