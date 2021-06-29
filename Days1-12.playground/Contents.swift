import UIKit

// MARK: Day 1 - variables

var greeting = "Hello, playground"

greeting = "Goodbye"

var multilineWithNewLines = """
    This goes
    over multiple
    lines
    """

var multilineOneLine = """
    This goes \
    over multiple \
    lines
    """

let singleQuoteString = "hi"


// MARK: DAY 2 - arrays, dictionaries, sets, & enums

// array - whatever you want, addressable by index
let beatles = ["john", "paul", "george", "ringo"]

// set - unique, unordered values
let colors = Set(["red", "green", "blue", "red", "blue"])
print(colors)

// tuples - complex, fixed-in-size values
let name = (first: "Taylor", last: "Swift")
print(name.first)

// dictionaries - collections of values, addressable by key
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
print(heights["Ryan Token", default: 1.00])

// empty collections
let emptyArray = [Int]()
let emptySet = Set<Int>()
let emptyDict = [String: String]()

// enumerations
enum Result {
    case success
    case failure(reason: String)
}
print(Result.success)
print(Result.failure(reason: "Swift is hard"))


// MARK: DAY 3 - operators and conditions

// comparison operators
print("Taylor" >= "Swift")

// ternary operator
let firstCard = 11
let secondCard = 10
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")

// switch
let weather = "sunny"
switch weather {
case "rainy":
    print("Bring an umbrella")
case "snowy":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}

// range operators - ..< excludes final value. ... includes final value
let score = 85
switch score {
case 0..<50:
    print("You failed badly")
case 50..<85:
    print("You did OK")
default:
    print("You did great!")
}


// MARK: DAY 4 - loops

// for loops
let count = 1...10
for number in count {
    print("Number is \(number)")
}

// if you don't use the constant that for loops give you, you should use an underscore instead so that Swift doesn't create needless values
print("Players gonna ")
for _ in 1...5 {
    print("play")
}

// while loops
var number = 1
while number <= 20 {
    print(number)
    number += 1
}

// repeat loops - similar to do/while. always executed at least once
repeat {
    print(number)
    number += 1
} while number <= 20

// exiting loops
var countdown = 10
while countdown >= 0 {
    print(countdown)
    
    if countdown == 4 {
        print("I'm bored. Let's go now!")
        break
    }
    
    countdown -= 1
}

// exiting multiple/nested loops
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
        
        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

// skipping items - the continue keyword
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    
    print(i)
}

// infinite loops - just use while true as your conditions because true is always true
var counter = 0
while true {
    print(" ")
    counter += 1
    
    if counter == 273 {
        break
    }
}


// MARK: Day 5 - functions, parameters, & errors

// basic function
func square(number: Int) -> Int {
    return number * number
}
let result = square(number: 8)
print(result)

// parameter lables - external and internal
func sayHello(to name: String) {
    print("Hello, \(name)")
}
sayHello(to: "Taylor")

// omitting parameter lables
func greet(_ person: String) {
    print("Hello \(person)")
}
greet("Taylor")

// default parameters
func greet2(_ person: String, nicely: Bool = true) {
    if nicely {
        print("Hello, \(person)")
    } else {
        print("Oh no, it's \(person) again")
    }
}
greet2("Taylor")
greet2("Taylor", nicely: false)

// variadic functions - functions that can accept any number of parameters (of the same type)
func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
square(numbers: 1, 2, 3, 4 ,5)

// throwing errors
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

// inout parameters - parameters that can change within the function

func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)


// MARK: Day 6 - Closures (part 1)

// basic closure
let driving = {
    print("I'm driving")
}
driving()

// closure with parameters
let driving2 = { (place: String) in
    print("I'm driving to \(place)")
}
driving2("Texas")

// closure with return
let driving3 = { (place: String) -> String in
    return "I'm driving to \(place)"
}
let message = driving3("Missouri")
print(message)

// closures as parameters into functions
func travel(action: () -> Void) {
    print("I'm getting ready to go")
    action()
    print("I've arrived")
}
travel(action: driving)

// trailing closure syntax
travel {
    print("I'm driving in my car")
}


