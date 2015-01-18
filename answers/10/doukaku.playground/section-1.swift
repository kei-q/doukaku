
let field = [
    "         ",
    " ijkT    ",
    " hRSHU   ",
    " gQGBIV  ",
    " fPFACJW ",
    "  eOEDKX ",
    "   dNMLY ",
    "    cbaZ ",
    "         ",
]

class Solver {
    typealias InputType = String
    typealias OutputType = String
    
    func solve_(input:InputType) -> OutputType {
        var pos = (4,4)
        var result = "A"
        
        for c in input {
            var (y,x) = pos
            switch c {
            case "0": y-=1;
            case "1": x+=1;
            case "2": y+=1; x+=1;
            case "3": y+=1;
            case "4": x-=1;
            case "5": y-=1; x-=1;
            default: 0// nop;
            }
            
            let a = field[y]
            let c = a[advance(a.startIndex,x)]
            if c != " " {
                result.append(c)
                pos = (y,x)
            } else {
                let c : Character = "!"
                result.append(c)
            }
            
        }
        
        return result
    }
    
    func solve(input:String) -> String {
        return solve_(input)
    }
}

tests()
//t(2)
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
    return actual == expected
}

func tAll() -> Bool {
    let results = testData.map { (input,expected) in
        Solver().solve(input) == expected
    }
    return reduce(results, true) { (b,b_) in b && b_ }
}

// ここにテストをコピペする
// ---------------------------------------------

func tests() {
    /*0*/ test( "135004", "ACDABHS" );
    /*1*/ test( "1", "AC" );
    /*2*/ test( "33333120", "AENc!!b!M" );
    /*3*/ test( "0", "AB" );
    /*4*/ test( "2", "AD" );
    /*5*/ test( "3", "AE" );
    /*6*/ test( "4", "AF" );
    /*7*/ test( "5", "AG" );
    /*8*/ test( "4532120", "AFQPOEMD" );
    /*9*/ test( "051455", "ABSHSj!" );
    /*10*/ test( "23334551", "ADMb!cdeO" );
    /*11*/ test( "22033251", "ADLKLa!ML" );
    /*12*/ test( "50511302122", "AGSjkTHTU!VW" );
    /*13*/ test( "000051", "ABHT!!!" );
    /*14*/ test( "1310105", "ACDKJW!V" );
    /*15*/ test( "50002103140", "AGSk!HU!IVIU" );
    /*16*/ test( "3112045", "AEDKYXKC" );
    /*17*/ test( "02021245535", "ABCIJW!JIHBS" );
    /*18*/ test( "014204", "ABIBCIB" );
    /*19*/ test( "255230", "ADAGAEA" );
    /*20*/ test( "443501", "AFPefgQ" );
    /*21*/ test( "022321", "ABCKLZ!" );
    /*22*/ test( "554452", "AGRh!!Q" );
    /*23*/ test( "051024", "ABSHTUH" );
    /*24*/ test( "524002", "AGAFGSB" );
    /*25*/ test( "54002441132", "AGQRjSRhRSGA" );
    /*26*/ test( "11010554312", "ACJV!!UTkSHI" );
    /*27*/ test( "23405300554", "ADMNEFOFGRi!" );
    /*28*/ test( "555353201", "AGRih!gPQG" );
    /*29*/ test( "22424105", "ADLMabaLD" );
    /*30*/ test( "11340202125", "ACJKDCKJX!!J" );
    /*31*/ test( "4524451", "AFQFPf!P" );
    /*32*/ test( "44434234050", "AFPf!!e!!Pgh" );
    /*33*/ test( "00554040132", "ABHk!j!i!jRG" );
    /*34*/ test( "3440403", "AEOePfgf" );
    /*35*/ test( "111130", "ACJW!XW" );
    /*36*/ test( "21133343125", "ADKXYZ!a!Z!L" );
    /*37*/ test( "353511", "AEFOPFA" );
    /*38*/ test( "22204115220", "ADLZYLY!KY!X" );
    /*39*/ test( "03013541", "ABABICBGB" );
    /*40*/ test( "101344", "ACIVJCA" );
    /*41*/ test( "2432541", "ADENbNdN" );
    /*42*/ test( "45332242015", "AFQPedc!!NME" );
    /*43*/ test( "215453", "ADKCAGF" );
    /*44*/ test( "45540523454", "AFQh!i!RQg!!" );
    /*45*/ test( "42434302545", "AFEOd!!ONOef" );
}
