import praw
import os

build_dir = '../build'

r = praw.Reddit('Grimoire Archivist by /u/sudo_bang_bang v0.1')

grim = r.search('flair:\'Grimoire\'', subreddit='dndbehindthescreen')

if not os.path.exists(build_dir):
	os.makedirs(build_dir)

for p in grim:
	print p.id 