// MARK: Day 7 - Closures (part 2)

// using closures as parameters when they accept parameters
func travel2(action: (String) -> Void) {
	print("I'm getting ready to go")
	action("London")
	print("I arrived!")
}

travel2 { (place: String) in
	print("I'm going to \(place) in my car")
}

// using closures as parameters when they return values
func travel3(action: (String) -> String) {
	print("I'm getting ready to go")
	let description = action("London")
	print(description)
	print("I arrived!")
}

travel3 { (place: String) -> String in
	return "I'm going to \(place) in my car"
}

// shorthand parameter names
travel3 { place in
	return "I'm going to \(place) in my car"
}

travel3 {
	"I'm going to \($0) in my car"
}

// closures with multiple parameters
func travel4(action: (String, Int) -> String) {
	print("I'm getting ready to go")
	let description = action("London", 60)
	print(description)
	print("I arrived!")
}

travel4 {
	"I'm going to \($0) at \($1) miles per hour" // $0 and $1 are the String and Int params, respectively
}

// returning closures from functions
func travel5() -> (String) -> Void {
	return {
		print("I'm going to \($0)")
	}
}

let results = travel5()
results("London")

// capturing values within a closure
func travel6() -> (String) -> Void {
	var counter = 1
	
	return {
		print("I'm going to \($0)")
		counter += 1
		print(counter) // counter will keep going up every time we call the closure below
	}
}

let resulty = travel6()
resulty("London")

resulty("London")
resulty("London")
resulty("London")


// MARK: Day 8 - structs (part 1)

// creating structs
struct Sport {
	var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name)

tennis.name = "Basketball"

// computed properties
struct Sport2 {
	var name: String
	var isOlympicSport: Bool
	
	var olympicStatus: String {
		if isOlympicSport {
			return "\(name) is an Olympic sport"
		} else {
			return "\(name) is not an Olympic sport"
		}
	}
}

