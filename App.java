import java.sql.*;

public class App{

  public static void main(String[] args) {

    try {
      String driver = "org.postgresql.Driver";
      String url = "jdbc:postgresql://localhost:5432/postgres";
      String username = "postgres";
      String password = "root";

      // Load database driver if not already loaded.
      Class.forName(driver);
      // Establish network connection to database.
      Connection connection = DriverManager.getConnection(url, username, password);

      String query = "SELECT * FROM persona ";
      PreparedStatement statement = connection.prepareStatement(query);
      ResultSet resultSet = statement.executeQuery();

    }
    } catch(ClassNotFoundException cnfe) {
      System.err.println("Error loading driver: " + cnfe);
    } catch(SQLException sqle) {
    	sqle.printStackTrace();
      System.err.println("Error connecting: " + sqle);
    }


  }

}