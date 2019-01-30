<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2018/12/20
  Time: 22:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户基本资料页面</title>
    <link rel="stylesheet" type="text/css" href="../css/addUser.css"/>
    <link rel="stylesheet" type="text/css" href="../css/layui.css"/>
</head>
<body>

<form id="form" class="layui-form">
    <h2>我的基本信息</h2>
        <input type="hidden" name="id" value="${user.id}" id="ID"><!--隐藏标签，存放用户的id,以便于去更改用户信息-->
        <input type="hidden" name="password" value="${user.password}">
    <div class="input_in">
        <span>用&ensp;户&ensp;名</span>
        <input type="text" name="username" required id="username" value="${user.username}" readonly>
    </div>
    <div class="input_in">
        <span>性&emsp;&emsp;别</span>
        <input type="radio" name="sex" value="1" title="男" >
        <input type="radio" name="sex" value="0" title="女" >
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
    <button class="layui-btn layui-btn-warm" id="keep" title="保存">保存</button>
</form>

<script src="../js/jquery-3.2.1.min.js"></script>
<script src="../js/layui.all.js"></script>
<script>
    if((${user.sex})==0){
        $("input[name=sex]:eq(1)").attr("checked",'checked');
        layui.form.render('radio');
    }
    else{
        $("input[name=sex]:eq(0)").attr("checked",'checked');
        layui.form.render('radio');

    }

    //点击保存，用户修改自己的基本信息
    $("#keep").click(function () {
        $.ajax({
            url:"/CampusTrading/EditUser/do",
            data:$("#form").serialize(),
            type:"post",
            success:function (data) {
                if(data=="1"){
                    layui.use('layer',function () {
                        var layer=layui.layer;
                        layer.msg('保存成功',{icon:1,time:1500},function () {
                            window.location.reload();
                        });
                    })
                }
                else{
                    layui.use('layer',function () {
                        var layer=layui.layer;
                        layer.msg('保存失败',{icon:2,time:1500});
                    });
                }
            }
        });
    });

</script>
</body>
</html>
