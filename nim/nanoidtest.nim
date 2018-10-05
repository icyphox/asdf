import nanoid

echo(generate())

let a = "abcdef12345"
let s = 10

echo(generate(alphabet=a, size=s))


assert len(generate()) == 21
