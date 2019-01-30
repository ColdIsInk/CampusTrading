package com.service;

import com.dao.UserDao;
import com.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
    @Autowired
    private UserDao userDao;

    /**
     * 验证登录传来的用户名和密码是否正确，判断权限
     * 返回普通用户返回1，管理员返回0，查无此人则返回-1
     */
    public int execute(String username, String password) {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        User a = userDao.getUser(user);
        if (a != null) {
            if(a.getPermissions()==0){
                return 0;
            }else {
                return 1;
            }
        } else {
            return -1;
        }
    }

    public User getUserByName(String name){
        return userDao.getUserByName(name);
    }

    public int registerUser(User user){//注册一个用户
        return userDao.registerUser(user);
    }
}
