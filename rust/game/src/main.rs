use std::io;

fn main() {
    let x = 5;

    let y = {
        let x = 3;
        x + 1
    };

    println!("The value of y is: {}", y);
    println!("{}", test())
}

fn test() -> String {
   let t = String::from("test");
   t
}


