
import Foundation

class Solver {
    typealias InputType = (Int,Int)
    typealias OutputType = String
    
    func parse(input:String) -> InputType {
        var s = input.componentsSeparatedByString("->")
        return (s[0].toInt()!, s[1].toInt()!)
    }
    
    func up(n:Int) -> Int {
        return (n+1) / 3
    }

    func solve_(input:InputType) -> OutputType {
        let (a,b) = input
        if a == b {
            return "me"
        } else if up(a) == b {
            return "mo"
        } else if up(b) == a {
            return "da"
        } else if up(a) == up(b) {
            return "si"
        } else if up(up(a)) == up(b) {
            return "au"
        } else if up(a) == up(up(b)) {
            return "ni"
        } else if up(up(a)) == up(up(b)) {
            return "co"
        } else {
            return "-"
        }
    }
    
    func solve(input:String) -> String {
        return solve_(parse(input))
    }
}

tests()
t(0)
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
    /*#0*/ test( "5->2", "mo" );
    /*#1*/ test( "28->10", "au" );
    /*#2*/ test( "1->1", "me" );
    /*#3*/ test( "40->40", "me" );
    /*#4*/ test( "27->27", "me" );
    /*#5*/ test( "7->2", "mo" );
    /*#6*/ test( "40->13", "mo" );
    /*#7*/ test( "9->3", "mo" );
    /*#8*/ test( "4->1", "mo" );
    /*#9*/ test( "1->3", "da" );
    /*#10*/ test( "12->35", "da" );
    /*#11*/ test( "3->8", "da" );
    /*#12*/ test( "6->19", "da" );
    /*#13*/ test( "38->40", "si" );
    /*#14*/ test( "9->8", "si" );
    /*#15*/ test( "4->2", "si" );
    /*#16*/ test( "15->16", "si" );
    /*#17*/ test( "40->12", "au" );
    /*#18*/ test( "10->4", "au" );
    /*#19*/ test( "21->5", "au" );
    /*#20*/ test( "8->2", "au" );
    /*#21*/ test( "3->5", "ni" );
    /*#22*/ test( "11->39", "ni" );
    /*#23*/ test( "2->13", "ni" );
    /*#24*/ test( "13->32", "ni" );
    /*#25*/ test( "14->22", "co" );
    /*#26*/ test( "40->34", "co" );
    /*#27*/ test( "5->8", "co" );
    /*#28*/ test( "12->10", "co" );
    /*#29*/ test( "1->27", "-" );
    /*#30*/ test( "8->1", "-" );
    /*#31*/ test( "12->22", "-" );
    /*#32*/ test( "2->40", "-" );
    /*#33*/ test( "32->31", "-" );
    /*#34*/ test( "13->14", "-" );
}
