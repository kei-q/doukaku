import Foundation

class Solver {
    typealias InputType = String
    typealias OutputType = String
    
    func solve_(input:InputType) -> OutputType {
        let ns : [Int] = map(input) { "\($0)".toInt()! }
        var o : [Bool] = Array(count: 9+1, repeatedValue: false)
        var x : [Bool] = Array(count: 9+1, repeatedValue: false)
        var curr = "o"
        var next = "x"
        
        for c in ns[0..<min(9,ns.count)] {
            let n = "\(c)".toInt()!
            
            if o[n] || x[n] {
                return "Foul : \(next) won."
            }

            if curr == "o" {
                o[n] = true
            } else {
                x[n] = true
            }
            var t = curr == "o" ? o : x

            let n_ = (n-1) / 3 * 3
            let n__ = (n-1) % 3
            
            let b = (t[n_+1] && t[n_+2] && t[n_+3]) || (t[n__+1] && t[n__+4] && t[n__+7])
            
            if b || (t[1] && t[5] && t[9]) || (t[3] && t[5] && t[7]) {
                return "\(curr) won."
            }
            
            
            swap(&curr, &next)
        }
        return "Draw game."
    }
    
    func solve(input:String) -> String {
        return solve_(input)
    }
}

tests()
//t(21)
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
    /*1 */  test("79538246",    "x won.")
    /*2 */  test("35497162193", "x won.")
    /*3 */  test("61978543",    "x won.")
    /*4 */  test("254961323121",    "x won.")
    /*5 */  test("6134278187",  "x won.")
    /*6 */  test("4319581", "Foul : x won.")
    /*7 */  test("9625663381",  "Foul : x won.")
    /*8 */  test("7975662", "Foul : x won.")
    /*9 */  test("2368799597",  "Foul : x won.")
    /*10*/  test("18652368566", "Foul : x won.")
    /*11*/  test("965715",  "o won.")
    /*12*/  test("38745796",    "o won.")
    /*13*/  test("371929",  "o won.")
    /*14*/  test("758698769",   "o won.")
    /*15*/  test("42683953",    "o won.")
    /*16*/  test("618843927",   "Foul : o won.")
    /*17*/  test("36535224",    "Foul : o won.")
    /*18*/  test("882973",  "Foul : o won.")
    /*19*/  test("653675681",   "Foul : o won.")
    /*20*/  test("9729934662",  "Foul : o won.")
    /*21*/  test("972651483927",    "Draw game.")
    /*22*/  test("5439126787",  "Draw game.")
    /*23*/  test("142583697",   "Draw game.")
    /*24*/  test("42198637563", "Draw game.")
    /*25*/  test("657391482",   "Draw game.")

}

