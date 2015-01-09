// 最初にtestが全部通るまで49分

import Foundation

class Schedule {
    typealias Section = (Int,Int)
    var sections : [Section] = []
    
    func add(section:Section) {
        sections.append(section)
        sort(&sections, { (a, b) -> Bool in
            a.0 < b.0
        })
    }
    
    func sub_(section:Section, subSection:Section) -> [Section] {
        var ret : [Section] = []
        if section.0 < subSection.0 {
            let t : Section = (section.0, min(section.1, subSection.0))
            ret.append(t)
        }
        if subSection.1 < section.1 {
            let t : Section = (max(section.0, subSection.1), section.1)
            ret.append(t)
        }
        return ret
    }
    
    func sub(section_:Section) {
        let a = sections.map { section in
            self.sub_(section, subSection:section_)
        }
        sections = [].join(a)
    }
    
    func enableTime() -> Section? {
        let target = sections.filter { (a) -> Bool in
            a.1 - a.0 >= 100
        }
        
        if target.isEmpty {
            return nil
        } else {
            let s : Section = target.first!
            let t : Int = s.0
            return (t,t+100)
        }
    }
    
    func copy() -> Schedule {
        var newInstance = Schedule()
        newInstance.sections = Array<Section>(self.sections)
        return newInstance
    }
}

class Solver {
    typealias InputType = [(String,(Int,Int))]
    typealias OutputType = (Int,Int)
    
    func parse(input:String) -> InputType {
        let a = input.componentsSeparatedByString(",")
        return map(a) { (s:String) -> (String,(Int,Int)) in
            let u = s.substringToIndex(advance(s.startIndex,1))
            let c = s.substringWithRange(advance(s.startIndex,1)..<s.endIndex)
            let d = c.componentsSeparatedByString("-")
            return (u, (d[0].toInt()!,d[1].toInt()!))
        }
    }
    
    func format(result:OutputType?) -> String {
        if let r = result {
            return "\(r.0)-\(r.1)"
        } else {
            return "-"
        }
    }
    
