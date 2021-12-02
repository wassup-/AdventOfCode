use std::fs::File;
use std::io::{self, BufRead};

type Result<T> = std::result::Result<T, io::Error>;

pub struct Input {
    path: String,
}

impl Input {
    pub fn num(num: i32) -> Self {
        let path = format!("input/{}.txt", num);
        Input { path }
    }
}

impl Input {
    pub fn read_lines(&self) -> Result<Lines> {
        let file = File::open(self.path.clone())?;
        let reader = io::BufReader::new(file);
        Ok(Lines(
            reader.lines().map(|s| s.unwrap_or_default()).collect(),
        ))
    }
}

pub struct Lines(Vec<String>);

impl IntoIterator for Lines {
    type Item = String;
    type IntoIter = std::vec::IntoIter<Self::Item>;

    fn into_iter(self) -> Self::IntoIter {
        self.0.into_iter()
    }
}
