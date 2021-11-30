package Query;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class IsolationLevel {
	public static void SetLevel1(Connection conn) {
		String sql = "SET TRANSACTION ISOLATION LEVEL READ COMMITTED";
		
		try {
			Statement stmt = conn.createStatement();
			stmt.execute(sql);
			
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void SetLevel2(Connection conn) {
		String sql = "SET TRANSACTION ISOLATION LEVEL REPEATABLE READ";
		
		try {
			Statement stmt = conn.createStatement();
			stmt.execute(sql);
			
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
