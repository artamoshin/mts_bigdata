CREATE TABLE Location (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    location TEXT
);
CREATE TABLE User (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    location_id INTEGER
);
CREATE TABLE NewTweet (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    tweet_text TEXT,
    lang TEXT,
    created_at TEXT,
    country_code TEXT,
    tweet_sentiment INTEGER
);

INSERT INTO Location (location)
SELECT DISTINCT location
FROM Tweet;

INSERT INTO User (name, location_id)
SELECT name, Location.id
FROM Tweet
JOIN Location ON Location.location = Tweet.location
GROUP BY name;

INSERT INTO NewTweet (id, user_id, tweet_text, lang, created_at, country_code)
SELECT
    REPLACE(Tweet.display_url, 'https://twitter.com/statuses/', '') AS tweet_id,
    User.id,
    Tweet.tweet_text,
    Tweet.lang,
    Tweet.created_at,
    Tweet.country_code
FROM Tweet
JOIN User ON User.name = Tweet.name
GROUP BY tweet_id; -- твит 633031060637532168 дублируется


DROP TABLE Tweet;
ALTER TABLE NewTweet RENAME TO Tweet;