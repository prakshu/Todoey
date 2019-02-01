//
//  Item.swift
//  Todoey
//
//  Created by Prakshi Bector on 27/1/19.
//  Copyright © 2019 Prakshi Bector. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
       //So the complex answer is that dynamic is what's called a declaration modifier.It basically tells the runtime to use dynamic dispatch over the standard which is a static dispatch.And this basically allows this property name to be monitored for change at runtime.I.e. while your app is running so that means if the user changes the value of name.
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?

    //So we called our inverse relationship parent category and it's going to be set to an object of the classlinking objects and linking objects are auto updating containers that represent 0 or more objects that are linked to its owning model object through a property relationship.
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")

}
