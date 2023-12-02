import Algorithms

struct Game {
    let id: Int
    let sets: [GameSet]
    
    struct GameSet {
        let red: Int
        let green: Int
        let blue: Int
    }
}

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [Game] {
      return data.components(separatedBy: "\n").compactMap { textLine in
          let prefixAndSuffix = textLine.components(separatedBy: ":")
          guard let gameString = prefixAndSuffix.first, let gameSetString = prefixAndSuffix.last, gameString != gameSetString else {
              return nil
          }
          guard let gameIdInString = gameString.components(separatedBy: " ").last, let gameId = Int(gameIdInString) else {
              return nil
          }
          let gameSets: [Game.GameSet] = gameSetString.components(separatedBy: ";").compactMap { setString in
              let cubesString: [String] = setString.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces)}
              var (r, g, b) = (0, 0, 0)
              cubesString.forEach {
                  let components = $0.components(separatedBy: " ")
                  guard let countString = components.first, let count = Int(countString), let colorString = components.last else {
                      return
                  }
                  if colorString == "red" {
                      r = count
                      return
                  }
                  if colorString == "blue" {
                      b = count
                  }
                  if colorString == "green" {
                      g = count
                  }
              }
              return Game.GameSet(red: r, green: g, blue: b)
          }
          return Game(id: gameId, sets: gameSets)
      }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
      return entities.filter { game in
          return game.sets.first { gameSet in
              gameSet.red > 12 || gameSet.green > 13 || gameSet.blue > 14
          } == nil
      }.map { $0.id }.reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
      return entities.map { game in
          let maxRed = game.sets.map { $0.red }.sorted().last ?? 0
          let maxGreen = game.sets.map { $0.green }.sorted().last ?? 0
          let maxBlue = game.sets.map { $0.blue }.sorted().last ?? 0
          return maxRed * maxGreen * maxBlue
      }.reduce(0, +)
  }
}
