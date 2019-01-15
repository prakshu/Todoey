//
//  Item.swift
//  Todoey
//
//  Created by Prakshi Bector on 9/1/19.
//  Copyright © 2019 Prakshi Bector. All rights reserved.
//

import Foundation
//And this means that the item type is now able to encode itself into a P list or into a Jason and for a class to be able to be incredible all of its properties must have standard data types.
class item : Codable
{
    var title : String = ""
    var done : Bool = false
}
