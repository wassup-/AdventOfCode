use crate::input::Input;

pub fn solve() {
    println!("day 1 - part 1: {}", part1());
    println!("day 1 - part 2: {}", part2())
}

fn part1() -> i32 {
    let input = Input::num(1);
    let depths: Vec<_> = input
        .read_lines()
        .expect("failed to read input")
        .into_iter()
        .map(|s| s.parse::<i32>().unwrap_or(0))
        .collect();
    depths.iter().zip(depths.iter().skip(1)).fold(
        0,
        |acc, (prev, cur)| {
            if cur > prev {
                acc + 1
            } else {
                acc
            }
        },
    )
}

fn part2() -> i32 {
    let input = Input::num(1);
    let depths: Vec<_> = input
        .read_lines()
        .expect("failed to read input")
        .into_iter()
        .map(|s| s.parse::<i32>().unwrap_or(0))
        .collect();
    let windows = depths.windows(3);

    let mut prev_sum: i32 = i32::MAX;
    windows.into_iter().fold(0, |acc, window| {
        let prev = prev_sum;
        let sum: i32 = window.iter().sum();
        prev_sum = sum;
        if sum > prev {
            acc + 1
        } else {
            acc
        }
    })
}
