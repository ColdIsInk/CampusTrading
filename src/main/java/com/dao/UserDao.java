package com.dao;

import com.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 用户Dao层，与数据库相关联
 * @author 墨水之寒
 *  @date
 */
@Repository
public interface  UserDao {
    /**
     * 得到用户，主要用于登录，查询用户的信息
     * @param user
     * @return
     */
    User getUser(User user); //登录时的到用户

    User getUserByName(String name); //得到用户的name，判断是否唯一，注册,根据用户名查找用户

    User getUsernameById(User user);//修改是判断除自己外的用户名是否会重复
    /**
     * 注册一个用户
     * @param user
     * @return
     */
    int registerUser(User user);

    /**
     * 得到用户列表
     * @return
     */
    List<User> getUserList();

    User getUserById(int id);

    /**
     * 删除用户信息
     * @param id
     * @return int 受影响的行数
     */
    int deleteUser(int id);

    int updateUser(User user);

    int addUser(User user);

    String getPassword(String username);//得到用户的原密码

    int changePassword(@Param("username")String username,@Param("password")String password); //修改用户的密码

    int openShop(String username);//成为卖家，免费开店

    int sellerOrNot(String username);//查看该用户是否是卖家
}
