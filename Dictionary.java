public class Dictionary{

	//method that insert a new user on table "users"
	public String insertUsers(String email, String first_name, String last_name){
		return "insert into users values('"+email+"','"+first_name+"','"+last_name+"')";
	}

	//method that delete an existing user
	public String deleteUsers(String email){
		return "delete from users where (email = '"+email+"')";
	}

	//method that show all games from some user
	public String showGames(String email){
	return  "select  distinct users.email,games.code,games.date_begin,games.date_end,games.hour_begin,games.hour_end from games inner join users on (users.email = games.player1 or users.email=games.player2) where (users.email <> '"+email+"' or users.email <> '"+email+"') and (games.player2 = '"+email+"' or games.player1 = '"+email+"') order by code";
	}
}