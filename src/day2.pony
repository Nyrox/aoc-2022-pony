use "itertools"
use "collections"

class Day2Input
    let strategy: Array[(U8, U8)] = []

    new create(input: String) ? =>
        for line in input.split("\n").values() do
            strategy.push((line(0)?, line(2)?))
        end

primitive _TicTacToe
    // LUT that given [x, y] returns how many points 'y' scores against 'x'
    fun get_score_table(): Array[Array[U32]] =>
        [
            [3; 6; 0]
            [0; 3; 6]
            [6; 0; 3]
        ]
    
    // LUT that given [x, y] returns which move 'y' wins against move 'x'
    fun get_result_table(): Array[Array[USize]] =>
        [
            [2; 0; 1]
            [0; 1; 2]
            [1; 2; 0]
        ]

actor Day2
    let _env: Env
    let _input: Day2Input val
    
    new create(env: Env, input: Day2Input val) =>
        _env = env
        _input = input

    be part_one() =>
        var score: U32 = 0
        try
            for (move, response) in _input.strategy.values() do
                let moveIndex: USize = (move - 'A').usize()
                let responseIndex: USize = (response - 'X').usize()
                score = score + _TicTacToe.get_score_table()(moveIndex)?(responseIndex)? + (responseIndex + 1).u32()
            end
        else
            _env.err.print("Error while calculating scores.")
        end

        _env.out.print("Day 2, Part 1: Expected score from strategy is " + score.string() + " points")

    be part_two() =>
        var score: U32 = 0
        try
            for (move, goal) in _input.strategy.values() do
                let moveIndex: USize = (move - 'A').usize()
                let goalIndex: USize = (goal - 'X').usize()

                let response = _TicTacToe.get_result_table()(moveIndex)?(goalIndex)?

                score = score + (response + 1).u32() + (goalIndex * 3).u32()
            end
        else
            _env.err.print("Error while calculating scores.")
        end

        _env.out.print("Day 2, Part 2: Expected score from strategy is " + score.string() + " points")

