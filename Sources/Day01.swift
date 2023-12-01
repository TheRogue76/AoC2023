import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    data.split(separator: "\n").compactMap { String($0) }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    return entities.map { lineOfText in
      let numbersInEachLine = lineOfText.split(separator: "").compactMap { Int($0) }
      return ((numbersInEachLine.first ?? 0) * 10) + (numbersInEachLine.last ?? 0)
    }.reduce(0, +)
  }

  enum Digit: String, CaseIterable {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine

    var numericValue: Int {
      switch self {
      case .one:
        1
      case .two:
        2
      case .three:
        3
      case .four:
        4
      case .five:
        5
      case .six:
        6
      case .seven:
        7
      case .eight:
        8
      case .nine:
        9
      }
    }
  }

  func returnLowerIndicedValue(left: (String.Index, Int)?, right: (String.Index, Int)?) -> Int {
    if let left {
      if let right {
        return left < right ? left.1 : right.1
      } else {
        return left.1
      }
    } else {
      return right?.1 ?? 0
    }
  }

  func returnHighestIndicedValue(left: (String.Index, Int)?, right: (String.Index, Int)?) -> Int {
    if let left {
      if let right {
        return left > right ? left.1 : right.1
      } else {
        return left.1
      }
    } else {
      return right?.1 ?? 0
    }
  }

  func findNumber(_ input: String) -> Int {
    let stringDigitsInInput: [(String.Index, Int)] = Digit.allCases.compactMap { digit in
      guard let rangeOfDigit = input.range(of: digit.rawValue, options: .caseInsensitive) else {
        return nil
      }
      return (rangeOfDigit.lowerBound, digit.numericValue)
    }.sorted(by: { $0.0 < $1.0 })

    let numberDigitsInInput: [(String.Index, Int)] = (0...10).compactMap { number in
      guard let rangeOfDigit = input.range(of: String(number)) else {
        return nil
      }
      return (rangeOfDigit.lowerBound, number)
    }.sorted(by: { $0.0 < $1.0 })

    let decimalValue =
      returnLowerIndicedValue(left: stringDigitsInInput.first, right: numberDigitsInInput.first)
      * 10

    let baseValue = returnHighestIndicedValue(
      left: stringDigitsInInput.last, right: numberDigitsInInput.last)

    return decimalValue + baseValue
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    return entities.map { lineOfText in
      return findNumber(lineOfText)
    }.reduce(0, +)
  }
}
