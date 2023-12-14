import ScrechKit
import XCTest

final class Sorting: XCTestCase {
    let sovietLeadersStartYears = [
        1917, // Lenin
        1924, // Stalin
        1953, // Khrushchev
        1964, // Brezhnev
        1982, // Andropov
        1984, // Chernenko
        1985  // Gorbachev
    ].shuffled()
    
    func bogoBogoSort<Element: Comparable>(_ array: inout [Element]) {
        var totalAttempts = 0
        
        while !array.enumerated().allSatisfy ({ $0.offset == 0 || array[$0.offset - 1] <= $0.element }) {
            for i in 1...array.count {
                var prefix = Array(array[..<i])
                
                // Inline bogoSort for the prefix
                var attempts = 0
                while !prefix.enumerated().allSatisfy ({ $0.offset == 0 || prefix[$0.offset - 1] <= $0.element }) {
                    prefix.shuffle()
                    attempts += 1
                }
                totalAttempts += attempts
                
                array.replaceSubrange(..<i, with: prefix)
                
                if !prefix.enumerated().allSatisfy ({ $0.offset == 0 || prefix[$0.offset - 1] <= $0.element }) {
                    array.shuffle()
                    break
                }
            }
        }
        
        print("Bogobogo sorted after \(totalAttempts) attempts")
    }
    
    func testBogobogoSort() throws {
        measure {
            var sortableArray = sovietLeadersStartYears
            
            bogoBogoSort(&sortableArray)
            print(sortableArray)
        }
    }
    
    func bozoSort<Element: Comparable>(_ array: inout [Element]) {
        var attempts = 0
        
        while !array.enumerated().allSatisfy ({ $0.offset == 0 || array[$0.offset - 1] <= $0.element }) {
            let index1 = Int.random(in: 0..<array.count)
            let index2 = Int.random(in: 0..<array.count)
            array.swapAt(index1, index2)
            attempts += 1
        }
        
        print("Sorted after \(attempts) attempts.")
    }
    
    func testBozoSort() throws {
        measure {
            var sortableArray = sovietLeadersStartYears
            
            bozoSort(&sortableArray)
            print(sortableArray)
        }
    }
    
    func bogoSort <Element: Comparable> (_ array: inout [Element]) {
        var attempts = 0
        
        while !array.enumerated().allSatisfy ({ $0.offset == 0 || array[$0.offset - 1] <= $0.element }) {
            array.shuffle()
            attempts += 1
        }
        
        print("Sorted after \(attempts) attempts.")
    }
    
    func testBogoSort() throws {
        measure {
            var sortableArray = sovietLeadersStartYears
            
            bogoSort(&sortableArray)
            print(sortableArray)
        }
    }
    
    func testStalinSort() throws {
        measure {
            print(stalinSort(sovietLeadersStartYears))
        }
    }
    
    func testRegularSort() throws {
        measure {
            print(sovietLeadersStartYears.sorted { $0 < $1 })
        }
    }
}
