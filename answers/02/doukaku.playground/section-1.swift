import Foundation

class Solver {
    typealias InputType = [Int]
    typealias OutputType = [Int]
    
    func hexString2Int(input:String) -> Int {
        let scanner = NSScanner(string: input)
        var n : UInt32 = 0
        let didScan = scanner.scanHexInt(&n)
        return didScan ? Int(n) : 0
    }
    
    func parse(input:String) -> InputType {
        var ss = input.componentsSeparatedByString("-")
        return ss.map { self.hexString2Int($0) }
    }
    
    func format(output:OutputType) -> String {
        return "-".join(output.map { String(format: "%02x", $0) })
    }
    
    func solve_(input:InputType) -> OutputType {
        var result = Array(count: input.count, repeatedValue: 0)
        var idx = 0
        
        for i in 0..<8 {
            let a = input.reduce(1<<i) { (ret,n) in
                ret & (n & 1<<i)
            }

            if a == 0 {
                for (j,n) in enumerate(input) {
                    result[j] |= (n & (1<<i)) >> (i-idx)
                }
                idx += 1
            }
        }
        return result
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
    /* 0*/ test("ff-2f-23-f3-77-7f-3b", "1f-03-00-1c-0d-0f-06" )
    /* 1*/ test("01", "00" )
    /* 2*/ test("00", "00" )
    /* 3*/ test("7a-4e", "0c-02" )
    /* 4*/ test("56-b6", "08-14" )
    /* 5*/ test("12-12-12", "00-00-00" )
    /* 6*/ test("de-ff-7b", "0a-0f-05" )
    /* 7*/ test("95-be-d0", "05-1e-20" )
    /* 8*/ test("7c-b0-bb", "1c-20-2b" )
    /* 9*/ test("7a-b6-31-6a", "3a-56-11-2a" )
    /*10*/ test("32-0e-23-82", "18-06-11-40" )
    /*11*/ test("ff-7f-bf-df-ef", "0f-07-0b-0d-0e" )
    /*12*/ test("75-df-dc-6e-42", "35-5f-5c-2e-02" )
    /*13*/ test("62-51-ef-c7-f8", "22-11-6f-47-78" )
    /*14*/ test("0c-47-8e-dd-5d-17", "04-23-46-6d-2d-0b" )
    /*15*/ test("aa-58-5b-6d-9f-1f", "52-28-2b-35-4f-0f" )
    /*16*/ test("ff-55-d5-75-5d-57", "0f-00-08-04-02-01" )
    /*17*/ test("fe-fd-fb-f7-ef-df-bf", "7e-7d-7b-77-6f-5f-3f" )
    /*18*/ test("fd-fb-f7-ef-df-bf-7f", "7e-7d-7b-77-6f-5f-3f" )
    /*19*/ test("d9-15-b5-d7-1b-9f-de", "69-05-55-67-0b-4f-6e" )
    /*20*/ test("38-15-fd-50-10-96-ba", "18-05-7d-20-00-46-5a" )
    /*21*/ test("fe-fd-fb-f7-ef-df-bf-7f", "fe-fd-fb-f7-ef-df-bf-7f" )
}

