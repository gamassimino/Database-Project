import java.sql.*;
import java.util.Scanner;

public class App{

  public static void main(String[] args) {

    try {
		String driver = "org.postgresql.Driver";
		String url = "jdbc:postgresql://localhost:5432/connect4";
		String username = "postgres";
		String password = "root";

		// Load database driver if not already loaded.
		Class.forName(driver);
		// Establish network connection to database.
		Connection connection = DriverManager.getConnection(url, username, password);

		String query = "set search_path = connect4_chino;";
		PreparedStatement statement = connection.prepareStatement(query);
		statement.execute();

		Dictionary dictionary = new Dictionary();
		String email;
		String first_name;
		String last_name;

	boolean condition = true;
	while(condition){
		for(int i=0; i<21; i++){
			System.out.println("\n");
		}
		System.out.println("WELCOME TO CONNECT_4");
		System.out.println("Press (1) to insert a new user");
		System.out.println("Press (2) to delete an existing user");
		System.out.println("Press (3) for show all games of some user");
		System.out.println("Press other number for exit");

		Scanner keyboard = new Scanner(System.in);
		System.out.println("Enter an option: ");
		int myint = keyboard.nextInt();

		if(myint == 1){
			Scanner option = new Scanner(System.in);
			System.out.println("email: ");
			email = option.next();
			System.out.println("first name: ");
			first_name = option.next();
			System.out.println("last name: ");
			last_name = option.next();
			query = dictionary.insertUsers(email,first_name,last_name);
		    statement = connection.prepareStatement(query);
		    int reg = statement.executeUpdate();
		    query = "select * from users";
		    statement = connection.prepareStatement(query);
		    /*ResultSet resultSet = statement.executeQuery();
		    while(resultSet.next()){
		        System.out.println(resultSet.getString("email"));
		      	System.out.println(resultSet.getString("first_name"));
		      	System.out.println(resultSet.getString("last_name"));
		    }*/
		}
		else{
			if (myint == 2){
				Scanner option = new Scanner(System.in);
				System.out.println("email: ");
				email = option.next();
				query = dictionary.deleteUsers(email);
			    statement = connection.prepareStatement(query);
			    int reg = statement.executeUpdate();
			    query = "select * from deleteUsers";
			    statement = connection.prepareStatement(query);
			   /* ResultSet resultSet = statement.executeQuery();
			    while(resultSet.next()){
			      	System.out.println(resultSet.getString("email"));
			      	System.out.println(resultSet.getString("first_name"));
			      	System.out.println(resultSet.getString("last_name"));
			      	System.out.println(resultSet.getString("admin"));
			      	System.out.println(resultSet.getString("delete_date"));
			    }*/
			}
			else{
				if (myint == 3){
					Scanner option = new Scanner(System.in);
					System.out.println("email: ");
					email = option.next();
					query = dictionary.showGames(email);
					statement = connection.prepareStatement(query);
		    	ResultSet resultSet = statement.executeQuery();
		    	for(int j=0; j<21; j++)
		    		System.out.println();
		    	while(resultSet.next()){
		      	System.out.println(resultSet.getString("email"));
		      	System.out.println(resultSet.getString("code"));
		      	System.out.println(resultSet.getString("date_begin"));
		      	System.out.println(resultSet.getString("date_end"));
		      	System.out.println();
		   		}
		   		System.out.println("press any key to continue");
		   		email = option.next();
				}
				else{
					condition = false;
				}
			}
		}
	}
    
    } catch(ClassNotFoundException cnfe) {
      System.err.println("Error loading driver: " + cnfe);
    } 
    catch(SQLException sqle) {
    	sqle.printStackTrace();
      System.err.println("Error connecting: " + sqle);
    }


  }

}