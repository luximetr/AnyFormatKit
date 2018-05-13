//
//  Observer.swift
//  AnyFormatKit
//
//  Created by Aleksandr Orlov on 30.01.18.
//  Copyright © 2018 BRANDERSTUDIO. All rights reserved.
//

import Foundation


open class Observer<T> {
  private let subscribers: NSHashTable<AnyObject>
  
  public init(strongReferences: Bool = false) {
    subscribers = strongReferences ? NSHashTable() : NSHashTable.weakObjects()
  }
  
  public init(options: NSPointerFunctions.Options) {
    subscribers = NSHashTable(options: options, capacity: 0)
  }
  
  open func addSubscriber(_ subscriber: T) {
    
    subscribers.add(subscriber as AnyObject)
  }
  
  open func removeSubscriber(_ subscriber: T) {
    subscribers.remove(subscriber as AnyObject)
  }
  
  open func notifySubscribers(_ invocation: (T) -> ()) {
    for subscriber in subscribers.allObjects {
      if let castedSubscriber = subscriber as? T {
        invocation(castedSubscriber)
      }
    }
  }
}
