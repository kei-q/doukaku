//
//  Array.swift
//  ExSwift
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension Array {
    
    /**
    *  Checks if self contains all the items
    *  @param item The items to search for
    *  @return true if self contains all the items
    */
    func contains <T: Equatable> (items: T...) -> Bool {
        return items.all { self.indexOf($0) >= 0 }
    }
    
    /**
    *  Difference of self and the input arrays
    *  @param values Arrays to subtract
    *  @return Difference of self and the input arrays
    */
    func difference <T: Equatable> (values: Array<T>...) -> Array<T> {
        
        var result = Array<T>()
        
        elements: for e in self {
            if let element = e as? T {
                for value in values {
                    //  if a value is in both self and one of the values arrays
                    //  jump to the next iteration of the outer loop
                    if value.contains(element) {
                        continue elements
                    }
                }
                
                //  element it's only in self
                result.append(element)
            }
        }
        
        return result
        
    }
    
    /**
    *  Intersection of self and the input arrays
    *  @param values Arrays to intersect
    *  @return Array of unique values present in all the values arrays + self
    */
    func intersection <U: Equatable> (values: Array<U>...) -> Array {
        
        var result = self
        var intersection = Array()
        
        for (i, value) in enumerate(values) {
            
            //  the intersection is computed by intersecting a couple per loop:
            //  self n values[0], (self n values[0]) n values[1], ...
            if (i > 0) {
                result = intersection
                intersection = Array()
            }
            
            //  find common elements and save them in first set
            //  to intersect in the next loop
            value.each { (item: U) -> Void in
                if result.contains(item) {
                    intersection.append(item as Element)
                }
            }
            
        }
        
        return intersection
        
    }
    
    /**
    *  Union of self and the input arrays
    *  @param values Arrays
    *  @return Union array of unique values
    */
    func union <U: Equatable> (values: Array<U>...) -> Array {
        
        var result = self
        
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value as Element)
                }
            }
        }
        
        return result
        
    }
    
    /**
    *  First element of the array
    *  @return First element of the array if present
    */
    func first () -> Element? {
        if count > 0 {
            return self[0]
        }
        return nil
    }
    
    /**
    *  Last element of the array
    *  @return Last element of the array if present
    */
    func last () -> Element? {
        if count > 0 {
            return self[count - 1]
        }
        return nil
    }
    
    /**
    *  Index of the first occurrence of item, if found
    *  @param item The item to search for
    *  @return Index of the matched item or nil
    */
    func indexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            if let found = find(reinterpretCast(self) as Array<U>, item) {
                return found
            }
            
            return nil
        }
        
        return nil
    }
    
    /**
    *  Gets the index of the last occurrence of item, if found
    *  @param item The item to search for
    *  @return Index of the matched item or nil
    */
    func lastIndexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            if let index = reverse().indexOf(item) {
                return count - index - 1
            }
            
            return nil
        }
        
        return nil
    }
    
    /**
    *  Object at the specified index if exists
    *  @param index
    *  @return Object at index in array, nil if index is out of bounds
    */
    func get (index: Int) -> Element? {
        
        //  Fixes out of bounds values integers
        func relativeIndex (index: Int) -> Int {
            var _index = (index % count)
            
            if _index < 0 {
                _index = count + _index
            }
            
            return _index
        }
        
        let _index = relativeIndex(index)
        return _index < count ? self[_index] : nil
    }
    
    /**
    *  Array of grouped elements, the first of which contains the first elements
    *  of the given arrays, the 2nd contains the 2nd elements of the given arrays, and so on
    *  @param arrays Arrays to zip
    *  @return Array of grouped elements
    */
    func zip (arrays: Array<Any>...) -> Array<Array<Any?>> {
        
        var result = Array<Array<Any?>>()
        
        //  Gets the longest array
        let max = arrays.map { (array: Array<Any>) -> Int in
            return array.count
            }.max() as Int
        
        for i in 0..<max {
            
            //  i-th element in self as array + every i-th element in each array in arrays
            result.append([get(i)] + arrays.map {
                (array: Array<Any>) -> Any? in return array.get(i)
                })
            
        }
        
        return result
    }
    
    /**
    *  Applies cond to each element in array, splitting it each time cond returns a new value.
    *  @param cond Function which takes an element and produces an equatable result.
    *  @return Array partitioned in order, splitting via results of cond.
    */
    func partitionBy <T: Equatable> (cond: (Element) -> T) -> Array<Array> {
        var result = Array<Array>()
        var lastValue: T? = nil
        
        for item in self {
            let value = cond(item)
            
            if value == lastValue? {
                result[result.count - 1] += item
            } else {
                result.append([item])
                lastValue = value
            }
        }
        
        return result
    }
    
    /**
    *  Max value in the current array (if applicable)
    *  @return Max value
    */
    func max <U: Comparable> () -> U {
        
        return maxElement(map {
            return $0 as U
            })
        
    }
    
    /**
    *  Min value in the current array (if applicable)
    *  @return Min value
    */
    func min <U: Comparable> () -> U {
        
        return minElement(map {
            return $0 as U
            })
        
    }
    
    /**
    *  Iterates on each element
    *  @param call Function to call for each element
    */
    func each (call: (Element) -> ()) {
        
        for item in self {
            call(item)
        }
        
    }
    
    /**
    *  Iterates on each element with its index
    *  @param call Function to call for each element
    */
    func each (call: (Int, Element) -> ()) {
        
        for (index, item) in enumerate(self) {
            call(index, item)
        }
        
    }
    
    /**
    *  Same as each, from Right to Left
    *  @param call Function to call for each element
    */
    func eachRight (call: (Element) -> ()) {
        self.reverse().each(call)
    }
    
    /**
    *  Same as each (with index), from Right to Left
    *  @param call Function to call for each element
    */
    func eachRight (call: (Int, Element) -> ()) {
        for (index, item) in enumerate(self.reverse()) {
            call(count - index - 1, item)
        }
    }
    
    /**
    *  Checks if call returns true for any element of self
    *  @param call Function to call for each element
    *  @return True if call returns true for any element of self
    */
    func any (call: (Element) -> Bool) -> Bool {
        for item in self {
            if call(item) {
                return true
            }
        }
        
        return false
    }
    
    /**
    *  Checks if call returns true for all the elements in self
    *  @param call Function to call for each element
    *  @return True if call returns true for all the elements in self
    */
    func all (call: (Element) -> Bool) -> Bool {
        for item in self {
            if !call(item) {
                return false
            }
        }
        
        return true
    }
    
    /**
    *  Opposite of filter
    *  @param exclude Function invoked to test elements from the exclusion from the array
    *  @return Filtered array
    */
    func reject (exclude: (Element -> Bool)) -> Array {
        return filter {
            return !exclude($0)
        }
    }
    
    
    /**
    *  Returns the first element in the array to meet the condition
    *  @param condition A function which returns a boolean if an element satisfies a given condition or not.
    *  @return The first element in the array to meet the condition
    */
    func takeFirst (condition: (Element) -> Bool) -> Element? {
        
        for value in self {
            if condition(value) {
                return value
            }
        }
        
        return nil
        
    }
    
    /**
    *  New array obtanined by removing the duplicate values (if applicable)
    *  @return Unique array
    */
    func unique <T: Equatable> () -> Array<T> {
        var result = Array<T>()
        
        for item in self {
            if !result.contains(item as T) {
                result.append(item as T)
            }
        }
        
        return result
    }
    
    /**
    *  Creates a dictionary composed of keys generated from the results of
    *  running each element of self through groupingFunction. The corresponding
    *  value of each key is an array of the elements responsible for generating the key.
    *  @param groupingFunction
    *  @return Grouped dictionary
    */
    func groupBy <U> (groupingFunction group: (Element) -> U) -> Dictionary<U, Array> {
        
        var result = Dictionary<U, Array>()
        
        for item in self {
            
            let groupKey = group(item)
            
            // If element has already been added to dictionary, append to it. If not, create one.
            if let elem = result[groupKey] {
                result[groupKey] = elem + [item]
            } else {
                result[groupKey] = [item]
            }
        }
        
        return result
    }
    
    /**
    *  Similar to groupBy, but instead of returning a list of values,
    *  returns the number of values for each group
    *  @param groupingFunction
    *  @return Grouped dictionary
    */
    func countBy <U> (groupingFunction group: (Element) -> U) -> Dictionary<U, Int> {
        
        var result = Dictionary<U, Int>()
        
        for item in self {
            let groupKey = group(item)
            
            if let elem = result[groupKey] {
                result[groupKey] = elem + 1
            } else {
                result[groupKey] = 1
            }
        }
        
        return result
    }
    
    /**
    *  Joins the array elements with a separator
    *  @param separator
    *  @return Joined object if self is not empty
    *          and its elements are instances of C, nil otherwise
    */
    func implode <C: ExtensibleCollection> (separator: C) -> C? {
        if Element.self is C.Type {
            return Swift.join(separator, reinterpretCast(self) as Array<C>)
        }
        
        return nil
    }
    
    /**
    *  self.reduce from right to left
    */
    func reduceRight <U> (initial: U, combine: (U, Element) -> U) -> U {
        return reverse().reduce(initial, combine: combine)
    }
    
    
    /**
    *  Creates an array with the elements at the specified indexes
    *  @param indexes Indexes of the elements to get
    *  @return Array with the elements at indexes
    */
    func at (indexes: Int...) -> Array {
        return indexes.map { self.get($0)! }
    }
    
    /**
    *  Converts the array to a dictionary with the keys supplied via the keySelector
    *  @param keySelector
    *  @return A dictionary
    */
    func toDictionary <U> (keySelector:(Element) -> U) -> Dictionary<U, Element> {
        var result: Dictionary<U, Element> = [:]
        for item in self {
            let key = keySelector(item)
            result[key] = item
        }
        return result
    }
    
    /**
    *  Sorts the array by the given comparison function
    *  @param isOrderedBefore
    *  @return An array that is sorted by the given function
    */
    func sortBy (isOrderedBefore: (T, T) -> Bool) -> Array<T> {
        return sorted(isOrderedBefore)
    }
    
    /**
    *  Removes the last element from self and returns it
    *  @return The removed element
    */
    mutating func pop () -> Element {
        return self.removeLast()
    }
    
    /**
    *  Same as append
    *  @param newElement Element to append
    */
    mutating func push (newElement: Element) {
        return self.append(newElement)
    }
    
    /**
    *  Returns the first element of self and removes it
    *  @return The removed element
    */
    mutating func shift () -> Element {
        return self.removeAtIndex(0)
    }
    
    /**
    *  Prepends objects to the front of self
    */
    mutating func unshift (newElement: Element) {
        self.insert(newElement, atIndex: 0)
    }
    
    /**
    *  Deletes all the items in self that are equal to element
    *  @param element Element to remove
    */
    mutating func remove <U: Equatable> (element: U) {
        let anotherSelf = self
        
        removeAll(keepCapacity: true)
        
        anotherSelf.each {
            (index: Int, current: Element) in
            if current as U != element {
                self.append(current)
            }
        }
    }
    
    /**
    *  Constructs an array containing the integers in the given range
    *  @param range
    *  @return Array of integers
    */
    static func range <U: ForwardIndex> (range: Range<U>) -> Array<U> {
        return Array<U>(range)
    }
    
    /**
    *  Same as `at`
    *  @param first First index
    *  @param second Second index
    *  @param rest Rest of indexes
    *  @return Array with the items at the specified indexes
    *  @note It's a 2 + n params function to prevent conflicts with
    *  the default array subscript function
    */
    subscript (first: Int, second: Int, rest: Int...) -> Array {
        return at(reinterpretCast([first, second] + rest))
    }
    
}

