fn main() {
    let num = 4;
    let booly = true;
    if !booly {
        println!("this works!");
    } else {
        println!("this doesn't");
        println!("{}", num);
    }

    let condition = true;
    let num = if condition {
        5
    } else {
        19
    };
    println!("{}", num);
}
