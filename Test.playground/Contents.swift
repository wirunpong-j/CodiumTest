import UIKit

// 1
func printFizzBuzz() {
    for num in 1...100 {
        var text = ""
        
        text += (num % 3 == 0) ? "Fizz" : ""
        text += (num % 5 == 0) ? "Buzz" : ""
        
        let result = text.isEmpty ? "\(num)" : text
        print(result, terminator: " ")
    }
}

// 2
func printLeapYear(year: Int) {
    var result = false
    
    if year % 4 == 0 {
        result = true
        if year % 400 == 0 && year % 100 == 0 {
            result = true
        } else if year % 400 == 0 && year % 100 != 0 {
            result = false
        } else if year % 100 == 0 {
            result = false
        }
    }
    
    print("\(year) -> \(result)")
}


// 3.1
func printStar(number: Int) {
    for count in 1...number {
        let star = String(repeating: "*", count: count)
        print(star)
    }
}

// 3.2
func printStarReverse(number: Int) {
    for count in 1...number {
        let space = String(repeating: " ", count: number - count)
        let star = String(repeating: "*", count: count)
        print(space + star)
    }
}

// 3.3
func printStarSplit(number: Int) {
    for count in 1...number {
        let space = String(repeating: " ", count: number - count)
        
        if count == 1 {
            print(space + "*")
        } else {
            let rightSpace = String(repeating: " ", count: (2*count - 1) - 2)
            print(space + "*" + rightSpace + "*")
        }
    }
}

// 3.4
func printStarX(number: Int) {
    if number == 1 {
        print("*")
        return
    }
    
    // Top
    var topCount = Int(Double(number / 2).rounded())
    var midCount = topCount - 2
    
    for count in 1...topCount {
        let midSpace = String(repeating: " ", count: midCount)
        print("*" + midSpace + "*")
        midCount += 1
    }
    
}

// 3.5
func printDiamond(number: Int) {
    if number == 1 {
        print("*")
        return
    }
    // Top
    var topCount = Int(Double(number / 2).rounded())
    var bottomCount = Int(Double(number / 2).rounded())
    
    var leftCount = (number % 2 == 0) ? topCount - 1 : topCount
    
    for count in 1...topCount {
        let starCount = (2*count) - 1
        let star = String(repeating: "*", count: starCount)
        let space = String(repeating: " ", count: leftCount)
        print(space + star)
        
        leftCount -= 1
    }
    
    // Mid
    if number % 2 != 0 {
        print(String(repeating: "*", count: number))
    }
    
    // Bottom
    leftCount = number % 2 == 0 ? 0 : topCount - bottomCount + 1
    for count in stride(from: bottomCount, to: 0, by: -1) {
        let starCount = (2*count) - 1
        let star = String(repeating: "*", count: starCount)
        let space = String(repeating: " ", count: leftCount)
        print(space + star)
        
        leftCount += 1
    }
}

//printFizzBuzz()
//for num in [1600, 2000, 1500, 2004, 2008, 2010] {
//    printLeapYear(year: num)
//}
//printStar(number: 12)
//printStarReverse(number: 20)
//printStarSplit(number: 20)
printStarX(number: 5)
//printDiamond(number: 2)
