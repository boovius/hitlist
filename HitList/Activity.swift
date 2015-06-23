//
//  Activity.swift
//  HitList
//
//  Created by Joshua Book on 6/23/15.
//  Copyright (c) 2015 Boovius Projects. All rights reserved.
//

import Foundation
import CoreData

class Activity: NSManagedObject {

    @NSManaged var activity: String
    @NSManaged var count: NSNumber

}
