<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2018/12/15
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册页面</title>
    <link rel="stylesheet" type="text/css" href="css/register.css"/>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/layui.all.js"></script>
</head>
<body>
<!-- 雪花背景 -->
<div id="snow"></div>

<!--注册-->
<div class="register_box" id="register_box">
    <h2>注&ensp;册</h2>
    <form id="form" >
        <div class="input_in">
            <span>用&ensp;户&ensp;名</span>
            <input type="text" name="username" placeholder="&ensp;请输入用户名" required id="username">
        </div>
        <div class="input_in">
            <span>密&emsp;&emsp;码</span>
            <input type="password" name="password" placeholder="&ensp;请输入密码" required id="password">
        </div>
        <div class="input_in">
            <span>确认密码</span>
            <input type="password" name="repassword" placeholder="&ensp;请重复上面密码" required id="repassword">
        </div>
        <div class="input_in">
            <span>电话号码</span>
            <input type="tel" name="phone" placeholder="&ensp;请输入电话号码">
        </div>
        <div class="input_in">
            <span>邮&emsp;&emsp;箱</span>
            <input type="email" name="email" placeholder="&ensp;请输入邮箱">
        </div>
        <button type="button" class="layui-btn layui-btn-normal" title="注册" id="register">注 册</button>
        <button type="reset" class="layui-btn layui-btn-normal" title="重置">重 置</button>
    </form>
    <div class="goLogin">
        <a href="/CampusTrading/Login" id="login" title="已有账号，立即登录">已有账号,立即登录</a>
    </div>

</div>

<script src="js/snow.js"></script>
<script>
    (function () {
        //用户名不能太长
        $("#username").blur(function () {
            var name=$("#username").val();
            if(name.length>20){
                alert("用户名太长，不符合规范,请输入20位以内的字符");
                $("#username").val("");
                $("#username").focus();
            }
        });
        //判断两次密码是否一致
        $("#repassword").blur(function () {
            var password=$("#password").val();
            var repassword=$("#repassword").val();
            if(password==""){
                alert("请先输入上面的密码");
                $("#password").focus();
            }else {
                if(password!=repassword){
                    alert("两次密码不一样，请重新输入");
                    $("#password").focus();
                    $("#password").val("");
                    $("#repassword").val("");
                }
            }
        })
    })();

    //注册按钮点击事件
    $("#register").click(function () {
        var url="/CampusTrading/Register-submit";
        var param=$("#form").serialize();
        $.post(url,param,function(data){
            //用户名已存在返回2，注册成功返回1，注册失败返回0
            if(data=="2"){
                alert("不好意思，该用户名已存在，请重新输入");
                $("#username").focus();
            }else if(data=="1"){
                alert("注册成功");
                location.href="/CampusTrading/Login"
            }else{
                alert("不好意思，注册失败");
            }

        });

    });
</script>
</body>
</html>