let chessBoxing = Sport2(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

// property observers
struct Progress {
	var task: String
	var amount: Int {
		didSet { // event triggers every time the amount property changes
			print("\(task) is now \(amount)% complete")
		}
		// willSet triggers right *before* a property changes
	}
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

// struct methods
struct City {
	var population: Int
	
	func collectTaxes() -> Int {
		return population * 1000
	}
}

let london = City(population: 9_000_000)
london.collectTaxes()

// mutating methods
struct Person {
	var name: String
	
	mutating func makeAnonymous() {
		name = "Anonymous"
	}
}

var person = Person(name: "Ed")
person.makeAnonymous()

// properties and methods of strings
// - Strings are structs!
let string = "Do or do not, there is no try."

print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())

// properties and methods of arrays
// - Arrays are structs too!
var toys = ["Woody"]

print(toys.count)
toys.append("Buzz")
toys.firstIndex(of: "Buzz")
print(toys.sorted())
toys.remove(at: 0)


// MARK: Day 9 - structs (part 2)

// initializers
struct User {
	var username: String
	
	init() {
		username = "Anonymous"
		print("Creating a new user!")
	}
}

var user = User()
user.username = "twostraws"

// referring to the current instance
struct Person2 {
	var name: String
	
	init(name: String) {
		print("\(name) was born!")
		self.name = name
	}
}

// lazy properties
struct FamilyTree {
	init() {
		print("Creating family tree!")
	}
}

struct Person3 {
	var name: String
	lazy var familyTree = FamilyTree() // familyTree doesn't get created until it's accessed at least once
	
	init(name: String) {
		self.name = name
	}
}

var ed = Person3(name: "Ed")
ed.familyTree

// static properties and methods - shared across ALL instances of the struct
// static properties belong to the structs itself, not individual instances of the struct
struct Student {
	static var classSize = 0
	var name: String
	
	init(name: String) {
		self.name = name
		Student.classSize += 1
	}
}

let eddy = Student(name: "Eddy")
let taylor = Student(name: "Taylor")

print(Student.classSize)

// access control
struct Person4 {
	private var id: String // now only methods inside this Person4 struct can read the id property
	// public is another common option - lets all other code use the property or method
	
	init(id: String) {
		self.id = id
	}
	
	func identify() -> String {
		return "My social security number is \(id)"
	}
}

let edd = Person4(id: "12345")
edd.identify()


// MARK: Day 10 - Classes

// creating classes - they have no memberwise initializer like structs, so you must create one with init()
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

// class inheritance
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

// overriding methods
class Dog2 {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodle2: Dog2 {
    override func makeNoise() {
        print("Yip!")
    }
}

let popp = Poodle2()
popp.makeNoise()

// final classes - prevent subclassing on a class
final class FinalDog {
    // properties
    
    // init()
}

// copying objects
// - When you copy a struct, both the original and the copy are different objects
// - When you copy a class, both point to the same object, so they change together
// - Structs are like Word documents, Classes are like Google Docs
class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"

print(singer.name)

// deinitializers - code that gets run when an instance of a class is destroyed
class PersonWithDeinitializer {
    var name = "John Doe"
    
    init() {
        print("\(name) is alive!")
    }
    
    func printGreeting() {
        print("Hello I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = PersonWithDeinitializer()
    person.printGreeting()
}

// mutability
// - If you have a constant struct with a variable property, that property can't be changed because the struct itself is constnat
// - If you have a constant class with a variable property, that property *can* be changed; so classes don't need the 'mutating' keyword like structs do
class MutableSinger {
    var name = "Taylor Swift"
}

let taylorswift = MutableSinger()
taylorswift.name = "Ed Sheeran"
print(taylorswift.name)

// change name property to a constant top revent name from being changeable


// MARK: Day 11 - Protocols and extensions

// protocols
protocol Identifiable {
    var id: String { get set }
}

struct IdentifiableUser: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

// protocol inheritance - inherit from multiple protocols at the same time
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }

// extensions - add methods to existing types
extension Int {
    func squared() -> Int {
        return self * self
    }
    
    var isEven: Bool {
        return self % 2 == 0
    }
}

let numberToSquare = 8
number.squared()
number.isEven

// protocol extensions
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatlez = Set(["John", "Paul", "George", "Ringo"])

// Swift's arrays and sets both conform to a protocol called Collection, so we can write an extension to that protocol and add a method

extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        
        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatlez.summarize()

extension Collection {
    func describe() {
        if count == 1 {
            print("There is 1 item.")
        } else {
            print("There are \(count) items.")
        }
    }
}
pythons.describe()


// MARK: Day 12 - Optionals

// handling missing data
var age: Int?
age = 38

// unwrapping optionals with if let - unwrapped var is only usable within the if statement
var optionalName: String?
// optionalName = "Ryan"

if let unwrapped = optionalName {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}

// unwrapping with guard - unwrapped var is usable outside/after the guard code, but you need to manually return
func optionalGreet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    
    print("Hello, \(unwrapped)")
}

optionalGreet("Ryan")

// force unwrapping - only force it when you know it's safe, otherwise your code will crash
let numString = "5"
let forceNumber = Int(numString)!

// implicitly unwrapped optionals - if it doesn't have a value when you use it, it will crash
let implicitlyUnwrappedAge: Int! = nil

// nil coalescing - unwraps an optional and returns the value inside if there is one, otherwise uses the default value
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let coalescingUser = username(for: 15) ?? "Anonymous"

// optional chaining
let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased() // if first returns nil then Swift won't try to uppercase it, and will set beatle to nil immediately

// optional try
// - try? changes throwing functions into functions that return an optional
// -- if the function throws an error, you'll be sent nil as the result. Otherwise you get the return value wrapped as an optional
if let resultyz = try? checkPassword("password") {
    print("Result was \(resultyz)")
} else {
    print("D'oh")
}

// - use try! when you know for sure that the function will not fail - code will crash if it does
try! checkPassword("sekrit")
print("OK!")

// failable initializers
class Animal { }
class Fish: Animal { }
class Doggy: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

// typecasting
let pets = [Fish(), Doggy(), Fish(), Doggy()]

for pet in pets {
    if let dog = pet as? Doggy {
        dog.makeNoise()
    }
}
