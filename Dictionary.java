public class Dictionary{

	public String insertUser(String email, String first_name, String last_name){
		return "insert into users values("+email+","+first_name+","+last_name+")";
	}

	public String deleteUser(String email, String first_name, String last_name){
		return "insert into users values("+email+","+first_name+","+last_name+",current_user,now())";
	}

	public String showGames(String email){
		String p1 = "select palyer1,code,date_begin,date_end,hour_begin,hour_end games where (player2 = "+email+");";
		String p2 = "select player2,code,date_begin,date_end,hour_begin,hour_end games where (palyer1 = "+email+")";
		return p1+p2; 
	}
}