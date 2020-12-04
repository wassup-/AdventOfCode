import Core

let input = try! Input(day: 1).lines.compactMap(Int.init)

func solve(_ input: [Int]) -> Int? {
    for (index0, value0) in zip(input.indices, input) {
        let input1 = input.suffix(from: index0 + 1)
        for (index1, value1) in zip(input1.indices, input1) {
            let input2 = input.suffix(from: index1 + 1)
            for value2 in input2 {
                if value0 + value1 + value2 == 2020 {
                    return value0 * value1 * value2
                }
            }
        }
    }

    return nil
}

if let answer = solve(input) {
    print("answer: \(answer)")
} else {
    print("no answer found")
}
