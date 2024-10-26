// Note: This file is automatically generated.
//       It will be overwritten sooner or later.

import Testing
import SwiftGmp

@Test func largeTest() {
    let calculator = Calculator(precision: 20)

    calculator.displayWidth = 100
    calculator.setPrecision(newPrecision: 100)
    
    calculator.evaluateString("1e9")
    #expect(calculator.string == "1000000000")
    
    calculator.evaluateString("1e10")
    #expect(calculator.string == "1.0e10")
    
    calculator.evaluateString("1e11")
    #expect(calculator.string == "1.0e11")
    
    calculator.evaluateString("1e15")
    #expect(calculator.string == "1.0e15")
    
    calculator.evaluateString("1e18")
    print(calculator.raw)
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 18)
    
    calculator.evaluateString("1e21")
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 21)
    
    calculator.evaluateString("1e24")
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 24)
    
    calculator.evaluateString("1e48")
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 48)
    calculator.displayWidth = 10
    
    calculator.evaluateString("1e9")
    #expect(calculator.string == "1000000000")
    
    calculator.evaluateString("1e10")
    #expect(calculator.string == "1.0e10")
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 10)
    
    calculator.evaluateString("1e11")
    #expect(calculator.string == "1.0e11")
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 11)
    
    calculator.evaluateString("1e12")
    #expect(calculator.string == "1.0e12")
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 12)
    
    calculator.evaluateString("1e15")
    #expect(calculator.string == "1.0e15")
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 15)
    
    calculator.evaluateString("1e18")
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 18)
    
    calculator.evaluateString("1e21")
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 21)
    
    calculator.evaluateString("1e24")
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 24)
    
    calculator.evaluateString("1e48")
    #expect(calculator.raw.mantissa == "1")
    #expect(calculator.raw.exponent == 48)

    calculator.evaluateString("1e-20")
    #expect(calculator.string == "1.0e-20")


    calculator.displayWidth = 100
    calculator.evaluateString("1e48 + 1")
    #expect(calculator.raw.mantissa == "1000000000000000000000000000000000000000000000001")
    #expect(calculator.raw.exponent == 48)
    
    calculator.evaluateString("1e48+1-1e48")
    #expect(calculator.string == "1")
    
    calculator.evaluateString("1e68+2-1e68")
    #expect(calculator.string == "2")
    
    calculator.evaluateString("1e88+3-1e88")
    #expect(calculator.string == "3")
    
    calculator.displayWidth = 10
    calculator.evaluateString("55555.1234567890")
    #expect(calculator.string == "55555.1234")
    
    calculator.evaluateString("555555.1234567890")
    #expect(calculator.string == "555555.123")
    
    calculator.evaluateString("5555555.1234567890")
    #expect(calculator.string == "5555555.12")
    
    calculator.evaluateString("55555555.1234567890")
    #expect(calculator.string == "55555555.1")
    
    calculator.evaluateString("555555555.1234567890")
    #expect(calculator.string == "5.555555e8")
    #expect(calculator.raw.mantissa.starts(with: "5555555551"))
    #expect(calculator.raw.exponent == 8)
    
    calculator.evaluateString("5555555555.1234567890")
    #expect(calculator.string == "5555555555")
    calculator.evaluateString("55555555555.1234567890")
    #expect(calculator.string == "5.55555e10")
    calculator.evaluateString("555555555555.1234567890")
    #expect(calculator.string == "5.55555e11")
    calculator.evaluateString("5555555555555.1234567890")
    #expect(calculator.string == "5.55555e12")
    calculator.evaluateString("55555555555555.1234567890")
    #expect(calculator.string == "5.55555e13")
    calculator.displayWidth = 1000
    calculator.setPrecision(newPrecision: 1000)
    calculator.evaluateString("pi")
    #expect(calculator.string == "3.14159265")
    #expect(calculator.raw.mantissa == "3141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315588174881520920962829254091715364367892590360011330530548820466521384146951941511609433057270365759591953092186117381932611793105118548074462379962749567351885752724891227938183011949129833673362440656643086021394946395224737190702179860943702770539217176293176752384674818467669405132000568127145263560827785771342757789609173637178721468440901224953430146549585371050792279689258923542019956112129021960864034418159813629774771309960518707211349999998372978049951059731732816096318595024459455346908302642522308253344685035261931188171010003137838752886587533208381420617177669147303598253490428755468731159562863882353787593751957781857780532171226806613001927876611195909216420198")
    #expect(calculator.raw.exponent == 0)
    calculator.displayWidth = 4159
    calculator.setPrecision(newPrecision: 4159)
    calculator.evaluateString("sqrt(pi)")
    #expect(calculator.string == "1.77245385")
    #expect(calculator.raw.mantissa == "177245385090551602729816748334114518279754945612238712821380778985291128459103218137495065673854466541622682362428257066623615286572442260252509370960278706846203769865310512284992517302895082622893209537926796280017463901535147972051670019018523401858544697449491264031392177552590621640541933250090639840761373347747515343366798978936585183640879545116516173876005906739343179133280985484624818490205465485219561325156164746751504273876105610799612710721006037204448367236529661370809432349883166842421384570960912042042778577806869476657000521830568512541339663694465418151071669388332194292935706226886522442054214994804992075648639887483850593064021821402928581123306497894520362114907896228738940324597819851313487126651250629326004465638210967502681249693059542046156076195221739152507020779275809905433290066222306761446966124818874306997883520506146444385418530797357425717918563595974995995226384924220388910396640644729397284134504300214056423343303926175613417633632001703765416347632066927654181283576249032690450848532013419243598973087119379948293873011126256165881888478597787596376136321863424654664133395435570320152265419395218603049731051382949843965916561424595542122661510247853609809551039560078940218809961338285402501680074580272911936642519282051000193635007391464329549343395192885373545920056376650288054057553212318900912632281915091498083669562448310085222192397364632484286326114576693242537157737789441409054457359535122562639108023923690973212790580761713460391457479187979412485021844514581134188888041322095533218464670972749102856526270784545326222784880098238583630075495095476406237708338835722543662156748132766838424497242087451616183320507799148018466681423669365190284546385761482785703777438837629747998273770543158368241099868322850380552635536972229313380526442841037231204396700430761245413831179227827536371559839837688453702784298570709051122384053677901338541458531620807304313806973998743669316601381707927205604195488285806309311163629704786781402696327296270122613598589775450528948311301668400153207485198240246333755585171356801934122897598071956874025057150214178379254364303036592821125092588061890311707454312790395355366068261100118896574204872759391997699553835211508669625559644137050382924495359031063623453056471711621685872545868744002961175792172319055405719868172758841908964965790669651560172835148290385655116980721079533091613084359852438946544068216550032753799602386650379888648152118657999585718656377511331597475359604341377664511914346013429250811632480640907377321262933574747296767934127160296651208098980905779966030510218162555797890748707621107623802626785429701502710915350498535149239083248428082898759557567884889260842088552126951035737020866125911554132044037356086433883712396206429390237866631163261678884192279819499524039424578422044303042043042071096927339294608510496928973916185560783787033642890234293271887296802972158165942612972836639590504113037474574350974905801632691653757690981097485625377850342879942192237718584431832793731298006587036861923010217454505203084553303861950660236433411532059741224264265354216558150036472691946382544124557259473900719227187097960549897246028226024291050774020812375674807627637743706345046314773769480331683570762058749578173350996762873387396702968819066142614457371322822803935444608377601058646738943855776887203971767059273166300903112608144884308624114292247965454026163755158658735198437217550552729506415043576875838149359401055659121503770441973880370568097143463163605434136507669997576211981184258742252081404364062117230919743945524596778174219146433350671463646225947923194970034966025635210337806603805270316524545464736406208302982734943367284773530202247052900995698156705864039885636834956495288287851964475557425601459926852581856308538058155219970292348029482179570039295476876737874675614745450525851711675415202826622799977038693342250012297731621239492462707583316806464073929378457821418549833278676481879256795013284511260015478829830397094122795590273983121481454227018426602478198104333377295840025838886567683453330902961094998749374134782736346821466102487373043493685735064797943663991366663660331914")
    #expect(calculator.raw.exponent == 0)
}
