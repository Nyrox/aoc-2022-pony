use "itertools"
use "collections"


primitive Day3Utils
    fun bitmask_transform(input: String): U64 =>
        var mask: U64 = 0
        for char in input.values() do
            match char
                | (let c: U8) if (c >= 'a') and (c <= 'z') => mask = mask or (U64(1) << (c - 'a').u64())
                | (let c: U8) if (c >= 'A') and (c <= 'Z') => mask = mask or (U64(1) << ((c + 26) - 'A').u64())
            end
        end
        mask

class Day3Input
    let rucksack: Array[String] = []

    new create(input: String) =>
        for line in input.split("\n").values() do
            rucksack.push(line)
        end

actor Day3
    let _env: Env
    let _input: Day3Input val
    
    new create(env: Env, input: Day3Input val) =>
        _env = env
        _input = input

    be part_one() =>
        var priority_sum: U64 = 0
        for line in _input.rucksack.values() do
            (let left: String val, let right: String val) = line.clone().chop(line.size() / 2)
            let common = Day3Utils.bitmask_transform(left) and Day3Utils.bitmask_transform(right)
            let priority = common.ctz() + 1 // count trailing zeroes
            priority_sum = priority_sum + priority
        end

        _env.out.print("Day 3, Part 1: " + priority_sum.string())

    be part_two() =>
        var masks = Iter[String](_input.rucksack.values())
            .map[U64]({(line) => Day3Utils.bitmask_transform(line)})
        
        var sum: U64 = 0

        try
            repeat
                let overlap = masks.next()? and masks.next()? and masks.next()?
                sum = sum + (overlap.ctz() + 1)
            until not masks.has_next() end
        else
            _env.err.print("Error while calculating group overlaps")
        end

        _env.out.print("Day 3, Part 2: " + sum.string())
   

