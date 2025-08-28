package service;

import dao.UserDao;
import dao.UserDaoImpl;
import model.User;

public class UserServiceImpl implements UserService {
    UserDao userDao = new UserDaoImpl();
    
    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && password.equals(user.getPassword())) {
            return user;
        }
        return null;
    }
    
    @Override
    public User get(String username) {
        return userDao.get(username);
    }
    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }

    @Override
    public boolean register(String email, String password, String username, String fullname, String phone) {
        if (userDao.checkExistUsername(username)) {
            return false; // Trả về false nếu username đã tồn tại
        }
        
        // Tạo đối tượng User mới và gọi DAO để insert
        long millis = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(millis);
        // Giả sử: avatar=null, roleid=2 (user thường), slide dùng số 5
        User newUser = new User(email, username, fullname, password, null, 2, phone, date);
        userDao.insert(newUser);
        return true;
    }
}