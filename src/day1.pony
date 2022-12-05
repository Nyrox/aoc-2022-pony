use "itertools"
use "collections"

class Day1Input
    var calories: Array[U32] ref

    new create(input_lines: Iterator[String]) =>
        let parsed: Array[Array[U32]] = [[]]

        for line in input_lines do
            try
                parsed(parsed.size() - 1)?.push(line.u32()?)
            else
                parsed.push([])
            end
        end

        calories = Iter[Array[U32]](parsed.values()).map[U32]({(deer) =>
            Iter[U32](deer.values()).fold[U32](0, {(sum, x) => sum + x})
        }).collect(Array[U32]())


actor Day1
    let _env: Env
    let _input: Day1Input ref
    
    new create(env: Env, input: String) =>
        _env = env
        _input = Day1Input(input.split("\n").values())

    be part_one() =>
        var index: USize = 0
        var max: U32 = 0
        for (i, max') in _input.calories.pairs() do
            if max' > max then 
                max = max'
                index = i
            end
        end

        _env.out.print("Day 1, Part 1: Deer with the most calories is: " + index.string() + ", with " + max.string() + " calories.")
    
    be part_two() =>
        try
            let sorted_array = Sort[Array[U32], U32](_input.calories)
            let top = [ sorted_array(sorted_array.size() - 1)?
                        sorted_array(sorted_array.size() - 2)?
                        sorted_array(sorted_array.size() - 3)?]

            _env.out.print("Day 1, Part 2: The 3 most loaded deer have a total of " + (top(0)? + top(1)? + top(2)?).string() + " calories.")
        else
            _env.err.print("Error during part 2. Malformed input?")
        end

