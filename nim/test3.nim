import libsha/sha256

var
  str = "icy" & $1 & "kek" & $256
  icy = sha256hexdigest(str)

echo icy
