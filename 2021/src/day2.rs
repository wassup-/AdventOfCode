use crate::input::Input;
use std::str::FromStr;

pub fn solve() {
    println!("day 2 - part 1: {}", part1());
    println!("day 2 - part 2: {}", part2())
}

fn part1() -> i32 {
    let input = Input::num(2);
    let commands: Vec<Command> = input
        .read_lines()
        .expect("failed to read input")
        .into_iter()
        .map(|s| Command::from_str(&s).expect("failed to parse command"))
        .collect();

    let mut hpos = 0;
    let mut vpos = 0;

    for command in commands {
        match command {
            Command::Up(val) => vpos -= val,
            Command::Down(val) => vpos += val,
            Command::Forward(val) => hpos += val,
        }
    }

    return hpos * vpos;
}

fn part2() -> i32 {
    let input = Input::num(2);
    let commands: Vec<Command> = input
        .read_lines()
        .expect("failed to read input")
        .into_iter()
        .map(|s| Command::from_str(&s).expect("failed to parse command"))
        .collect();

    let mut hpos = 0;
    let mut vpos = 0;
    let mut aim = 0;

    for command in commands {
        match command {
            Command::Up(val) => aim -= val,
            Command::Down(val) => aim += val,
            Command::Forward(val) => {
                hpos += val;
                vpos += val * aim;
            }
        }
    }

    return hpos * vpos;
}

#[derive(Eq, PartialEq, Debug)]
enum Command {
    Up(i32),
    Down(i32),
    Forward(i32),
}

#[derive(Eq, PartialEq, Debug)]
struct ParseCommandError;

impl FromStr for Command {
    type Err = ParseCommandError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let split: Vec<_> = s.split_whitespace().collect();
        if split.len() != 2 {
            return Err(ParseCommandError);
        }

        let val = split[1].parse::<i32>().map_err(|_| ParseCommandError)?;

        match split[0] {
            "up" => Ok(Command::Up(val)),
            "down" => Ok(Command::Down(val)),
            "forward" => Ok(Command::Forward(val)),
            _ => Err(ParseCommandError),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parse_commands() {
        assert_eq!(Command::from_str("forward 5"), Ok(Command::Forward(5)));
        assert_eq!(Command::from_str("up 3"), Ok(Command::Up(3)));
        assert_eq!(Command::from_str("down 8"), Ok(Command::Down(8)));
        assert_eq!(Command::from_str("up"), Err(ParseCommandError));
        assert_eq!(Command::from_str("down3"), Err(ParseCommandError));
        assert_eq!(Command::from_str("8 forward"), Err(ParseCommandError));
    }
}
