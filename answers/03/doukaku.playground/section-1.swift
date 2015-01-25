import Foundation

class Solver {
    typealias InputType = String
    typealias OutputType = String
    
    let routes : [Character:(Character,Character,Character)] = [
        "A" : ("D","C","B"),
        "B" : ("A","C","E"),
        "C" : ("A","F","B"),
        "D" : ("A","E","F"),
        "E" : ("B","F","D"),
        "F" : ("C","D","E"),
    ]
    
    func solve_(input:InputType) -> OutputType {
        var prev : Character = "B"
        var curr : Character = "A"
        var result : [Character] = ["A"]
        
        for c in input {
            var l : Character = "_"
            var r : Character = "_"
            switch routes[curr]! {
            case let (a, b, c) where (prev == a): l = b; r = c
            case let (a, b, c) where (prev == b): l = c; r = a
            case let (a, b, c) where (prev == c): l = a; r = b
            default: l = "_"; r = "_" // nop
            }
            
            if c == "l" {
                result.append(l)
                prev = curr
                curr = l
            } else if c == "r" {
                result.append(r)
                prev = curr
                curr = r
            } else {
                result.append(prev)
                swap(&prev, &curr)
            }
        }

        return String(result)
    }
    
    func solve(input:String) -> String {
        return solve_(input)
    }
}


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
    return sorted(actual) == sorted(expected)
}

func tAll() -> Bool {
    let results = testData.map { (input,expected) in
        sorted(Solver().solve(input)) == sorted(expected)
    }
    return reduce(results, true) { (b,b_) in b && b_ }
}

// ここにテストをコピペする
// ---------------------------------------------

func tests() {
    /*0*/ test("b", "AB" )
    /*1*/ test("l", "AD" )
    /*2*/ test("r", "AC" )
    /*3*/ test("bbb", "ABAB" )
    /*4*/ test("rrr", "ACBA" )
    /*5*/ test("blll", "ABCAB" )
    /*6*/ test("llll", "ADEBA" )
    /*7*/ test("rbrl", "ACADE" )
    /*8*/ test("brrrr", "ABEDAB" )
    /*9*/ test("llrrr", "ADEFDE" )
    /*10*/ test("lrlll", "ADFEDF" )
    /*11*/ test("lrrrr", "ADFCAD" )
    /*12*/ test("rllll", "ACFDAC" )
    /*13*/ test("blrrrr", "ABCFEBC" )
    /*14*/ test("brllll", "ABEFCBE" )
    /*15*/ test("bbrllrrr", "ABACFDEFD" )
    /*16*/ test("rrrrblll", "ACBACABCA" )
    /*17*/ test("llrlrrbrb", "ADEFCADABA" )
    /*18*/ test("rrrbrllrr", "ACBABEFCAD" )
    /*19*/ test("llrllblrll", "ADEFCBCADEB" )
    /*20*/ test("lrrlllrbrl", "ADFCBEFDFCB" )
    /*21*/ test("lllrbrrlbrl", "ADEBCBACFCAB" )
    /*22*/ test("rrrrrrlrbrl", "ACBACBADFDEB" )
    /*23*/ test("lbrbbrbrbbrr", "ADABABEBCBCFE" )
    /*24*/ test("rrrrlbrblllr", "ACBACFCACFDAB" )
    /*25*/ test("lbbrblrlrlbll", "ADADFDABCFDFED" )
    /*26*/ test("rrbbrlrlrblrl", "ACBCBADFEBEFDA" )
    /*27*/ test("blrllblbrrrrll", "ABCFDADEDABEDFE" )
    /*28*/ test("blrllrlbllrrbr", "ABCFDABCBEFDEDA" )
    /*29*/ test("lbrbbrllllrblrr", "ADABABEFCBEDEBCF" )
    /*30*/ test("rrrrbllrlrbrbrr", "ACBACABCFDEDADFC" )
}

tests()
//t(0)
tAll()
