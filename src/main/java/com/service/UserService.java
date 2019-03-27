package com.service;

import com.dao.UserDao;
import com.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 用户管理的Service
 */
@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    public List<User> getUserList(){//用户列表
        return userDao.getUserList();
    }

    public User getUserByName(String name){//查询用户是否重复，根据name查询信息，可用户管理员的添加
        return userDao.getUserByName(name);
    }

    public User getUsernameById(User user){////查询用户是否重复，根据name和不是自己的id查询信息，可用户管理员的修改
        return userDao.getUsernameById(user);
    }

    public User getUserById(int id){//根据Id查找用户信息，修改用户信息
        return userDao.getUserById(id);
    }

    public String getNameById(int id){
        return userDao.getNameById(id);
    }

    public int deleteUser(int id){//删除用户
        return userDao.deleteUser(id);
    }

    public int updateUser(User user){//修改用户信息
        return userDao.updateUser(user);
    }

    public int addUser(User user){//添加用户
        return userDao.addUser(user);
    }

    public String getPassword(String username){//根据用户名得到用户的密码
        return userDao.getPassword(username);
    }

    public int changePassword(String username,String password){//修改用户的密码
        return userDao.changePassword(username,password);
    }

    public int openShop(String username){//成为卖家，免费开店
       return userDao.openShop(username);
    }

    public int sellerOrNot(String username){//查看该用户是否是卖家
        return userDao.sellerOrNot(username);
    }
}
