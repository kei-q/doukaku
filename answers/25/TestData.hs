module TestData(tests) where

import Test.Hspec
import Solver (solve)

test (input, expected) = it input $ solve input `shouldBe` expected

tests = do {
test( "ab,gg,uj,pt,an,ir,rr", "hpqsvwxy" );
test( "gs,ok", "abcdftvwxy" );
test( "gs,sg,ok", "none" );
test( "aa,bb,hh,nn", "hiostwxy" );
test( "ae,ko,uy,cw", "bdgilnqsvx" );
test( "am,gs,am,gs,am,gs,am,gs", "cfhkmqrvwx" );
test( "ay", "none" );
test( "gs,ay", "defjkoptuv" );
test( "bx,ay", "none" );
test( "ft,ay", "defjkoptuv" );
test( "ab,cd,ef,gh,ij,kl,mn,op,qr,st,uv,wx", "cdjmnry" );
test( "wx,uv,st,qr,op,mn,kl,ij,gh,ef,cd,ab", "kmoxy" );
test( "am,cj,ac,em,ss,cy,aa,ee,ff,vp", "none" );
test( "uf,oq,gn,ss,ca,hv,ej", "none" );
test( "cc,wk,uu,ws,bk,aa,vv", "bei" );
test( "tr,ou,ll,pp,jh,vf,yy,nr,rr,oo", "rxy" );
test( "ky,ov,ri,qm,nn,ee,ws,em,ca,ak", "biju" );
test( "ty", "nosx" );
test( "ll,uh,hq,ss,nx,ry,ku,ab,jj", "efouv" );
test( "yl,mu,qj,ss,ep", "mnqru" );
test( "kj,ee,qk", "fglruv" );
test( "xi,wd,hf", "ciknqr" );
test( "fx,ak,cc,ce", "bdhijnp" );
test( "li,jf,pp,qm,hg,sf", "akntuwx" );
test( "jw", "bcdeglqv" );
test( "uk,oe,xr", "dglmoqsy" );
test( "bb,ov,pd,dd,xk,is,hh,xd,xx,kq,pp,ku", "cfhjopqvy" );
test( "iq,fn,il,ww,ox,la,or,ga,wg,ef,us", "cfgjopvxy" );
test( "km,po", "abcdenqrst" );
test( "tc,mh,cw", "abefjkoptu" );
test( "fm,jx,xx,pi,gs,au,uq,ut,ap,vb", "cdghjmortux" );
test( "ik,xl,si", "abcdflorvwx" );
test( "nu,cc,lv,bu,tt,ww,xk,ia,in,sa,my", "abcefgpqrstu" );
test( "tt,ak,xh,tk,oo,yr,na,yv,gm,vh", "degiklmnquwx" );
test( "kk,ob,kk,fm,xk", "acdegjlopqruy" );
test( "uq,ko,pf,yy,ig,tu,ve,ve,qy,mh,oo,dv", "befjkoqrtuwxy" );
test( "aj,hb,ar,ii,np,ki,hg,vd", "cefhjlmopqtwxy" );
test( "vv,sf,ww,my,mm,sq,fb,ly,fu,ls", "bfghkmnptuvwxy" );
test( "jj,bp,gs", "abdefijkprtuvwxy" );
test( "sv,sn,mn,gn,gi", "abcdefhjnpqtuvxy" );
}