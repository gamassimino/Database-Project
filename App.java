import java.sql.*;

public class App{

  public static void main(String[] args) {

    try {
      String driver = "org.postgresql.Driver";
      String url = "jdbc:postgresql://localhost:5432/connec4";
      String username = "postgres";
      String password = "root";

      // Load database driver if not already loaded.
      Class.forName(driver);
      // Establish network connection to database.
      Connection connection = DriverManager.getConnection(url, username, password);

      String query = "set search_path = connect4_chino;";
      PreparedStatement statement = connection.prepareStatement(query);
      statement.execute();

/*********************************INSERT USER**********************************************/
      query = "insert into users values ('gamas@gmail.com','gas','mass')";
      statement = connection.prepareStatement(query);
      int reg = statement.executeUpdate();

      query = "select * from users";
      statement = connection.prepareStatement(query);
      ResultSet resultSet = statement.executeQuery();
      // while(resultSet.next()){
      //   System.out.println(resultSet.getString("email"));
      // 	System.out.println(resultSet.getString("first_name"));
      // 	System.out.println(resultSet.getString("last_name"));
      // }
/******************************************************************************************/

/*******************************DELETE USER************************************************/
 	 query = "delete from users where (email = 'gamas@gmail.com')";
      statement = connection.prepareStatement(query);
      reg = statement.executeUpdate();

      query = "select * from deleteUsers";
      statement = connection.prepareStatement(query);
      resultSet = statement.executeQuery();
      while(resultSet.next()){
      	System.out.println(resultSet.getString("email"));
      	System.out.println(resultSet.getString("first_name"));
      	System.out.println(resultSet.getString("last_name"));
      	System.out.println(resultSet.getString("admin"));
      	System.out.println(resultSet.getString("delete_date"));
      }
/******************************************************************************************/

/*******************************SHOW GAMES*************************************************/
/******************************************************************************************/
    
    } catch(ClassNotFoundException cnfe) {
      System.err.println("Error loading driver: " + cnfe);
    } 
    catch(SQLException sqle) {
    	sqle.printStackTrace();
      System.err.println("Error connecting: " + sqle);
    }


  }

}