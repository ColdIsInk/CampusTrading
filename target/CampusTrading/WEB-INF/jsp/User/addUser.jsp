<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2018/12/17
  Time: 23:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加用户界面</title>
    <link rel="stylesheet" type="text/css" href="css/addUser.css"/>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>

</head>
<body>

<form id="form" class="layui-form">
    <h2>添加新用户</h2>
    <div class="input_in">
        <span>用&ensp;户&ensp;名</span>
        <input type="text" name="username" placeholder="&ensp;请输入用户名" required id="username" value="${user.username}">
    </div>
    <div class="input_in">
        <span>密&emsp;&emsp;码</span>
        <input type="password" name="password" placeholder="&ensp;请输入密码" required id="password">
    </div>
    <div class="input_in">
        <span>确认密码</span>
        <input type="password" name="repassword" placeholder="&ensp;请重复上面密码" required id="repassword">
    </div>
    <p class="error" id="error" style="color:rgba(238,15,78,0.98);text-align: center;font-size: 14px;"></p>
    <div class="input_in">
        <span>性&emsp;&emsp;别</span>
        <input type="radio" name="sex" value="1" title="男" checked class="sex">
        <input type="radio" name="sex" value="0" title="女" class="sex">
    </div>
    <div class="input_in">
        <span>电话号码</span>
        <input type="tel" name="phone" placeholder="&ensp;请输入电话号码">
    </div>
    <div class="input_in">
        <span>电子邮箱</span>
        <input type="email" name="email" placeholder="&ensp;请输入电子邮箱">
    </div>
    <div class="input_in">
        <span>管&ensp;理&ensp;员</span>
        <input type="radio" name="permissions" value="1" title="是">
        <input type="radio" name="permissions" value="0" title="否" checked>
    </div>
    <button type="button" class="layui-btn layui-btn-normal" title="添加" id="add">添 加</button>
    <button type="reset" class="layui-btn" title="重 置">重 置</button>
</form>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    $("#repassword").blur(function () {
        var password=$("#password").val();
        var repassword=$("#repassword").val();
        if(password==""){
            $("#error").html("请先输入密码");
            $("#password").focus();
            $("#repassword").val("");
        }
        else if(repassword!=password){
            $("#error").html("两次密码不一致，请重新输入");
            $("#password").val("").focus();
            $("#repassword").val("");
        }
    });
    //点击添加按钮，实行添加用户
    $("#add").click(function () {
        var url="/CampusTrading/AddUser/do";
        var param=$("#form").serialize();
        $.post(url,param,function(data){
            if(data=="1"){
                location.href="/CampusTrading/UserList";
            }
            else if(data=="2") {
                layui.use('layer', function(){
                    var layer = layui.layer;
                    layer.alert('用户名已存在,请重新添加。',{icon: 5,time:2000,anim:3,shade: [0.1, '#000']});
                });
            }else{
                layui.use('layer', function(){
                    var layer = layui.layer;
                    layer.alert('添加失败。',{icon: 5,time:2000,anim:3,shade: [0.1, '#000']});
                });
            }
        });
    });
</script>
</body>
</html>
