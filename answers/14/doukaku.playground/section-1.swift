// 最初にtestが全部通るまで49分

import Foundation

func separate<S:SequenceType>(elements:S, pred:S.Generator.Element -> Bool) -> ([S.Generator.Element],[S.Generator.Element]) {
    let a = filter(elements) { pred($0) }
    let b = filter(elements) { !pred($0) }
    return (a,b)
}

class Solver {
    typealias InputType = ([Character],[Character])
    typealias OutputType = Int
    
    let arms = "acegika"
    let enemies = "BDFHJL"
    
    func parse(input:String) -> InputType {
        return separate(input) { (c:Character) in contains(self.arms, c) }
    }
    
    func format(result:OutputType) -> String {
        return result.description
    }
    
    func solve_(input:InputType) -> OutputType {
        var (arms_,enemies_) = input
        var count = 0
        while !arms_.isEmpty {
            let c = removeLast(&arms_)
            let index = find(self.arms,c)!
            if contains(arms, c) && contains(enemies_, enemies[index]) {
                let (a,b) = separate(enemies_) { self.enemies[index] == $0 }
                count += countElements(a)
                enemies_ = b
                let newArms = arms[advance(index,1)]
                arms_.append(newArms)
            }
        }
        return count
    }
    
    func solve(input:String) -> String {
        return solve_(parse(input)).description
    }
}

func test(input:String, expected:String) -> Bool {
    let actual = Solver().solve(input)
    return actual == expected
}

/*0*/ test( "gLDLBgBgHDaD", "6" );
/*1*/ test( "DBcDLaLgDBH", "6" );
/*2*/ test( "JJca", "0" );
/*3*/ test( "FJDLBH", "0" );
/*4*/ test( "HJBLFDg", "6" );
/*5*/ test( "HBaDLFJ", "6" );
/*6*/ test( "DJaHLB", "2" );
/*7*/ test( "gDLHJF", "3" );
/*8*/ test( "cJFgLHD", "5" );
/*9*/ test( "FFBJaJJ", "1" );
/*10*/ test( "FJeJFBJ", "2" );
/*11*/ test( "iJFFJJB", "3" );
/*12*/ test( "JBJiLFJF", "5" );
/*13*/ test( "JDiFLFBJJ", "8" );
/*14*/ test( "BDFDFFDFFLLFFJFDBFDFFFFDDFaDBFFB", "28" );
/*15*/ test( "DDFBFcBDFFFFFFLBFDFFBFLFDFDJDFDF", "24" );
/*16*/ test( "FDLBFDDBFFFeFFFFFDFBLDDFDDFBFFJF", "16" );
/*17*/ test( "FDBFFLFDFFDBBDFFBJDLFgDFFFDFFDFF", "0" );
/*18*/ test( "FDiFLDFFFFBDDJDDBFBFDFFFBFFDFLFF", "31" );
/*19*/ test( "FDFDJBLBLBFFDDFFFDFFFFFDDFBkFDFF", "30" );
/*20*/ test( "HBkFFFFHBLH", "3" );
/*21*/ test( "FBHHFFFHLaB", "2" );
/*22*/ test( "LFHFBBcHFHF", "0" );
/*23*/ test( "LFBHFFeFHBH", "7" );
/*24*/ test( "LgFHHHBFBFF", "3" );
/*25*/ test( "FFiFHBHLBFH", "0" );
/*26*/ test( "BFHHFFHBeFLk", "10" );
/*27*/ test( "FHFaBBHFHLFg", "5" );
/*28*/ test( "FFgacaFg", "0" );
/*29*/ test( "JHDaDcBJiiHccBHDBDH", "9" );
/*30*/ test( "FHJJLckFckFJHDFF", "12" );
/*31*/ test( "DeDHJHDFHJBLHDLLDHJLBDD", "22" );
/*32*/ test( "gJLLLJgJgJLJL", "0" );
/*33*/ test( "DaaaDDD", "0" );
/*34*/ test( "HFeJFHiBiiBJeJBBFFB", "9" );
/*35*/ test( "FJFFJDBHBHaLJBHJHDLHkLLLFFFgJgHJLHkJkB", "32" );
/*36*/ test( "giFLBiBJLLJgHBFJigJJJBLHFLDLL", "23" );
/*37*/ test( "cgkLJcLJJJJgJc", "2" );
/*38*/ test( "LDFHJHcFBDBLJBLFLcFJcDFBL", "22" );
/*39*/ test( "JJHHHkHJkHLJk", "1" );
/*40*/ test( "kHHBBaBgHagHgaHBBB", "11" );
/*41*/ test( "HDBFFDHHHDFLDcHHLFDcJD", "20" );
/*42*/ test( "HFFFHeFFee", "7" );
/*43*/ test( "gLLDHgDLgFL", "1" );
/*44*/ test( "JJJBBaBBHBBHaLBHJ", "7" );
/*45*/ test( "FBFBgJBDBDgF", "0" );
/*46*/ test( "LLLLakakLakLL", "7" );
/*47*/ test( "HeJHeJe", "0" );
/*48*/ test( "LDFLBLLeBLDBBFFBLFBB", "4" );
