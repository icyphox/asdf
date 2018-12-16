import httpclient, json

type
  User = object
    id: string
    username: string
    user: string
    url: string
    imageUrl: string

let client = newHttpClient()
client.headers = newHttpHeaders({ "Authorization": "Bearer [redacted]" })
let response = client.request("https://api.medium.com/v1/me", httpMethod = HttpGet)
let body = parseJson(response.body)
echo body
echo body["data"]
let userJson = parseJson(body["data"].getStr())
let u = to(userJson, User)

echo u.username
echo u.url
