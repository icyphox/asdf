var id = ''
var size = 21

var a = '_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

while (0 < size--) {
	id += a[Math.random() * a.length | 0]
	console.log(Math.random() * a.length | 0)
}


console.log(id)
