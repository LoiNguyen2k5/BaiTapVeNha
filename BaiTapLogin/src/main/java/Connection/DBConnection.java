package Connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    
    // Sửa lại phương thức để ném ra ngoại lệ
    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=BaiTapLoginDB;trustServerCertificate=true";
        String user = "sa";
        String password = "123"; // <-- HÃY CHẮC CHẮN ĐÂY LÀ MẬT KHẨU ĐÚNG
        
        // Dòng này không thực sự cần thiết với các phiên bản JDBC mới, nhưng để lại cũng không sao
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        
        return DriverManager.getConnection(url, user, password);
    }
}