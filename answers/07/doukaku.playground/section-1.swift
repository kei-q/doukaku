
import Foundation

class Solver {
    typealias InputType = (Int,String)
    typealias OutputType = String
    
    var seats : [String]!
    
    func parse(input:String) -> InputType {
        var s = input.componentsSeparatedByString(":")
        return (s[0].toInt()!, s[1])
    }
    
    func format(output:OutputType) -> String {
        return output
    }
    
    func sitdown(c:String) {
        for i in 1..<seats.count-1 {
            if seats[i] == "-" && seats[i-1] == "-" && seats[i+1] == "-" {
                seats[i] = c
                return
            }
        }

        for i in 1..<seats.count-1 {
            if seats[i] == "-" && (seats[i-1] == "-" || seats[i+1] == "-") {
                seats[i] = c
                return
            }
        }

        for i in 1..<seats.count-1 {
            if seats[i] == "-" {
                seats[i] = c
                return
            }
        }
    }
    
    func standup(c:String) {
        if let index = find(seats, c) {
            seats[index] = "-"
        }
    }
    
    func solve_(input:InputType) -> OutputType {
        seats = Array(count: input.0+2, repeatedValue: "-")
        for c in input.1 {
            let s = "\(c)"
            if s == s.uppercaseString {
                sitdown(s)
            } else {
                standup(s.uppercaseString)
            }
        }
        
        return "".join(dropFirst(dropLast(seats)))
    }
    
    func solve(input:String) -> String {
        return format(solve_(parse(input)))
    }
}

tests()
//t(0)
tAll()

// ここからtest
// ====================================================

var testData : [(String,String)] = []

func test(input:String, expected:String) {
    let t = (input,expected)
    testData.append(t)
}

func t(n:Int) -> Bool {
    let (input,expected) = testData[n]
    let actual = Solver().solve(input)
    return actual == expected
}

func tAll() -> Bool {
    let results = testData.map { (input,expected) in
        Solver().solve(input) == expected
    }
    return reduce(results, true) { (b,b_) in b && b_ }
}

// ここにテストをコピペする
// ---------------------------------------------

func tests() {
    /*1*/ test( "6:NABEbBZn", "-ZAB-E" );
    /*2*/ test( "1:A", "A" );
    /*3*/ test( "1:Aa", "-" );
    /*4*/ test( "2:AB", "AB" );
    /*5*/ test( "2:AaB", "B-" );
    /*6*/ test( "2:AZa", "-Z" );
    /*7*/ test( "2:AZz", "A-" );
    /*8*/ test( "3:ABC", "ACB" );
    /*9*/ test( "3:ABCa", "-CB" );
    /*10*/ test( "4:ABCD", "ADBC" );
    /*11*/ test( "4:ABCbBD", "ABDC" );
    /*12*/ test( "4:ABCDabcA", "-D-A" );
    /*13*/ test( "5:NEXUS", "NUESX" );
    /*14*/ test( "5:ZYQMyqY", "ZM-Y-" );
    /*15*/ test( "5:ABCDbdXYc", "AYX--" );
    /*16*/ test( "6:FUTSAL", "FAULTS" );
    /*17*/ test( "6:ABCDEbcBC", "AECB-D" );
    /*18*/ test( "7:FMTOWNS", "FWMNTSO" );
    /*19*/ test( "7:ABCDEFGabcdfXYZ", "YE-X-GZ" );
    /*20*/ test( "10:ABCDEFGHIJ", "AGBHCIDJEF" );
}
