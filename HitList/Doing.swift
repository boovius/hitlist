//
//  Doing.swift
//  HitList
//
//  Created by Joshua Book on 7/3/15.
//  Copyright (c) 2015 Boovius Projects. All rights reserved.
//

import Foundation
import CoreData

class Doing: NSManagedObject {

    @NSManaged var createdAt: NSDate
    @NSManaged var activity: Activity

}
