import miniz

let
  str = "test string"
  zstr = compress(str, level=11)

echo zstr
