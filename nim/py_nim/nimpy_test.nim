import nimpy

proc greet(name: string): string {.exportpy.} =
  return "Hello, " & name & "!"

let os = pyImport("os")
echo os.getcwd().to(string)
