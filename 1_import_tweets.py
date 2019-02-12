import json
import sqlite3

with sqlite3.connect('tweets.db') as db:
    db.execute('''CREATE TABLE Tweet (
        name TEXT,
        tweet_text TEXT,
        country_code TEXT,
        display_url TEXT,
        lang TEXT,
        created_at TEXT,
        location TEXT
    )''')

    with open('three_minutes_tweets.json.txt') as input_file:
        for line in input_file:
            tweet = json.loads(line)
            if 'id' in tweet:
                country_code = tweet['place']['country_code'] if tweet['place'] else None
                display_url = 'https://twitter.com/statuses/{}'.format(tweet['id'])

                db.execute('INSERT INTO Tweet VALUES (?,?,?,?,?,?,?)', (
                    tweet['user']['screen_name'],
                    tweet['text'],
                    country_code,
                    display_url,
                    tweet['lang'],
                    tweet['created_at'],
                    tweet['user']['location'],
                ))

    db.execute('ALTER TABLE Tweet ADD COLUMN tweet_sentiment INTEGER')
