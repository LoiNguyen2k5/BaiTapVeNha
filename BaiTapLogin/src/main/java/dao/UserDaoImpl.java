// File: src/main/java/dao/impl/UserDaoImpl.java (hoặc dao/UserDaoImpl.java)
package dao; // Hoặc package "dao;" tùy cấu trúc của bạn

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import dao.UserDao;
import model.User;
import Connection.DBConnection;

public class UserDaoImpl implements UserDao {

    @Override
    public User get(String username) {
        // Tên bảng và tên cột phải khớp chính xác với database
        String sql = "SELECT * FROM Users WHERE username = ?"; 
        
        // Sử dụng try-with-resources để tự động đóng Connection, PreparedStatement, ResultSet
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            
            try (ResultSet rs = ps.executeQuery()) {
                // Chỉ cần dùng if vì username là duy nhất, chỉ có thể có 1 kết quả
                if (rs.next()) {
                    User user = new User(sql, sql, sql, sql, sql, 0, sql, null);
                    user.setId(rs.getInt("id"));
                    user.setUserName(rs.getString("username"));
                    user.setPassword(rs.getString("password")); // Lấy cả password để service so sánh
                    user.setFullName(rs.getString("fullname"));
                    user.setEmail(rs.getString("email"));
                    user.setAvatar(rs.getString("avatar"));
                    user.setPhone(rs.getString("phone"));
                    user.setRoleid(rs.getInt("roleid"));
                    user.setCreatedDate(rs.getDate("createdDate"));
                    
                    return user; // Tìm thấy -> Trả về đối tượng user
                }
            }
        } catch (Exception e) {
            // Lỗi sẽ được in ra Console của Eclipse
            e.printStackTrace(); 
        }
        
        // Nếu không tìm thấy hoặc có lỗi, trả về null
        return null; 
    }
    public void insert(User user) {
        String sql = "INSERT INTO Users(email, username, fullname, password, avatar, roleid, phone, createdDate) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection conn = new DBConnection().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getAvatar());
            ps.setInt(6, user.getRoleid());
            ps.setString(7, user.getPhone());
            ps.setDate(8, user.getCreatedDate());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private boolean checkExist(String sql, String value) {
        try (Connection conn = new DBConnection().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, value);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true; // Tồn tại
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Không tồn tại
    }

    @Override
    public boolean checkExistEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        return checkExist(sql, email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        String sql = "SELECT * FROM Users WHERE username = ?";
        return checkExist(sql, username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        String sql = "SELECT * FROM Users WHERE phone = ?";
        return checkExist(sql, phone);
    }
}