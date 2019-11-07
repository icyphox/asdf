#!/usr/bin/env python3
# np - a simple now playing script
# requires a last.fm API key

import requests

API_KEY="767dc7e260f5facfe2a6f39496983d5b"  # update with key here
USER="icyphox"   # your last.fm user
URL=f"http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user={USER}&api_key={API_KEY}&format=json&limit=1&nowplaying=true"
NOWPLAYING=False # current playing status
r = requests.get(URL)
data = r.json()
print(data)
if data['recenttracks']['track'][0]["@attr"]['nowplaying'] == "true":
    NOWPLAYING=True

if NOWPLAYING:
    track = data['recenttracks']['track'][0]['name']
    artist = data['recenttracks']['track'][0]['artist']['#text']
    print(f"{track} by {artist} is currently playing")
else:
    track = data['recenttracks']['track'][0]['name']
    artist = data['recenttracks']['track'][0]['artist']['#text']
    print(f"{trac} by {artist} was last played") 
