// 最初にtestが全部通るまで49分

import Foundation

class Solver {
    typealias InputType = (Int,Int)
    typealias OutputType = String
    
    let words = [
        0x72: "T",
        0x57: "U",
        0x75: "N",
        0x36: "S",
        0x63: "Z",
        0x23: "L",
        0x32: "R",
        0x13: "J",
    ]
    
    func parse_(input:String) -> Int {
        let scanner = NSScanner(string: input)
        var n : UInt32 = 0
        let didScan = scanner.scanHexInt(&n)
        return didScan ? Int(n) : 0
    }
    
    func parse(input:String) -> InputType {
        let s = input.componentsSeparatedByString("/")
        return (parse_(s[0]), parse_(s[1]))
    }
    
    func solve_(input:InputType) -> OutputType {
        var pos = 0
        var (n,m) = input
        var result = ""
        while pos < 32 {
            let n_ = (n >> pos) & 7
            let m_ = (m >> pos) & 7
            if let c = words[Int(n_*16+m_)] {
                result += c
                pos += 3
            } else if let c = words[Int((n_&3)*16+(m_&3))] {
                result += c
                pos += 2
            } else {
                pos += 1
            }
        }
        return String(reverse(result))
    }
    
    func solve(input:String) -> String {
        return solve_(parse(input))
    }
}

func test(input:String, expected:String) -> Bool {
    let actual = Solver().solve(input)
    return actual == expected
}

/*0*/ test( "2ed8aeed/34b0ea5b", "LTRSUNTSJ" );
/*
/*0*/ test( "2ed8aeed/34b0ea5b", "LTRSUNTSJ" );
/*1*/ test( "00000200/00000300", "L" );
/*2*/ test( "00018000/00010000", "R" );
/*3*/ test( "00002000/00006000", "J" );
/*4*/ test( "00000700/00000200", "T" );
/*5*/ test( "01400000/01c00000", "U" );
/*6*/ test( "00003800/00002800", "N" );
/*7*/ test( "000c0000/00180000", "S" );
/*8*/ test( "00003000/00001800", "Z" );
/*9*/ test( "132eae6c/1a64eac6", "LRJTUNSZ" );
/*10*/ test( "637572d0/36572698", "ZSNUTJRL" );
/*11*/ test( "baddb607/d66b6c05", "LTJZTSSSN" );
/*12*/ test( "db74cd75/6dac6b57", "ZZZTJZRJNU" );
/*13*/ test( "3606c2e8/1b0d8358", "ZZSSLTJ" );
/*14*/ test( "ad98c306/e6cc6183", "UZZZZZZ" );
/*15*/ test( "4a4aaee3/db6eeaa6", "JJLLUUNNS" );
/*16*/ test( "ecd9bbb6/598cd124", "TSSZZTTRR" );
/*17*/ test( "e0000002/40000003", "TL" );
/*18*/ test( "a0000007/e0000005", "UN" );
/*19*/ test( "c0000003/80000006", "RS" );
/*20*/ test( "40000006/c0000003", "JZ" );
/*21*/ test( "01da94db/00b3b6b2", "TSUJLRSR" );
/*22*/ test( "76eeaaea/24aaeeae", "TRNNUUNU" );
/*23*/ test( "1dacaeee/1566e444", "NRJZUTTT" );
/*24*/ test( "26c9ac60/6c6d66c0", "JSZLRJZS" );
/*25*/ test( "6c977620/36da5360", "ZZLLTNZJ" );
/*26*/ test( "069aeae6/0db34eac", "SJSLTUNS" );
/*27*/ test( "06d53724/049da56c", "RRULRNJJ" );
/*28*/ test( "069b58b0/04d66da0", "RLRSLZJR" );
/*29*/ test( "1b6eced4/11b46a9c", "RZZTZNRU" );
/*30*/ test( "522e8b80/db6ad900", "JLLJNLJT" );
/*31*/ test( "6546cdd0/376c6898", "ZULSZRTL" );
/*32*/ test( "4e6d5b70/6ad9d620", "LNSSURST" );
/*33*/ test( "37367772/65635256", "SNSZNTNJ" );
/*34*/ test( "25535d58/377669cc", "LUUSLTUZ" );
/*35*/ test( "0ae6a55d/0eacedcb", "UNSUJUTJ" );
/*36*/ test( "76762edc/23536a88", "TZNZJNRT" );
*/
