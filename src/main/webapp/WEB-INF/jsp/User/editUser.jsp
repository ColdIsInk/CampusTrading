<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2018/12/17
  Time: 22:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改用户信息页面</title>
    <link rel="stylesheet" type="text/css" href="../css/addUser.css"/>
    <link rel="stylesheet" type="text/css" href="../css/layui.css"/>

</head>
<body>

<form id="form" class="layui-form">
    <h2>修改用户信息</h2>
        <input type="hidden" name="id" value="${user.id}" id="ID"><!--隐藏标签，存放用户的id,以便于去更改用户信息-->
    <div class="input_in">
        <span>用&ensp;户&ensp;名</span>
        <input type="text" name="username" required id="username" value="${user.username}">
    </div>
    <div class="input_in">
        <span>密&emsp;&emsp;码</span>
        <input type="password" name="password" required id="password" value="${user.password}">
    </div>
    <div class="input_in">
        <span>性&emsp;&emsp;别</span>
        <input type="radio" name="sex" value="1" title="男">
        <input type="radio" name="sex" value="0" title="女">
    </div>
    <div class="input_in">
        <span>年&emsp;&emsp;龄</span>
        <input type="number" name="age" value="${user.age}" min="0" max="150">
    </div>
    <div class="input_in">
        <span>电话号码</span>
        <input type="tel" name="phone" value="${user.phone}">
    </div>
    <div class="input_in">
        <span>邮&emsp;&emsp;箱</span>
        <input type="email" name="email" value="${user.email}">
    </div>
    <div class="input_in">
        <span>地&emsp;&emsp;址</span>
        <input type="text" name="address" value="${user.address}">
    </div>
    <button type="button" class="layui-btn layui-btn-normal" title="修改" id="edit">修 改</button>
</form>


<script src="../js/jquery-3.2.1.min.js"></script>
<script src="../js/layui.all.js"></script>
<script>
    layui.use('form', function() {
        var form = layui.form;
    });
    if((${user.sex})==0){
        $("input[name=sex]:eq(1)").attr("checked",'checked');
        layui.form.render('radio');
    }else{
        $("input[name=sex]:eq(0)").attr("checked",'checked');
        layui.form.render('radio');

    }
    //点击修改按钮，实行修改用户
    $("#edit").click(function () {
        var url="/CampusTrading/EditUser/do";
        var param=$("#form").serialize();
        $.post(url,param,function(data){
            if(data=="1"){
                location.href="/CampusTrading/UserList";
            }
            else if(data=="2") {
                alert("用户名已存在,请重新输入");
            }else{
                alert("修改失败");
            }
        });
    });


</script>
</body>
</html>
