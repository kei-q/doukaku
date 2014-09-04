import Data.List (sort)
import Test.HUnit
main=getContents>>=runTestTT.test.map((\(a,b)->s a~?=b).i.words).lines
i(c:s)=(map t s,c) where t u=read u`divMod`10
s=maybe"-"id.flip lookup p.c
c t=sort[(a-c)^2+(b-d)^2|[(a,b),(c,d)]<-sequence[t,t]]
p=map((\(a,b)->(c a,b)).i.words)["L 00 01 02 10","I 00 01 02 03","T 00 01 02 11","O 00 01 10 11","S 00 01 11 12"]
