package com.controller;

import com.entity.User;
import com.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;

/**
 * @author 墨水之寒
 *登录的控制器 ，进入登录、注册页面、用户退出、进行注册、登录
 **/
@Controller
public class LoginController {
    @Autowired
    private LoginService loginService;

    /**
     * 进入登录界面
     */
    @RequestMapping("/Login")
    public String login(){

        return "Login/login";
    }

    /**
     * 进入注册界面
     */
    @RequestMapping("/Register")
    public String register(){
        return "Login/register";
    }

    /**
     * 点击登录，验证用户名和密码是否正确
     */
    @RequestMapping("Index")
    public String loginSubmit(HttpServletRequest request, String username, String password){
        request.setAttribute("username", username);
        int result=loginService.execute(username, password);
        if(result==0){
            request.getSession().setAttribute("username", username);
            return "Login/adminIndex";
        }else if(result>0){
            request.getSession().setAttribute("username", username);
            return "Login/userIndex";
        }else {
            request.setAttribute("error","用户名或密码错误");
            return "Login/login";
        }
    }


    /**
     * 点击注册按钮，一实现注册功能，添加用户
     * @return 当传来的用户名已存在返回2，注册成功返回1，注册失败返回0
     */
    @RequestMapping("Register-submit")
    @ResponseBody
    public String registerSubmit(User user){
        User u=loginService.getUserByName(user.getUsername());
        if(u!=null){
            return "2";
        }
        int r=loginService.registerUser(user);
        if(r>0){
            return "1";

        }else{
            return "0";
        }

    }

    /**
     * 退出登录
     * @param sessionStatus
     * @return到登录界面
     */
    @RequestMapping("/Logout")
    public String logout(SessionStatus sessionStatus){
        sessionStatus.setComplete();
        return "Login/login";
    }

    /**
     *用户主页的ifram框架中加入shopping这个页面
     */
    @RequestMapping("/Shopping")
    public String shopping(){
        return "Goods/shopping";
    }

}

