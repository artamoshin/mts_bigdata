SELECT *
FROM (SELECT 'happy country', country_code, AVG(tweet_sentiment)
      FROM Tweet
      GROUP BY country_code
      ORDER BY AVG(tweet_sentiment) DESC
      LIMIT 1)
UNION ALL

SELECT *
FROM (SELECT 'sad country', country_code, AVG(tweet_sentiment)
      FROM Tweet
      GROUP BY country_code
      ORDER BY AVG(tweet_sentiment)
      LIMIT 1)
UNION ALL

SELECT *
FROM (SELECT 'happy location', location, AVG(tweet_sentiment)
      FROM Tweet
      JOIN User ON User.id = Tweet.user_id
      JOIN Location ON Location.id = User.location_id
      GROUP BY location
      ORDER BY AVG(tweet_sentiment) DESC
      LIMIT 1)
UNION ALL

SELECT *
FROM (SELECT 'sad location', location, AVG(tweet_sentiment)
      FROM Tweet
      JOIN User ON User.id = Tweet.user_id
      JOIN Location ON Location.id = User.location_id
      GROUP BY location
      ORDER BY AVG(tweet_sentiment)
      LIMIT 1)
UNION ALL

SELECT *
FROM (SELECT 'happy user', name, AVG(tweet_sentiment)
      FROM Tweet
      JOIN User ON User.id = Tweet.user_id
      GROUP BY user_id
      ORDER BY AVG(tweet_sentiment) DESC
      LIMIT 1)
UNION ALL

SELECT *
FROM (SELECT 'sad user', name, AVG(tweet_sentiment)
      FROM Tweet
      JOIN User ON User.id = Tweet.user_id
      GROUP BY user_id
      ORDER BY AVG(tweet_sentiment)
      LIMIT 1)
