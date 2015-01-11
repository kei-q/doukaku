
import Foundation

class Solver {
    typealias InputType = (String,String)
    
    func parse(input:String) -> InputType {
        let parsed = input.componentsSeparatedByString("-")
        return (parsed[0], parsed[1])
    }

    func solve_(input:InputType) -> Int {
        var (lr,tb) = (1,1)
        var (l,r,t,b) = (0,0,0,0)

        for c in input.0 {
            switch c {
            case "R": l = l+r; r = lr; lr *= 2;
            case "L": r = l+r; l = lr; lr *= 2;
            case "T": b = t+b; t = tb; tb *= 2;
            case "B": t = t+b; b = tb; tb *= 2;
            default: 0
            }
        }
        
        switch input.1 {
        case "tl": return t * l
        case "tr": return t * r
        case "bl": return b * l
        case "br": return b * r
        default:  return 0
        }
    }
    
    func solve(input:String) -> String {
        return solve_(parse(input)).description
    }
}

func test(input:String, expected:String) -> Bool {
    let actual = Solver().solve(input)
    return actual == expected
}

/*0*/ test( "RRTRB-bl", "6" );

/*0*/ test( "RRTRB-bl", "6" );
/*1*/ test( "R-tr", "0" );
/*2*/ test( "L-br", "0" );
/*3*/ test( "T-tl", "0" );
/*4*/ test( "B-tl", "0" );
/*5*/ test( "BL-br", "0" );
/*6*/ test( "LB-tl", "0" );
/*7*/ test( "RL-tl", "0" );
/*8*/ test( "BL-tl", "0" );
/*9*/ test( "TL-bl", "0" );
/*10*/ test( "RT-tr", "1" );
/*11*/ test( "TRB-tl", "0" );
/*12*/ test( "TRL-bl", "0" );
/*13*/ test( "TRB-br", "2" );
/*14*/ test( "LLB-bl", "2" );
/*15*/ test( "RTL-tr", "1" );
/*16*/ test( "LBB-tr", "0" );
/*17*/ test( "TLL-tl", "2" );
/*18*/ test( "RLRR-tr", "0" );
/*19*/ test( "BBTL-tl", "4" );
/*20*/ test( "TBBT-tr", "0" );
/*21*/ test( "LLBR-tl", "0" );
/*22*/ test( "LBRT-tl", "2" );
/*23*/ test( "RLBL-bl", "4" );
/*24*/ test( "BRRL-br", "3" );
/*25*/ test( "TBBTL-tl", "8" );
/*26*/ test( "TLBBT-br", "0" );
/*27*/ test( "LRBLL-br", "7" );
/*28*/ test( "TRRTT-br", "6" );
/*29*/ test( "BBBLB-br", "0" );
/*30*/ test( "RTTTR-tl", "4" );
/*31*/ test( "BBLLL-br", "6" );
/*32*/ test( "RRLLTR-tr", "16" );
/*33*/ test( "TTRBLB-br", "8" );
/*34*/ test( "LRBRBR-bl", "14" );
/*35*/ test( "RBBLRL-tl", "8" );
/*36*/ test( "RTRLTB-tl", "12" );
/*37*/ test( "LBLRTR-tl", "14" );
/*38*/ test( "RRLTRL-tl", "16" );
/*39*/ test( "TBLTRR-br", "12" );
/*40*/ test( "TTTRLTT-bl", "30" );
/*41*/ test( "TBBRTBL-tr", "15" );
/*42*/ test( "TRTRTLL-tr", "28" );
/*43*/ test( "TLLRTRB-tr", "24" );
/*44*/ test( "RLLBRLB-tr", "15" );
/*45*/ test( "LTLRRBT-tr", "32" );
/*46*/ test( "RBBRBLT-br", "21" );
/*47*/ test( "LLRLRLR-tr", "0" );

