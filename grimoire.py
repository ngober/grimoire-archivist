import praw
import os
import re
import string

r = praw.Reddit('Grimoire Archivist by /u/sudo_bang_bang v0.1')

grim = r.search('flair:\'Grimoire\'', subreddit='dndbehindthescreen')

if not os.path.exists('build/md/'):
    os.makedirs('build/md/')

def parse_md(text):
   edited = text.encode('utf8')
   
   edited = re.sub(r"_{3,}", "\\hline", edited)
   
   return edited
   
titles = []

for p in grim:
   title = p.title
   title = title.replace(' ', '_')
   title = title.replace('.', '')
   title = title.replace('!', '')
   title = title.replace('\'', '')
   
   title = 'build/md/' + title.lower() + '.md'
   
   titles.append(title)
   f = open(title, 'w')
   f.write(parse_md(p.selftext))
