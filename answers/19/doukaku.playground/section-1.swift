import Foundation

class Solver {
    func toN(n:Int, i:Int) -> Int {
        return i*100 + n % (i*8)
    }
    
    func front(a:Int, b:Int) -> [Int] {
        let c = Double(b * (a-1)) / Double(a)
        let ns = [floor(c),ceil(c)]
        return (ns[0]==c ? [c] : ns).map { self.toN(Int($0), i:a-1) }
    }
    
    func back(a:Int, b:Int) -> [Int] {
        let c = Double(b * (a+1)) / Double(a)
        let ns = [floor(c),ceil(c)]
        return (ns[0]==c ? [c-1, c, c+1] : ns).map { self.toN(Int($0), i:a+1) }
    }
    
    func calc(n:Int) -> [Int] {
        let (a,b) = (n/100, n%100 + n/100 * 8)
        let side = [ toN(b-1,i:a), toN(b+1,i:a) ]
        
        switch n/100 {
        case 1: return side + back(a,b:b)
        case 4: return front(a,b:b) + side
        default: return front(a,b:b) + side + back(a,b:b)
        }
    }
    
    func count(list:[Int]) -> [Int] {
        var dic : [Int:Int] = [:]
        return filter(sorted(list)) { n in
            dic[n] = (dic[n] ?? 0)+1
            return dic[n] == 2
        }
    }
    
    func solve_(input:[Int]) -> [Int] {
        return count([].join(input.map { self.calc($0) })).filter { !contains(input, $0) }
    }
    
    func solve(input:String) -> String {
        let parsed = input.componentsSeparatedByString(",").map { $0.toInt()! }
        let result = solve_(parsed)
        return result.isEmpty ? "none" : join(",", result.map{ $0.description })
    }
}

func test(input:String, expected:String) -> Bool {
    let actual = Solver().solve(input)
    return actual == expected
}

/*0*/ test( "400,401,302", "300,301,402" );
/*1*/ test( "105,100,306,414", "none" );
/*2*/ test( "100", "none" );
/*3*/ test( "211", "none" );
/*4*/ test( "317", "none" );
/*5*/ test( "414", "none" );
/*6*/ test( "100,106", "107" );
/*7*/ test( "205,203", "102,204" );
/*8*/ test( "303,305", "304" );
/*9*/ test( "407,409", "306,408" );
/*10*/ test( "104,103", "207" );
/*11*/ test( "204,203", "102,305" );
/*12*/ test( "313,314", "209,418" );
/*13*/ test( "419,418", "314" );
/*14*/ test( "100,102,101", "201,203" );
/*15*/ test( "103,206,309", "205,207,308,310" );
/*16*/ test( "414,310,309", "206,311,413" );
/*17*/ test( "104,102,206,307,102,202", "101,103,203,204,205,207,308" );
/*18*/ test( "104,206,308,409,407", "103,205,207,306,307,309,408,410" );
/*19*/ test( "313,406,213,301,409,422,412,102,428", "none" );
/*20*/ test( "101,300,210,308,423,321,403,408,415", "none" );
/*21*/ test( "304,316,307,207,427,402,107,431,412,418,424", "none" );
/*22*/ test( "205,408,210,215,425,302,311,400,428,412", "none" );
/*23*/ test( "200,311,306,412,403,318,427,105,420", "none" );
/*24*/ test( "105,305,407,408,309,208,427", "104,209,306,406" );
/*25*/ test( "311,304,322,404,429,305,316", "203,303,321,405,406,430" );
/*26*/ test( "210,401,316,425,101", "211,315" );
/*27*/ test( "414,403,404,416,428,421", "303,415" );
/*28*/ test( "207,300,103,211,428", "104,206" );
/*29*/ test( "322,314,310", "none" );
/*30*/ test( "427,200,215", "100,323" );
/*31*/ test( "311,402,424,307,318,430,323,305,201", "200,204,301,302,306,322,423,425,431" );
/*32*/ test( "425,430,408", "none" );
/*33*/ test( "202,320,209,426", "319,427" );
/*34*/ test( "430,209,302,310,304,431,320", "202,303,323" );
/*35*/ test( "208,206,406,424,213,312", "207,311,313" );
/*36*/ test( "420,302,313,413,317,402", "301,403" );
/*37*/ test( "319,306,309,418,204,411", "305,307,308,412" );
/*38*/ test( "400,308,105,430,203,428,209", "104,210,429,431" );
/*39*/ test( "200,305,214", "215" );
/*40*/ test( "214,408,410,407,317,422", "306,316,409,423" );
