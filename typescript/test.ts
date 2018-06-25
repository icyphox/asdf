#!/usr/bin/env ts-node

const a: string = "hello"

function lol(): string {
	return a
}

function add(x: number, y: string): string {
	return `${x} and ${y}`
} 

console.log(add(1, 'lol'))