    func solve_(input:InputType) -> OutputType? {
        let z = Schedule()
        let zSections = input.filter { (u, s) -> Bool in u == "Z" }
        for s in zSections { z.add(s.1) }
        for s in [(0,1000),(1800,2400)] { z.sub(s) }

        let aSections = input.filter { (u, s) -> Bool in u == "A" }
        for s in aSections { z.sub(s.1) }
        
        let bSections = input.filter { (u, s) -> Bool in u == "B" }
        for s in bSections { z.sub(s.1) }
        
        let z_ = z.copy()
        
        let iSections = input.filter { (u, s) -> Bool in u == "I" }
        for s in iSections { z.sub(s.1) }

        let jSections = input.filter { (u, s) -> Bool in u == "J" }
        for s in jSections { z_.sub(s.1) }
        
        let t1 = z.enableTime()
        let t2 = z_.enableTime()
        
        if t1 == nil && t2 == nil {
            return nil
        } else if t1 != nil && t2 == nil {
            return t1!
        } else if t1 == nil && t2 != nil {
            return t2!
        } else {
            return t1!.0 < t2!.0 ? t1! : t2!
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

    /*0*/ test( "A1050-1130,B1400-1415,I1000-1400,I1600-1800,J1100-1745,Z1400-1421,Z1425-1800", "1425-1525" );
    /*1*/ test( "A1000-1200,B1300-1800,Z1000-1215,Z1230-1800", "-" );
/*
    /*2*/ test( "Z0800-2200", "1000-1100" );
    /*3*/ test( "A1000-1700,Z0800-2200", "1700-1800" );
    /*4*/ test( "A1000-1701,Z0800-2200", "-" );
    /*5*/ test( "A1000-1130,B1230-1800,Z0800-2200", "1130-1230" );
    /*6*/ test( "A1000-1129,B1230-1800,Z0800-2200", "1129-1229" );
    /*7*/ test( "A1000-1131,B1230-1800,Z0800-2200", "-" );
    /*8*/ test( "A1000-1130,B1229-1800,Z0800-2200", "-" );
    /*9*/ test( "A1000-1130,B1231-1800,Z0800-2200", "1130-1230" );

    /*10*/ test( "A1000-1130,B1230-1800,Z0800-1130,Z1131-2200", "-" );
    /*11*/ test( "A1000-1130,B1231-1800,Z0800-1130,Z1131-2200", "1131-1231" );
    /*12*/ test( "Z0800-0801", "-" );
    /*13*/ test( "Z0800-1031,Z1129-1220,Z1315-1400,Z1459-1600", "1459-1559" );
    /*14*/ test( "Z0800-2200,I1000-1600,J1030-1730", "1600-1700" );
    /*15*/ test( "Z0800-2200,I1000-1600,J1130-1730", "1000-1100" );
    /*16*/ test( "Z0800-2200,I1000-1600,J1130-1730,A0800-1025", "1025-1125" );
    /*17*/ test( "Z0800-2200,I1000-1600,J1130-1730,A0800-1645", "1645-1745" );
    /*18*/ test( "Z0800-2200,I1000-1600,J1130-1730,A0800-1645,I1735-2200", "-" );
    /*19*/ test( "Z0800-2200,I1000-1600,J1130-1730,A0800-1645,J1735-2200", "1645-1745" );
    /*20*/ test( "Z1030-2200,I1000-1600,J1130-1730", "1030-1130" );
    /*21*/ test( "Z1035-1500,I1000-1600,J1130-1730,Z1644-2200", "1644-1744" );
    /*22*/ test( "I2344-2350,A2016-2253,Z1246-1952", "1246-1346" );
    /*23*/ test( "Z2155-2157,B1822-2032,Z1404-2000,Z2042-2147,Z2149-2154", "1404-1504" );
    /*24*/ test( "Z2231-2250,Z2128-2219,B2219-2227,B2229-2230,Z0713-2121,A0825-1035,B1834-2001", "1035-1135" );
    /*25*/ test( "J0807-1247,I0911-1414,B1004-1553,Z0626-1732,Z1830-1905,A1946-1954,A0623-1921", "-" );
    /*26*/ test( "J1539-1733,J0633-1514,Z1831-1939,J1956-1959,I0817-1007,I1052-1524,Z1235-1756,Z0656-1144", "1524-1624" );
    /*27*/ test( "Z2319-2350,B0833-2028,I2044-2222,A1410-2201,Z2044-2228,Z0830-2023,Z2242-2306,I2355-2359", "-" );
    /*28*/ test( "B2001-2118,Z0712-1634,I1941-2102,B1436-1917", "1000-1100" );
    /*29*/ test( "A0755-1417,B2303-2335,Z0854-2150,Z2348-2356,Z2156-2340,I1024-1307,Z2357-2359", "1417-1517" );
    /*30*/ test( "A1958-1959,B0822-1155,I1518-1622,Z1406-1947,A1800-1822,A0904-1422,J1730-1924,Z1954-1958,A1946-1956", "1422-1522" );
    /*31*/ test( "B1610-1910,I2121-2139,A0619-1412,I2147-2153,Z0602-2111,I0841-2031,A1657-1905,A1956-2047,J0959-1032,Z2131-2147", "1412-1512" );
    /*32*/ test( "Z0623-1900,A0703-1129,I1815-1910,J1956-1957,I0844-1518,Z1902-1935,B1312-1342,J1817-1955", "1129-1229" );
    /*33*/ test( "J1246-1328,B1323-1449,I1039-1746,Z1218-2111", "1449-1549" );
    /*34*/ test( "A1958-1959,I1943-1944,I0731-1722,Z0845-1846,J1044-1513,Z1910-1923,B1216-1249", "1513-1613" );
    /*35*/ test( "A1855-2047,Z0946-1849,Z2056-2059,I1855-1910,B1946-2058,I1956-2025,Z1905-2054,J0644-1800,I0720-1618", "1618-1718" );
    /*36*/ test( "J1525-1950,Z0905-1933,A1648-1716,I2051-2054,I2015-2044,I0804-1958,B0934-1100,Z1953-2037", "1100-1200" );
    /*37*/ test( "Z1914-1956,J0823-1610,Z0641-1841,J1800-1835,A0831-1346,I1926-1941,I1030-1558,I1738-1803", "1558-1658" );
    /*38*/ test( "Z0625-1758,J1033-1351,B1816-2236,I0838-1615,J2247-2255", "1351-1451" );
    /*39*/ test( "J0603-1233,A1059-1213,I1326-2103,Z0710-1459", "1213-1313" );
    /*40*/ test( "B1302-1351,J1410-2038,A0755-1342,J0637-0658,Z2148-2159,Z1050-2131,A1543-1844,I1615-1810", "1351-1451" );
    /*41*/ test( "Z0746-2100,A2122-2156,I1022-1144,J0947-1441,A1333-1949", "1144-1244" );
    /*42*/ test( "J0718-1243,Z1443-1818,B2055-2057,A0714-1238,Z1045-1344,A1643-1717,B1832-2039,J1623-1931", "1238-1338" );
    /*43*/ test( "Z1921-1933,A1208-1418,I0827-1940,Z0757-1917,J0653-1554,B1859-1909", "1554-1654" );
*/