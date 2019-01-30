<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="css/login.css"/>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <script src="js/jquery-3.2.1.min.js"></script>
</head>
<body>
<!-- 雪花背景 -->
<div id="snow"></div>

<!-- 登录控件 -->
<div class="login_box" id="login_box">
    <h2>登 录</h2>
    <div class="prompt" id="prompt"></div><!--错误提示-->
    <form action="/CampusTrading/Index" name="login" method="post" >
        <div class="input_in" title="用户名">
            <span class="layui-icon layui-icon-username"></span>
            <input type="text" name="username" placeholder="&ensp;请输入用户名">
        </div>
        <div class="input_in" title="密码">
            <span class="layui-icon layui-icon-password"></span>
            <input type="password" name="password" placeholder="&ensp;请输入密码">
        </div>
        <button type="submit" class="layui-btn layui-btn-normal" title="登录">登 录</button>
    </form>
    <div class="other">
        <a href="javascript:void(0)" id="forget" title="忘记密码">忘记密码?</a>&ensp;|&ensp;
        <a href="/CampusTrading/Register" id="register" title="立即注册">立即注册</a>
    </div>
</div>
<input type="hidden" value="${error}" id="error">


<script src="js/snow.js"></script>
<script src="js/layui.all.js"></script>
<script>
    //弹出错误信息
    var error=$("#error").val();
    if(error!=""){
        $("#prompt").html("<i class='layui-icon layui-icon-tips'></i> "+error);
    }
</script>
</body>
</html>
