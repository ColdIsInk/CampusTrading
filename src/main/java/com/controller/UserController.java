package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.User;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author 墨水之寒
 * 用户管理Controller ，用户列表
 */
@Controller
public class UserController {
    @Autowired
    private UserService userService;


    @RequestMapping("UserList")
    public String adminList(Model model){//用户列表查询,返回用户列表页面，用Model进行传值
        List<User> list = userService.getUserList();
        String listJson =JSONObject.toJSONString(list);
        model.addAttribute("users", listJson);
        return "User/userList";
    }

    @RequestMapping("DeleteUser")
    @ResponseBody
    public String deleteUser(int id){//根据id删除用户，删除成功返回"1",否则"0"
        int d=userService.deleteUser(id);
        return d>0?"1":"0";
    }

    @RequestMapping("EditUser/{id}")
    public String editUser(@PathVariable("id")int id, Model model){
        //进入修改用户界面，并把根据该用户的Id把该用户的信息传入
        User user=userService.getUserById(id);
        model.addAttribute("user", user);
        return "User/editUser";
    }

    @RequestMapping("EditUser/do")
    @ResponseBody
    public String editUser(User user){//修改用户信息

       User u=userService.getUsernameById(user);
        //判断用户名是否重复，有值返回"2"
       if(u!=null){
           return "2";
       }
        //修改用户信息，并判断受影响的行数
       int i=userService.updateUser(user);
       if(i>0){
           return "1";
       }else {
          return "0";
       }
    }

    @RequestMapping("AddUser")
    public String addUser(){//进入添加用户界面
        return "User/addUser";
    }

    @RequestMapping("AddUser/do")
    @ResponseBody
    public String addUser(User user){//添加用户信息 先判断用户名是否重复，有值返回"2"
        User u=userService.getUserByName(user.getUsername());
        if(u!=null){
            return "2";
        }
        //修改用户信息，并判断受影响的行数
        int i=userService.addUser(user);
        if(i>0){
            return "1";
        }else {
            return "0";
        }
    }

    @RequestMapping("BasicInfo/{username}")
    public String basicInfo(@PathVariable("username")String username ,Model model) {
        //查看个人基本信息
        User user = userService.getUserByName(username);
        model.addAttribute("user", user);
        return "User/basicInfo";
    }


    @RequestMapping("ChangePsw/{username}")
    public String ChangePsw(HttpServletRequest request,@PathVariable("username")String username) {
        //进入修改密码界面
        request.setAttribute("username", username);
        return "User/changePsw";
    }

    @RequestMapping("GetPassword/{username}")
    @ResponseBody
    public String gerPassword(@PathVariable("username")String username){//根据用户名得到用户的密码
        return userService.getPassword(username);
    }

    @RequestMapping(value = "ChangePassword" , method = RequestMethod.POST)
    @ResponseBody
    public String changePassword(String username,String password){//修改密码，成功返回“1”，否则为“0”
        int c=userService.changePassword(username,password);
        System.out.print(c);
        if(c>0){
            return "1";
        }else {
            return "0";
        }
    }

    @RequestMapping("OpenShop/{username}")
    @ResponseBody
    public String openShop(@PathVariable("username")String username){//免费开店，成为卖家
        int o=userService.openShop(username);
        if(o>0){
            return "1";
        }else {
            return "0";
        }
    }

    @RequestMapping("SellerOrNot/{username}")
    @ResponseBody
    public String sellerOrNot(@PathVariable("username")String username) {//免费开店，成为卖家
        int u=userService.sellerOrNot(username);
        if(u==1){
            return "1";
        }else {
            return "2";
        }

    }

    @RequestMapping(value = "GetUserByName",produces="application/json;charset=utf-8")
    @ResponseBody
    public String getUserByName(String username){//根据用户名的到用户的信息
        User user = userService.getUserByName(username);
        return JSONObject.toJSONString(user);
    }

    @RequestMapping("QueryPhoneByName")
    @ResponseBody
    public String queryPhoneByName(String name){//根据用户名来查询用户的电话号码
        User user=userService.getUserByName(name);
        return user.getPhone();
    }






}
