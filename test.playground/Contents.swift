var jd : [Double] = [2457480.5,2376512.5,2378443.5,2379852.5,2376934.5,2446051.5,2445398.5,2436707.5,2436579.5]

var nomjour: [String] = ["Samedi","Dimanche", "Samedi",   "Lundi",    "Mardi",    "Lundi",    "Samedi",   "Mardi",    "Dimanche"]

var jour: [Int] = [2,  27, 9,  19, 22, 17, 5,  19, 11]

var mois: [Int] = [4, 7, 11, 9, 9, 12, 3, 5, 1]

var annee: [Int] = [2016, 1794, 1799, 1803, 1795, 1984, 1983, 1959, 1959]

func leap_gregorian(_ year : Int)
{
    return ((year % 4) == 0) && (!(((year % 100) == 0) && ((year % 400) != 0)))
}



var GREGORIAN_EPOCH = 1721425.5

var FRENCH_REVOLUTIONARY_EPOCH = 2375839.5


func gregorian_to_jd(year: Int, month: Int, day: Int) -> Double
{
    return (GREGORIAN_EPOCH - 1) +
           (365 * (year - 1)) +
           (year - 1) / 4 +
           (-(year - 1) / 100) +
           (year - 1) / 40) +
           (((367 * month) - 362) / 12 +
           ((month <= 2) ? 0 : (leap_gregorian(year) ? -1 : -2)) + day)
}

func french_revolutionary_to_jd(an: Int, mois: Int, decade: Int, jour: Int)
{
    // var adr, equinoxe, guess, jd
    
    var guess: Double = FRENCH_REVOLUTIONARY_EPOCH + (TropicalYear * Double(((an - 1) - 1)))
    
    adr = new Array(an - 1, 0);
    
    while (adr[0] < an) {
        adr = annee_de_la_revolution(guess);
        guess = adr[1] + (TropicalYear + 2);
    }
    equinoxe = adr[1];
    
    jd = equinoxe + (30 * (mois - 1)) + (10 * (decade - 1)) + (jour - 1);
    return jd;
}



func annee_de_la_revolution(jd: Double)
{
    var guess = jd_to_gregorian(jd)[0] - 2,
        lasteq, nexteq, adr;

    lasteq = paris_equinoxe_jd(guess);
    while (lasteq > jd) {
        guess--;
        lasteq = paris_equinoxe_jd(guess);
    }
    nexteq = lasteq - 1;
    while (!((lasteq <= jd) && (jd < nexteq))) {
        lasteq = nexteq;
        guess++;
        nexteq = paris_equinoxe_jd(guess);
    }
    adr = Math.round((lasteq - FRENCH_REVOLUTIONARY_EPOCH) / TropicalYear) + 1;

    return new Array(adr, lasteq);
}


mod(655087,146097) -> 70699



jd : 2379852.5

jd 3 avril 2016 : 2457481.5 depoch : 736056



func jd_to_gregorian(jd: Double) {

    var wjd : Double = Math.floor(jd - 0.5) + 0.5
    var depoch: Double = wjd - GREGORIAN_EPOCH
    var quadricent: Double = Math.floor(depoch / 146097)
    var dqc: Int = mod(depoch, 146097);
    cent: Int = Math.floor(dqc / 36524);
    dcent = mod(dqc, 36524);
    quad = Math.floor(dcent / 1461);
    dquad = mod(dcent, 1461);
    yindex = Math.floor(dquad / 365);
    year = (quadricent * 400) + (cent * 100) + (quad * 4) + yindex;
    if (!((cent == 4) || (yindex == 4))) {
        year++;
    }
    yearday = wjd - gregorian_to_jd(year, 1, 1);
    leapadj = ((wjd < gregorian_to_jd(year, 3, 1)) ? 0 : (leap_gregorian(year) ? 1 : 2));
    month = Math.floor((((yearday + leapadj) * 12) + 373) / 367);
    day = (wjd - gregorian_to_jd(year, month, 1)) + 1;

    return new Array(year, month, day);
}


func paris_equinoxe_jd(year: Int) -> Double
{
    return = equiTab[year - 1789]
}

