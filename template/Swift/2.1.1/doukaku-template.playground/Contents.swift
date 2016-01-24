//: Playground - noun: a place where people can play

import UIKit
import Foundation

let worldmap : [Character:String] = [
    "1" : "ag",
    "2" : "dh",
    "3" : "bf",
    "a" : "b",
    "b" : "c5",
    "c" : "46",
    "d" : "ce",
    "e" : "5",
    "f" : "g",
    "g" : "ceh",
    "h" : "4i",
    "i" : "6",
]

extension Dictionary {
    func filter(test:(Key,Value) -> Bool) -> Dictionary {
        var result = Dictionary()
        for (k,v) in self {
            if test(k,v) {
                result[k] = v
            }
        }
        return result
    }
}

class Rails {
    let input : String
    let rails : [Character:String]
    let goals = "456"
    let starts = "123"
    
    init(deadends : String) {
        input = deadends
        rails = worldmap.filter { (k,_) in !deadends.containsString("\(k)") }
    }
    
    func trace(curr:Character) -> [Character] {
        if let next = rails[curr] {
            return next.characters.flatMap(self.trace)
        } else {
            return [curr]
        }
    }
    
    func solve_(start: Character) -> [String] {
        let deadends = trace(start)
        return goals.characters
            .filter { deadends.contains($0) }
            .map { "\(start)\($0)" }
    }
    
    func solve() -> String {
        let result = starts.characters.flatMap(self.solve_)
        return result == [] ? "-" : result.joinWithSeparator(",")
    }
}

func test(input:String, _ expected:String) -> String {
    let actual = Rails(deadends: input).solve()
    return actual == expected ? "ok" : actual
}

/*0*/ test( "befi", "14,16,24,26" );
///*1*/ test( "abc", "14,15,16,24,25,26,34,35,36" );
///*2*/ test( "de", "14,15,16,24,26,34,35,36" );
///*3*/ test( "fghi", "14,15,16,24,25,26,34,35,36" );
///*4*/ test( "abcdefghi", "-" );
///*5*/ test( "ag", "24,25,26,34,35,36" );
///*6*/ test( "dh", "14,15,16,34,35,36" );
///*7*/ test( "bf", "14,15,16,24,25,26" );
///*8*/ test( "ch", "15,25,35" );
///*9*/ test( "be", "14,16,24,26,34,36" );
///*10*/ test( "ci", "14,15,24,25,34,35" );
///*11*/ test( "cgi", "15,24,25,35" );
///*12*/ test( "acgi", "24,25,35" );
///*13*/ test( "cdefghi", "15,35" );
///*14*/ test( "acdefghi", "35" );
///*15*/ test( "cdegi", "15,24,35" );
///*16*/ test( "bcdegi", "24" );
///*17*/ test( "afh", "14,15,16,24,25,26,34,35,36" );
///*18*/ test( "abfh", "14,15,16,24,25,26" );
///*19*/ test( "dfh", "14,15,16,34,35,36" );
///*20*/ test( "cdfh", "15,35" );
///*21*/ test( "deh", "14,15,16,34,35,36" );
///*22*/ test( "cdeh", "15,35" );
///*23*/ test( "abefgh", "24,26" );
///*24*/ test( "abdefgh", "-" );
///*25*/ test( "acfghi", "25,35" );
///*26*/ test( "acdfghi", "35" );
///*27*/ test( "cegi", "15,24,35" );
///*28*/ test( "abcfhi", "15,25" );
///*29*/ test( "abcefhi", "-" );
///*30*/ test( "abdi", "14,15,16,24,34,35,36" );
///*31*/ test( "abdfi", "14,15,16,24" );
///*32*/ test( "bdi", "14,15,16,24,34,35,36" );
///*33*/ test( "bdfi", "14,15,16,24" );
///*34*/ test( "adfh", "14,15,16,34,35,36" );
///*35*/ test( "adfgh", "34,35,36" );
///*36*/ test( "acdfhi", "15,35" );
///*37*/ test( "bcdfgi", "24" );
///*38*/ test( "bcdfghi", "-" );
///*39*/ test( "defi", "14,15,16,24,34,35,36" );
///*40*/ test( "defhi", "14,15,16,34,35,36" );
///*41*/ test( "cdefg", "15,24,26,35" );
///*42*/ test( "cdefgi", "15,24,35" );
///*43*/ test( "bdefg", "24,26" );
///*44*/ test( "bdefgi", "24" );
