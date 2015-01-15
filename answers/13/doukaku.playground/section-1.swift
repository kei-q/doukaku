
import Foundation

class Solver {
    typealias InputType = [[Int]]
    typealias OutputType = Int

    func parse(input:String) -> InputType {
        var s = split(input, { $0 == "0" })
        return map(s) { s_ in map(s_) { c in "\(c)".toInt()! } }
    }
    
    func format(result:OutputType) -> String {
        return result.description
    }
    
    func count(n:Int, input:[Int]) -> OutputType {
        if input.isEmpty {
            return 0
        }
        var m = maxElement(input)
        let a = split(input, { m == $0 }, maxSplit: 1, allowEmptySlices: true)
        var n = reduce(a[0], 0) { (sum, inp) in sum + m - inp }
        return n + self.count(m, input: Array(a[1]))
    }
    
    func solve_(input:InputType) -> OutputType {
        return reduce(input, 0) { (sum, inp) in
            var m = maxElement(inp)
            let a = split(inp, { m == $0 }, maxSplit: 1, allowEmptySlices: true)
            return sum + self.count(m, input: reverse(a[0])) + self.count(m, input: Array(a[1]))
        }
    }
    
    func solve(input:String) -> String {
        return format(solve_(parse(input)))
    }
}

func test(input:String, expected:String) -> Bool {
    let actual = Solver().solve(input)
    return actual == expected
}

/*0*/ test( "83141310145169154671122", "24" );
/*1*/ test( "923111128", "45" );
/*2*/ test( "923101128", "1" );
/*3*/ test( "903111128", "9" );
/*4*/ test( "3", "0" );
/*5*/ test( "31", "0" );
/*6*/ test( "412", "1" );
/*7*/ test( "3124", "3" );
/*8*/ test( "11111", "0" );
/*9*/ test( "222111", "0" );
/*10*/ test( "335544", "0" );
/*11*/ test( "1223455321", "0" );
/*12*/ test( "000", "0" );
/*13*/ test( "000100020003121", "1" );
/*14*/ test( "1213141516171819181716151413121", "56" );
/*15*/ test( "712131415161718191817161514131216", "117" );
/*16*/ test( "712131405161718191817161514031216", "64" );
/*17*/ test( "03205301204342100", "1" );
/*18*/ test( "0912830485711120342", "18" );
/*19*/ test( "1113241120998943327631001", "20" );
/*20*/ test( "7688167781598943035023813337019904732", "41" );
/*21*/ test( "2032075902729233234129146823006063388", "79" );
/*22*/ test( "8323636570846582397534533", "44" );
/*23*/ test( "2142555257761672319599209190604843", "41" );
/*24*/ test( "06424633785085474133925235", "51" );
/*25*/ test( "503144400846933212134", "21" );
/*26*/ test( "1204706243676306476295999864", "21" );
/*27*/ test( "050527640248767717738306306596466224", "29" );
/*28*/ test( "5926294098216193922825", "65" );
/*29*/ test( "655589141599534035", "29" );
/*30*/ test( "7411279689677738", "34" );
/*31*/ test( "268131111165754619136819109839402", "102" );
