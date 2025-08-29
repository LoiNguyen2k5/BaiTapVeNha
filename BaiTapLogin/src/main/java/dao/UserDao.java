package dao;

import model.User;
public interface UserDao {
    User get(String username);
    void insert(User user);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    User findByEmail(String email);
    void updateResetToken(String email, String token);
    User findByResetToken(String token);
    void updatePassword(String username, String newPassword);
}