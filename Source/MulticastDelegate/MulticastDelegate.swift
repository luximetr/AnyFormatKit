//
//  MulticastDelegate.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 25.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

/// Multiple delegate implementation
open class MulticastDelegate <T> {
  /// List of delegates
  private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()
  
  /**
   Add delegate in list of delegates.
   
   - Parameters
     - delegate: Object, that what to be delegate
  */
  open func add(delegate: T) {
    delegates.add(delegate as AnyObject)
  }
  
  /**
   Remove delegate from delegate list
   
   - Parameters:
     - delegate: Object, that must to be deleted from delegate list
  */
  open func remove(delegate: T) {
    for oneDelegate in delegates.allObjects.reversed() {
      if oneDelegate === delegate as AnyObject {
        delegates.remove(oneDelegate)
      }
    }
  }
  
  /**
   Method, that used for calling delegate methods for all delegates
   
   - Parameters:
     - invocation: Closure, that will call for all delegates
  */
  open func invoke(invocation: (T) -> ()) {
    for delegate in delegates.allObjects.reversed() {
      if let castedDelegate = delegate as? T {
        invocation(castedDelegate)
      }
    }
  }
}

/**
 Overriden operator, that allow add delegate to delegate list
 
 - Parameters:
   - left: Multicast delegate, that will add new delegate for own delegate list
   - right: Object, that wont to be delegate
*/
func += <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
  left.add(delegate: right)
}

/**
 Overriden operator, that allow remove delegate from delegate list
 
 - Parameters:
   - left: Multicast delegate, that will remove delegate from own delegate list
   - right: Object, that wont to be remove from delegate list
*/
func -= <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
  left.remove(delegate: right)
}