/**
*  Remove and element from the array
*/
@infix public func - <T: Equatable> (first: Array<T>, second: T) -> Array<T> {
    return first - [second]
}

/**
*  Shorthand for the difference
*/
@infix public func - <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
    return first.difference(second)
}

/**
*  Shorthand for the intersection
*/
@infix public func & <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
    return first.intersection(second)
}

/**
*  Shorthand for the union
*/
@infix public func | <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
    return first.union(second)
}

/**
*  Array items concatenation à la Ruby
*  @param array Array of Strings to join
*  @param separator Separator to join the array elements
*  @return Joined string
*/
@infix public func * (array: Array<String>, separator: String) -> String {
    return array.implode(separator)!
}


////////////////////////////////////////////////////////////////////////////////

func parse(input:String) -> [[Int]] {
    let cells = input.componentsSeparatedByString("/")
    let field = cells.map {
        (s:String) -> [Int] in
        var a:[Int] = []
        for c in s {
            a += String(c).toInt()!
        }
        return a
    }
    // return [[0,1,2,2,4],[8,2,9,2,5],[6,9,0,7,6],[3,2,2,9,8],[2,1,0,6,5]]
    return field
}

func walk(field:[[Int]], x:Int, y:Int, n:Int) -> Int {
    if x < 0 || y < 0 || 4 < x || 4 < y {
        return 0
    }
    if field[y][x] <= n {
        return 0
    }
    
    let m = field[y][x]
    let a = walk(field, x-1, y, m)
    let b = walk(field, x+1, y, m)
    let c = walk(field, x, y-1, m)
    let d = walk(field, x, y+1, m)
    
    return 1 + [a,b,c,d].max()
}

func solve(input:String) -> String {
    let field = parse(input)
    var max = 0
    for y in 0..<5 {
        for x in 0..<5 {
            let result = walk(field, x, y, -1)
            if max < result {
                max = result
            }
        }
    }
    return max.description
}

func test(input:String, expected:String) -> String {
    let actual = solve(input)
    if actual == expected {
        return ""
    }
    else {
        return actual
    }
}

/*0*/ test( "01224/82925/69076/32298/21065", "6" );