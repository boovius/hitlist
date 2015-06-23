//
//  Activity.swift
//  
//
//  Created by Joshua Book on 6/23/15.
//
//

import Foundation
import CoreData

class Activity: NSManagedObject {

    @NSManaged var activity: String
    @NSManaged var count: NSNumber

}
