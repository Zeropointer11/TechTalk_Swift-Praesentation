//: [Previous](@previous)
/*:
 ## Allgemeines von Swift
 
 Swift ist Type Save
 
 
 ### 1. Keywords
 #### Simple Values
 */
var myVariable = 42 // Variable
myVariable = 50
let myConstant = 42 // Constante

// implizite Typ bestimmung
let implicitInteger = 70
let implicitDouble = 70.0
// explizite Typ vergabe benötigt dann auch keine Komma angabe um sie als Double zu deklarieren
let explicitDouble: Double = 70

// Werte werden nie implizit zu anderen Typen Konvertiert
let label = "The width is "
let width = 94
let widthLabel = label + String(width)

// Werte in Strings einfüge
let apples = 3
let oranges = 5

// Multiline Strings
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""

// Arrays haben keine fixe Länge und wachsen automatisch wenn man Werte hinzufügt
var shoppingList = ["catfish", "water", "tulips"]
shoppingList[1] = "bottle of water"

// Dictionarys / Key:Value Pairs wachsen auch automatisch
var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"

// Leere Arrays und Dictionarys erzeugen mittels Typ angabe
let emptyArray = [String]()
let emptyDictionary = [String: Float]()

// Arrays und Dictionarys erzeugen wenn der Typ bereits bekannt ist
shoppingList = []
occupations = [:]

/*:
 ## Optionals
 
    Optionals sind variablen die den wert nil == NULL enthalten können
    Optionals werden mit ? gekennzeichnet
    Aufrufe auf nil variablen führen nicht zu einer Nullpointer Exception
 */
var optionalString: String? = nil
optionalString?.last
optionalString?.first
optionalString = "Hello!"
optionalString?.first // Optional<String>("H")
/*:
 ## Schleifen
 */
var counter = 0
let max = 100
for _ in 0...100 {
    counter += 1
}
print(counter)

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]

//Schleifen können mit Labes versehen werden
var largest = 0
outer: for (_, numbers) in interestingNumbers {
    inner: for number in numbers {
        if number > largest {
            largest = number
            if largest == 13 {
                break inner
            }
        }
    }
}
print(largest)
// Prints "25"

var n = 2
while n < 100 {
    n *= 2
}
print(n)
// Prints "128"

var m = 2
repeat {
    m *= 2
} while m < 100
print(m)
// Prints "128"


/*:
 ## Functions
 */

func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")

func greet(the person: String? = nil, on day: String) -> String {
    return "Hello \(person ?? "-"), today is \(day)."
}
greet(the: "John", on: "Wednesday")
greet(the: "Hans", on: "now")
greet(on: "now")

// nested Functions
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

// Funtion die eine Function zurückliefert
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number:Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)

// Function die eine Funktion als Parameter hat
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

//Funktionen können Return werte oder übergabe werte sein weil sie alle Closures sind

/*:
 ## Closures
    Was sind Closures?
    Closures sind self-contained blocks unter C als Blocks bekannt andere kennen sie unter lamdas
*/

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
print(reversedNames)
let backwardBlock = { (s1: String, s2: String) -> Bool in
    return s1 > s2
}
reversedNames = names.sorted(by: backwardBlock)
print(reversedNames)
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
print(reversedNames)
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
print(reversedNames)
reversedNames = names.sorted(by: { $0 > $1 } )
print(reversedNames)
reversedNames = names.sorted(by: >)
print(reversedNames)


/*:
 ## Enums
    In Objective-C nur Integer jetzt ohne speziellen Typ bis einer vergeben wird
    durch CaseIterable erstmals alle werte Loop bar ohne ein allCases zu erzeugen
 */
enum CompassPoint : CaseIterable {
    case north
    case south
    case east
    case west
}
var directionToHead = CompassPoint.west
directionToHead = .south
CompassPoint.allCases

// cases mit parameter
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

//: [Next](@next)
