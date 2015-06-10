-- 6) a) -- select users.email, count(users.email) from games inner join users on ((games.player1 =users.email and games.result = 'player_1') or (games.player2 = users.email and games.result = 'player_2' )) group by users.email
-- 6) b) -- select users.email, max(games.date_end-games.date_begin) as maximun from games inner join users on (games.player1=users.email or games.player2=users.email ) group by users.email
-- 6) c) -- select users.email, count(plays.result) as plays_in_game from users inner join (select games.result, games.player1, games.player2 from games where games.result ='in_game') as plays on (users.email = plays.player1 or users.email = plays.player2) group by users.email
-- 6) c) -- select users.email, max(count(games.result)) as games_played from users inner join games on users.email = games.player1 or users.email = games.player2 group by users.email





--  coorregggiiiirrr -- select * from (select count(games.result) as games_played from users inner join games on users.email = games.player1 or users.email = games.player2) as hola