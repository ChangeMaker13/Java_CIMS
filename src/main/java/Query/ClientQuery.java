package Query;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ClientQuery {
	public static String getUnumber(Connection conn ,String id) {
		String sql = "SELECT unumber FROM CLIENT WHERE User_id = ?";
		String unumber = "";

		PreparedStatement ps;
		ResultSet rs;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			
			rs = ps.executeQuery();
			while(rs.next()){
				unumber = rs.getString(1);
			}

			ps.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return unumber;
	}
	
	public static String getName(Connection conn, String id) {
		String sql = "SELECT Name FROM CLIENT WHERE User_id = ?";
		String name = "";

		PreparedStatement ps;
		ResultSet rs;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			
			rs = ps.executeQuery();
			while(rs.next()){
				name = rs.getString(1);
			}

			ps.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return name;
	}
}
