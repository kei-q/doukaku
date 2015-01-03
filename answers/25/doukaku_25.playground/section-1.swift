
func s2cs(input:String) -> [Character] {
    return map(input, {$0})
}

class Field {
    var cells : [[Character]]
    
    init() {
        cells = [
            s2cs("_______"),
            s2cs("_abcde_"),
            s2cs("_fghij_"),
            s2cs("_klmno_"),
            s2cs("_pqrst_"),
            s2cs("_uvwxy_"),
            s2cs("_______"),
        ]
    }
    
    func findPos(target:Character) -> (Int,Int)? {
        for (y,l) in enumerate(self.cells) {
            if let x = find(l, target) {
                return (y,x)
            }
        }
        return nil
    }
    
    func rotate(targets:[(Int,Int)]) {
        if targets.isEmpty {
            return
        }
        
        var tmp = self[targets[0]]
        for var i = 0; i<targets.count-1; i++ {
            self[targets[i]] = self[targets[i+1]]
        }
        self[targets.last!] = tmp
    }
    
    subscript(p:(Int,Int)) -> Character {
        get { return cells[p.0][p.1] }
        set { cells[p.0][p.1] = newValue }
    }
}

class Solver {
    let field = Field()
    
    func parse(input:String) -> [[Character]] {
        return split(input, { $0 == "," }).map({ s in map(s, { $0 }) })
    }
    
    func getRotateTarget(target:[Character]) -> (Int,Int,Int,Int) {
        let (y1,x1) = field.findPos(target[0])!
        let (y2,x2) = field.findPos(target[1])!

        return (min(y1,y2)-1,max(y1,y2)+1, min(x1,x2)-1, max(x1,x2)+1)
    }
    
    func collectPos(target:(Int,Int,Int,Int)) -> [(Int,Int)] {
        var targets : [(Int,Int)] = []

        func check(y:Int, x:Int) {
            if field[(y,x)] != "_" {
                targets.append((y,x))
            }
        }

        let (miny,maxy,minx,maxx) = target
        
        for var x = maxx; minx < x; x-- { check(miny, x) }
        for var y = miny; y < maxy; y++ { check(y, minx) }
        for var x = minx; x < maxx; x++ { check(maxy, x) }
        for var y = maxy; miny < y; y-- { check(y, maxx) }

        return targets
    }
    
    func collect(target:(Int,Int,Int,Int)) -> String? {
        var result = collectPos(target).map { p in self.field[p] }

        if result.isEmpty {
            return nil
        }
        
        sort(&result)
        return String(result)
    }

    // 一度実行するとfieldが破壊されてるので、
    // 必要なら新しいinstanceをつくるかfieldを初期化する
    func solve(input:String) -> String {
        var lastTarget = (0,0,0,0)
        for s in parse(input) {
            lastTarget = getRotateTarget(s)
            field.rotate(collectPos(lastTarget))
        }
        return collect(lastTarget) ?? "none"
    }
}

func test(input:String, expected:String) -> Bool {
    let actual = Solver().solve(input)
    return actual == expected
}
/*0*/ test( "ab,gg,uj,pt,an,ir,rr", "hpqsvwxy" );
/*
/*0*/ test( "ab,gg,uj,pt,an,ir,rr", "hpqsvwxy" );
/*1*/ test( "gs,ok", "abcdftvwxy" );
/*2*/ test( "gs,sg,ok", "none" );
/*3*/ test( "aa,bb,hh,nn", "hiostwxy" );
/*4*/ test( "ae,ko,uy,cw", "bdgilnqsvx" );
/*5*/ test( "am,gs,am,gs,am,gs,am,gs", "cfhkmqrvwx" );
/*6*/ test( "ay", "none" );
/*7*/ test( "gs,ay", "defjkoptuv" );
/*8*/ test( "bx,ay", "none" );
/*9*/ test( "ft,ay", "defjkoptuv" );
/*10*/ test( "ab,cd,ef,gh,ij,kl,mn,op,qr,st,uv,wx", "cdjmnry" );
/*11*/ test( "wx,uv,st,qr,op,mn,kl,ij,gh,ef,cd,ab", "kmoxy" );
/*12*/ test( "am,cj,ac,em,ss,cy,aa,ee,ff,vp", "none" );
/*13*/ test( "uf,oq,gn,ss,ca,hv,ej", "none" );
/*14*/ test( "cc,wk,uu,ws,bk,aa,vv", "bei" );
/*15*/ test( "tr,ou,ll,pp,jh,vf,yy,nr,rr,oo", "rxy" );
/*16*/ test( "ky,ov,ri,qm,nn,ee,ws,em,ca,ak", "biju" );
/*17*/ test( "ty", "nosx" );
/*18*/ test( "ll,uh,hq,ss,nx,ry,ku,ab,jj", "efouv" );
/*19*/ test( "yl,mu,qj,ss,ep", "mnqru" );
/*20*/ test( "kj,ee,qk", "fglruv" );
/*21*/ test( "xi,wd,hf", "ciknqr" );
/*22*/ test( "fx,ak,cc,ce", "bdhijnp" );
/*23*/ test( "li,jf,pp,qm,hg,sf", "akntuwx" );
/*24*/ test( "jw", "bcdeglqv" );
/*25*/ test( "uk,oe,xr", "dglmoqsy" );
/*26*/ test( "bb,ov,pd,dd,xk,is,hh,xd,xx,kq,pp,ku", "cfhjopqvy" );
/*27*/ test( "iq,fn,il,ww,ox,la,or,ga,wg,ef,us", "cfgjopvxy" );
/*28*/ test( "km,po", "abcdenqrst" );
/*29*/ test( "tc,mh,cw", "abefjkoptu" );
/*30*/ test( "fm,jx,xx,pi,gs,au,uq,ut,ap,vb", "cdghjmortux" );
/*31*/ test( "ik,xl,si", "abcdflorvwx" );
/*32*/ test( "nu,cc,lv,bu,tt,ww,xk,ia,in,sa,my", "abcefgpqrstu" );
/*33*/ test( "tt,ak,xh,tk,oo,yr,na,yv,gm,vh", "degiklmnquwx" );
/*34*/ test( "kk,ob,kk,fm,xk", "acdegjlopqruy" );
/*35*/ test( "uq,ko,pf,yy,ig,tu,ve,ve,qy,mh,oo,dv", "befjkoqrtuwxy" );
/*36*/ test( "aj,hb,ar,ii,np,ki,hg,vd", "cefhjlmopqtwxy" );
/*37*/ test( "vv,sf,ww,my,mm,sq,fb,ly,fu,ls", "bfghkmnptuvwxy" );
/*38*/ test( "jj,bp,gs", "abdefijkprtuvwxy" );
/*39*/ test( "sv,sn,mn,gn,gi", "abcdefhjnpqtuvxy" );
*/