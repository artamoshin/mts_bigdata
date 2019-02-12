import re
import sqlite3


class AFINN():
    def __init__(self, filename='AFINN-111.txt'):
        self.db = {}

        with open(filename) as input_file:
            for line in input_file:
                word, sentiment = line.split('\t')
                self.db[word] = int(sentiment)

    def calc_sentiment(self, string):
        sentiment = 0
        for word in re.findall('\w+', string):
            sentiment += self.db.get(word.lower(), 0)

        return sentiment


afinn = AFINN()

with sqlite3.connect('tweets.db') as db:
    cursor = db.cursor()
    cursor.execute('SELECT id, tweet_text FROM Tweet')
    for id, tweet_text in cursor.fetchall():
        sentiment = afinn.calc_sentiment(tweet_text)
        cursor.execute('UPDATE Tweet SET tweet_sentiment = ? WHERE id = ?', [sentiment, id])
