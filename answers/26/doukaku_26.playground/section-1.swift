
class Solver {
    let base  = "abdegijlnpqsuwy"
    let l_ = "_c_fh_kmo_rtvx_"
    let r_ = "__c_fh_kmo_rtvx"
    let v_ = "cfhkmortvx_____"
    let input : String
    
    init(input:String) {
        self.input = input
    }
    
    func fill(source:String) -> [Character] {
        return map(source) { c in contains(self.input, c) ? "1" : "0" }
    }
    
    func count<T:Equatable>(a:[T], b:[T]) -> Int {
        var count = 0
        for i in 0..<countElements(a) {
            if a[i] != b[i] {
                count++
            }
        }
        return count
    }
    
    func solve() -> String {
        let a = fill(base)
        let r = count(a, b: fill(l_))
        let g = count(a, b: fill(r_))
        let b = count(a, b: fill(v_))
        return "\(r),\(g),\(b)"
    }
}

func test(input:String, expected:String) -> Bool {
    let actual = Solver(input:input).solve()
    return actual == expected
}

/*0*/ test( "bdelmnouy", "5,7,9" );
/*1*/ test( "a", "1,1,1" );
/*2*/ test( "q", "1,1,1" );
/*3*/ test( "t", "1,1,1" );
/*4*/ test( "i", "1,1,1" );
/*5*/ test( "fg", "2,0,2" );
/*6*/ test( "gh", "0,2,2" );
/*7*/ test( "gm", "2,2,0" );
/*8*/ test( "fgh", "1,1,3" );
/*9*/ test( "fghm", "2,2,2" );
/*10*/ test( "fhm", "3,3,3" );
/*11*/ test( "bdfhjprx", "8,8,0" );
/*12*/ test( "abcdfghm", "4,4,0" );
/*13*/ test( "jklmqrst", "0,4,4" );
/*14*/ test( "klmntuvw", "4,0,4" );
/*15*/ test( "abcdefghijklmnopqrstuvwxy", "5,5,5" );
/*16*/ test( "abcdefghijklmnoqrtvwxy", "6,8,4" );
/*17*/ test( "abdefhijklnoprstvwxy", "10,8,4" );
/*18*/ test( "acegikmoqsuwy", "13,13,5" );
/*19*/ test( "bdfhjlnprtvxy", "13,11,1" );
/*20*/ test( "abdegijlnpqsuwy", "15,15,15" );
/*21*/ test( "aefghiqrstuvwxy", "3,3,15" );
/*22*/ test( "cfhkmoqrstuvwxy", "7,7,15" );
/*23*/ test( "cfhkmortvx", "10,10,10" );
/*24*/ test( "no", "0,2,2" );
/*25*/ test( "pwy", "3,3,3" );
/*26*/ test( "iqwy", "4,4,4" );
/*27*/ test( "lopuv", "3,3,5" );
/*28*/ test( "abdjtw", "6,6,6" );
/*29*/ test( "fgpstux", "5,3,5" );
/*30*/ test( "dijlnotv", "6,8,2" );
/*31*/ test( "bdefkmpwx", "5,9,3" );
/*32*/ test( "bfghjlmuwx", "4,8,6" );
/*33*/ test( "befghlopqrw", "5,7,9" );
/*34*/ test( "bfgjklmnqsux", "8,6,8" );
/*35*/ test( "fijklnpqstvwy", "9,9,9" );
/*36*/ test( "abcdfgilmnrsuv", "8,6,6" );
/*37*/ test( "abcdegijklnpruw", "11,11,9" );
/*38*/ test( "efgijkmnopqrtvwx", "6,8,4" );
/*39*/ test( "abcdefghilopqrtwy", "9,9,7" );
/*40*/ test( "abfghklmopqrsuvwxy", "8,6,12" );
/*41*/ test( "abcdeghklmoprstuwxy", "9,7,7" );
/*42*/ test( "abcdehijklmnopqrtwxy", "8,8,6" );
/*43*/ test( "acdefghimnopqrstuvwxy", "7,3,9" );
/*44*/ test( "abcfghijklmnopqrtuvwxy", "6,6,6" );
/*45*/ test( "abcdefghijklmnoqrstuwxy", "5,7,7" );
/*46*/ test( "abcdeghijklmnopqrstuvwxy", "6,6,6" );
