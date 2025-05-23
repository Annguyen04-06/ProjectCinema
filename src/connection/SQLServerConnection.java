package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SQLServerConnection {
    private static Connection conn2 = null;

    public static Connection getConnection() {
        try {
            if (conn2 == null || conn2.isClosed()) {  // 🔹 Kiểm tra nếu bị đóng, mở lại
                String serverName = "DESKTOP-08SM0HN\\SQLEXPRESS";
                String login = "sa";
                String password = "123";
                String databaseName = "CINEMA_Project";

                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

                String url = "jdbc:sqlserver://" + serverName + ":1433;databaseName=" + databaseName
                        + ";encrypt=true;trustServerCertificate=true";

                conn2 = DriverManager.getConnection(url, login, password);
                System.out.println("✅ Kết nối thành công với SQL Server (conn2)");
            }
        } catch (ClassNotFoundException e) {
            System.out.println("❌ Không tìm thấy driver JDBC!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("❌ Kết nối thất bại!");
            e.printStackTrace();
        }
        return conn2;
    }

    public static boolean isConnected() {
        try {
            return (conn2 != null && !conn2.isClosed());
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void closeConnection() {
        try {
            if (conn2 != null && !conn2.isClosed()) {
                conn2.close();
                System.out.println("🔴 Đã đóng kết nối SQL Server");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}