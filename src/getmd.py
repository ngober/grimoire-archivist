import praw
import re
import sys

id_re = re.compile(r"^(\.\.\/)?([a-z]*\/)*([a-z0-9]{6})\.md")

f = open(sys.argv[1], 'w')
id = id_re.search(sys.argv[1]).group(3)

r = praw.Reddit('Grimoire Archivist by /u/sudo_bang_bang v0.1')

post = r.get_submission(submission_id = id)

f.write(post.selftext.encode('utf8'))

