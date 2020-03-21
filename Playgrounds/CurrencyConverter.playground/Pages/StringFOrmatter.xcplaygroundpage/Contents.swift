import Foundation

private func format(_ string: String) {
    var lastDigits = string.suffix(2)
    let firstDigits = string.dropLast(2)
    print("First:", firstDigits)
    print("Last:", lastDigits)
}

let number = "0.1234"

format(number)
