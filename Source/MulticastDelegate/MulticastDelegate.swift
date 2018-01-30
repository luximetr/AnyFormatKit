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
   var delegates = [WeakWrapper]()
  
  /**
   Use the property to check if no delegates are contained there.
   
   - Returns: true if the text input's contents should be cleared; otherwise, false.
   */
  open var isEmpty: Bool {
    return delegates.count == 0
  }
  
  /**
   Add delegate in list of delegates.
   
   - Parameters
     - delegate: Object, that what to be delegate
  */
  open func add(delegate: T) {
    let weakObject = WeakWrapper(value: delegate as AnyObject)
    delegates.append(weakObject)
  }
  
  /**
   Remove delegate from delegate list
   
   - Parameters:
     - delegate: Object, that must to be deleted from delegate list
  */
  open func remove(delegate: T) {
    for (index, delegateInArray) in delegates.enumerated().reversed()
      where delegateInArray === delegate as AnyObject {
      delegates.remove(at: index)
    }
  }
  
  /**
   Method, that used for calling delegate methods for all delegates
   
   - Parameters:
     - invocation: Closure, that will call for all delegates
  */
  open func invoke(invocation: (T) -> ()) {
    for delegate in delegates {
      if let castedDelegate = delegate.value as? T {
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

 class WeakWrapper {
  weak var value: AnyObject?
  
  init(value: AnyObject?) {
    self.value = value
  }
}
