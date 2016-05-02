import praw
import praw
import sys

r = praw.Reddit('Grimoire Archivist by /u/sudo_bang_bang v0.1')

post = r.get_submission(submission_id = sys.argv[1])

sys.stdout.write(post.title)

