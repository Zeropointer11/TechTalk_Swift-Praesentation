//: [Previous](@previous)
/*:
 ## Eigenheiten von Swift
 */
/*:
 ### Optimirungen
    struct vs class
 
    struct's sind am Stack
    classes sind am Heap
 
    Classes sind Reference Types
    Struct's sind Value Types (werden kopiert wenn sie auf Variablen oder Kostanten zugewiesen werden)
 
    Vorteile von class gegenüber struckt:
    Vererbung, Type Casting, Deinitializers und Reference Counter (Pointer)
 
 */

struct AStruct {
    var test : Int
}
let aStruct = AStruct(test: 9)
let bStruckt = aStruct

class AClass {
    init() {
        
    }
    deinit {
    }
}
let aClass = AClass()
let bClass = aClass

aClass === bClass // vergleich auf selbe Reference

/*:
 ## Property Observers
 */
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
    
    private var _stepsToday : Int = 0
    var stepsToday : Int {
        get {
            return _stepsToday
        }
        set {
            _stepsToday = newValue
        }
    }
    
    var test : Int {
        return 5
    }
}

/*:
 ## Extensions
 */

extension Double {
    //Extensions können Funktionen und Computed Propertys enthalten aber keine Werte Speichern
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"


/*:
 ## Automatic Reference Counting
    ARC != Garbage Collector
 
    Jedes Mal, wenn Sie eine neue Instanz einer Klasse erstellen,
    erstellt ARC einen chunk zu dieser Instanz zu.
    Dieser Chunk enthält Informationen zum Typ der Instanz sowie
    die Werte aller gespeicherten Eigenschaften,
    die dieser Instanz zugeordnet sind.
 
    Worauf dennoch zu achten ist sind Retain Cycles
    z.B. ClassA hält strong Reference von ClassB
    und ClassB hält strong Reference von ClassA
    somit wird der Speicher nie Freigegeben
 */
class ClassA {
    var strongB : ClassB
    init(strongB : ClassB) {
        self.strongB = strongB
        self.strongB.strongA = self
    }
}
class ClassB {
    var strongA : ClassA?
    weak var weakA : ClassA?
}

var classB = ClassB()
var classA = ClassA(strongB: classB)

classB.strongA = nil

/*:
 ## Pyramid of Doom in Swift
 
    Durch Unwrapping entstehen sehr viele if Verschachtelungen zusammen
    Swift hat hier einige alternativen geschaffen


 ### Pyramid of Doom
*/
var first = 5
var second = 8
var third : Int? = 3

if first < second {
    if let _third = third {
        if _third < second {
            print("here")
        }
    }
    else {
        print("third == nil")
    }
}
//: ### Logic operator
if first < second && ((third ?? 0) < second) {
    print("here")
}
//: ### Swift optimized way
if first < second,
    let _third = third,
    _third < second {
    print("here")
}
/*:
 ### guard
 guard ist eine early Exit if dessen Else Zweig eine Exit Bedingung benötig
 */

func check() -> String {
    guard first < second,
        let _third = third,
        _third < second
        else {
            return "not here"
    }
    return "here"
}
print(check())

guard first < second else {
    fatalError("exit")
}
//: [Next](@next)
