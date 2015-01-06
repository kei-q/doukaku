
import Foundation

class Cell {
    var value : Int = 0
    let id : Int
    var pos : (Int,Int)
    var size : (Int,Int) = (1,1)
    
    init (l:Int, t:Int, id:Int) {
        pos = (l,t)
        self.id = id
    }
}

class Field {
    var field : [[Cell]]
    let width : Int
    let height : Int
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        
        field = []
        var id = 0
        for i in 0..<height {
            var column : [Cell] = []
            for j in 0..<width {
                var cell = Cell(l:j,t:i,id:id)
                id += 1
                column.append(cell)
            }
            field.append(column)
        }
    }
    
    func combine(block:[Int]) {
        let l = block[0]
        let t = block[1]
        let w = block[2]
        let h = block[3]
        
        var cell = field[t][l]
        cell.size = (w,h)
        
        for y in t..<(t+h) {
            for x in l..<(l+w) {
                field[y][x] = cell
            }
        }
    }
    
    func calc() {
        calc_(width-1, y:height-1)
    }
    
    func calc_(x: Int, y:Int) {
        var cell = field[y][x]
        let l = cell.pos.0
        let t = cell.pos.1
        
        if l == 0 && t == 0 {
            field[0][0].value = 1
            return
        }

        
        if cell.value != 0 {
            return
        }
        
        var neighbors : [Int:Cell] = [:]
        // 左
        if l != 0 {
            let h = cell.size.1
            for y_ in t..<t+h {
                var cell_ = field[y_][l-1]
                neighbors[cell_.id] = cell_
            }
        }

        // 上
        if t != 0 {
            let w = cell.size.0
            for x_ in l..<l+w {
                var cell_ = field[t-1][x_]
                neighbors[cell_.id] = cell_
            }
        }
        

        for (_,v) in neighbors {
            calc_(v.pos.0, y:v.pos.1)
            cell.value += v.value
        }
    }
    
    func getResult() -> Int {
        return field[height-1][width-1].value
    }
}

typealias BlockSize = (left:Int, top:Int, width:Int, height:Int)
typealias InputType = (Int,Int,[[Int]])

class Solver {
    func deconstruct(n:Int) -> [Int] {
        let height = n % 10
        let width = (n / 10) % 10
        let top = (n / 100) % 10
        let left = (n / 1000) % 10
        return [left, top, width, height]
    }
    
    func parse(input:String) -> InputType {
        let s : [String] = input.componentsSeparatedByString(":")
        let a : [String] = s[0].componentsSeparatedByString("x")
        let w : Int = a[0].toInt()!
        let h : Int = a[1].toInt()!
        let s_blocks : [String] = split(s[1], {$0==","})
        let blocks = s_blocks.map { s_ in self.deconstruct(s_.toInt()!) }
        return (w,h,blocks)
    }

    func solve_(input:InputType) -> Int {
        let (w,h,blocks) = input
        var field = Field(width: w, height: h)
        for block in blocks {
            field.combine(block)
        }
        field.calc()
        return field.getResult()
    }
    
    func solve(input:String) -> String {
        let result = solve_(parse(input))
        return NSString(format: "%02d", result % 100)
    }
}

func test(input:String, expected:String) -> Bool {
    let actual = Solver().solve(input)
    return actual == expected
}

/*0*/ test( "8x6:6214,3024,5213,5022,0223,7115", "32" );
/*1*/ test( "1x1:", "01" );
/*2*/ test( "2x3:", "03" );
/*3*/ test( "9x7:", "03" );
/*4*/ test( "2x3:0021", "03" );
/*5*/ test( "2x3:1012", "03" );
/*6*/ test( "2x3:0022", "02" );
/*7*/ test( "9x9:1177", "98" );
/*8*/ test( "7x7:2354", "02" );
/*9*/ test( "3x6:1121,0333", "12" );
/*10*/ test( "8x1:4031,0031", "01" );
/*11*/ test( "8x2:3141,5031", "07" );
/*12*/ test( "1x6:0213,0012", "01" );
/*13*/ test( "3x3:1221,0021,0131", "04" );
/*14*/ test( "9x2:1042,8012,6012", "18" );
/*15*/ test( "3x6:0024,0432,2013", "03" );
/*16*/ test( "4x3:1131,0221,2021", "10" );
/*17*/ test( "8x4:3252,2121,6021", "48" );
/*18*/ test( "3x3:2112,0022,0221", "03" );
/*19*/ test( "9x9:1019,3019,5019,7019", "25" );
/*20*/ test( "4x3:3112,0013,1122,2021", "04" );
/*21*/ test( "4x8:1513,2028,0025,0612", "04" );
/*22*/ test( "9x6:2262,5432,8014,3151", "39" );
/*23*/ test( "5x2:2012,3121,3021,0121", "06" );
/*24*/ test( "3x4:1321,1121,1221,0012", "05" );
/*25*/ test( "5x3:0112,1122,4013,0041", "09" );
/*26*/ test( "8x7:3552,3451,5031,0162", "95" );
/*27*/ test( "9x9:2234,8412,0792,6421,1681", "52" );
/*28*/ test( "4x7:0532,1012,3014,3512,2213", "60" );
/*29*/ test( "8x5:4342,3033,0033,6122,1332", "08" );
/*30*/ test( "6x7:1431,3331,1621,2531,4621", "36" );
/*31*/ test( "4x9:1324,3116,0013,2722,2013,0712", "67" );
/*32*/ test( "7x6:3241,4531,1412,0214,3012,5321", "54" );
/*33*/ test( "2x9:1412,0021,0117,0821,1113,1612", "05" );
/*34*/ test( "9x9:2544,6034,1342,6524,0523,4022", "99" );
/*35*/ test( "5x6:0422,4113,2022,2313,4412,2221", "20" );
/*36*/ test( "7x4:6212,0012,6012,2331,3023,0321", "10" );
/*37*/ test( "4x4:3012,1321,2221,0212,0012,1022", "11" );
/*38*/ test( "5x7:1132,1332,0312,4013,0641,4512", "77" );
/*39*/ test( "5x5:0341,3221,3421,0221,1421,0151,1041", "54" );
/*40*/ test( "9x9:6224,5642,0643,0333,3422,1033,4122", "36" );
/*41*/ test( "6x8:0055,1642,5513,0531,5013,5312,0612", "12" );
/*42*/ test( "9x9:4232,1465,7326,3042,1123,7122,0514,7021", "34" );
/*43*/ test( "8x9:0361,5732,6413,0431,7313,1722,2141,3524,7112", "22" );
/*44*/ test( "8x6:6422,1053,6122,1422,3333,6021,0412,0013,6321", "22" );
/*45*/ test( "9x9:3324,5217,8116,2312,7314,6414,3061,7721,1231,1514,3712", "17" );
/*46*/ test( "9x9:7424,4423,0227,3722,4053,2324,5722,2013,7821,6321,2712,6512", "39" );
/*47*/ test( "8x7:5422,6022,2262,1522,3422,0122,0322,2032,6621,4621,0512,7412,5012", "06" );
