// 31分

import Foundation

class Register {
    let capacity : Int
    var rest : Int
    var xuser : Int?
    
    init(capacity:Int) {
        self.capacity = capacity
        rest = 0
        xuser = nil
    }
    
    func add(n:Int) {
        self.rest += n
    }
    
    func addX() {
        if self.xuser == nil {
            self.xuser = self.rest
        }
        self.rest += 1
    }
    
    func process() {
        if let xuser = self.xuser {
            var n = min(xuser, capacity)
            self.rest -= n
            self.xuser = xuser - n
        } else {
            self.rest = max(0, self.rest - capacity)
        }
    }
}

class Store {
    var registers : [Register]
    init() {
        registers = [2,7,3,5,2].map { Register(capacity: $0) }
    }
    
    func findTarget() -> Register {
        return registers.sorted{ $0.rest < $1.rest }[0]
    }
    
    func add(n:Int) {
        findTarget().add(n)
    }
    
    func addX() {
        findTarget().addX()
    }
    
    func process() {
        for r in registers {
            r.process()
        }
    }
    
    var result : [Int] {
        return registers.map { $0.rest }
    }
}

class Solver {
    typealias InputType = String
    typealias OutputType = [Int]

    func format(result:OutputType) -> String {
        return join(",", result.map{$0.description})
    }
    
    func solve_(input:InputType) -> OutputType {
        var store = Store()
        for c in input {
            switch c {
            case "x": store.addX()
            case ".": store.process()
            default:  store.add("\(c)".toInt()!)
            }
        }
        return store.result
    }
    
    func solve(input:String) -> String {
        return format(solve_(input))
    }
}

func test(input:String, expected:String) -> Bool {
    let actual = Solver().solve(input)
    return actual == expected
}

/*0*/ test( "42873x.3.", "0,4,2,0,0" );
/*
/*1*/ test( "1", "1,0,0,0,0" );
/*2*/ test( ".", "0,0,0,0,0" );
/*3*/ test( "x", "1,0,0,0,0" );
/*4*/ test( "31.", "1,0,0,0,0" );
/*5*/ test( "3x.", "1,1,0,0,0" );
/*6*/ test( "99569x", "9,9,6,6,9" );
/*7*/ test( "99569x33", "9,9,9,9,9" );
/*8*/ test( "99569x33.", "7,2,6,4,7" );
/*9*/ test( "99569x33..", "5,0,4,0,5" );
/*10*/ test( "12345x3333.", "4,0,3,2,3" );
/*11*/ test( "54321x3333.", "3,0,3,0,4" );
/*12*/ test( "51423x3333.", "3,4,4,0,4" );
/*13*/ test( "12x34x.", "1,0,1,0,2" );
/*14*/ test( "987x654x.32", "7,6,4,10,5" );
/*15*/ test( "99999999999x99999999.......9.", "20,10,12,5,20" );
/*16*/ test( "997", "9,9,7,0,0" );
/*17*/ test( ".3.9", "1,9,0,0,0" );
/*18*/ test( "832.6", "6,6,0,0,0" );
/*19*/ test( ".5.568", "3,5,6,8,0" );
/*20*/ test( "475..48", "4,8,0,0,0" );
/*21*/ test( "7.2..469", "1,4,6,9,0" );
/*22*/ test( "574x315.3", "3,3,1,7,1" );
/*23*/ test( "5.2893.x98", "10,9,5,4,1" );
/*24*/ test( "279.6xxx..4", "2,1,4,1,1" );
/*25*/ test( "1.1.39..93.x", "7,1,0,0,0" );
/*26*/ test( "7677749325927", "16,12,17,18,12" );
/*27*/ test( "x6235.87.56.9.", "7,2,0,0,0" );
/*28*/ test( "4.1168.6.197.6.", "0,0,3,0,0" );
/*29*/ test( "2.8.547.25..19.6", "6,2,0,0,0" );
/*30*/ test( ".5.3x82x32.1829..", "5,0,5,0,7" );
/*31*/ test( "x.1816..36.24.429.", "1,0,0,0,7" );
/*32*/ test( "79.2.6.81x..26x31.1", "1,0,2,1,1" );
/*33*/ test( "574296x6538984..5974", "14,13,10,15,14" );
/*34*/ test( "99.6244.4376636..72.6", "5,6,0,0,3" );
/*35*/ test( "1659.486x5637168278123", "17,16,16,18,17" );
/*36*/ test( ".5.17797.x626x5x9457.3.", "14,0,3,5,8" );
/*37*/ test( "..58624.85623..4.7..23.x", "1,1,0,0,0" );
/*38*/ test( "716.463.9.x.8..4.15.738x4", "7,3,5,8,1" );
/*39*/ test( "22xx.191.96469472.7232377.", "10,11,18,12,9" );
/*40*/ test( "24..4...343......4.41.6...2", "2,0,0,0,0" );
/*41*/ test( "32732.474x153.866..4x29.2573", "7,5,7,8,5" );
/*42*/ test( "786.1267x9937.17.15448.1x33.4", "4,4,8,4,10" );
/*43*/ test( "671714849.149.686852.178.895x3", "13,16,13,10,12" );
/*44*/ test( "86x.47.517..29621.61x937..xx935", "7,11,8,8,10" );
/*45*/ test( ".2233.78x.94.x59511.5.86x3.x714.", "4,6,10,8,8" );
/*46*/ test( ".793...218.687x415x13.1...x58576x", "8,11,8,6,9" );
/*47*/ test( "6.6x37.3x51x932.72x4x33.9363.x7761", "15,13,15,12,15" );
/*48*/ test( "6..4.x187..681.2x.2.713276.669x.252", "6,7,8,6,5" );
/*49*/ test( ".6.xx64..5146x897231.x.21265392x9775", "19,17,19,20,17" );
/*50*/ test( "334.85413.263314.x.6293921x3.6357647x", "14,14,12,16,10" );
/*51*/ test( "4.1..9..513.266..5999769852.2.38x79.x7", "12,10,13,6,10" );
*/