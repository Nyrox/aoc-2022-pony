use "files"
use "src"

primitive AOC
    fun parse_input(env: Env, path: String): String? =>
        (OpenFile(FilePath(FileAuth(env.root), path)) as File).read_string(2 << 16)

actor Main
    new create(env: Env) =>
        try
            let day1Input: String = AOC.parse_input(env, "./src/day1.input")?
            let day2Input: Day2Input val = Day2Input(AOC.parse_input(env, "./src/day2.input")?)?
            let day3Input: Day3Input val = Day3Input(AOC.parse_input(env, "./src/day3.input")?)

            Day1(env, day1Input).part_one()
            Day1(env, day1Input).part_two()

            Day2(env, day2Input).part_one()
            Day2(env, day2Input).part_two()

            Day3(env, day3Input).part_one()
            Day3(env, day3Input).part_two()
        else
            env.err.print("Error.")
            return
        end



