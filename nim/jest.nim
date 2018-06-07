import jester, asyncdispatch, htmlgen, osproc

routes:
  get "/api/@name":
    resp Http400, "your a nig" & @"name"

runForever()
