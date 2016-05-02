import praw

r = praw.Reddit('Grimoire Archivist by /u/sudo_bang_bang v0.1')

grim = r.search('flair:\'Grimoire\'', subreddit='dndbehindthescreen')

for p in grim:
	print p.id 
