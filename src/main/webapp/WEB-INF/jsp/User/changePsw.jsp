<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2018/12/20
  Time: 22:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码界面</title>
    <link rel="stylesheet" type="text/css" href="../css/layui.css"/>
    <style>
        .psw{
            width: 330px;
            height: 250px;
            margin-left: auto;
            margin-right: auto;
            font-size: 16px;
            margin-top: 60px;
        }
        .psw h2{text-align: center;}
        .input_in{margin-top: 10px;width: 320px;margin-left: 5px; height: 36px;}
        .psw p{font-size: 12px;color: rgba(238,75,90,0.98);text-align: center;}
        .input_in input{width:240px;height: 32px;padding-left:6px;border-radius: 6px;border: #cccccc 1px solid;}
        .psw button{margin-top: 16px;margin-left: 120px;}
    </style>
</head>
<body>
<div class="psw">
    <h2>修改密码</h2>
    <input type="hidden" value="${username}" id="username"><!--用来隐藏存放用户名，方便修改密码-->
    <div class="input_in">
         <span>原&ensp;密&ensp;码</span>
         <input type="text" name="oldPassword" placeholder="&ensp;请输入原密码" required id="oldPassword">
    </div>
    <p class="oldPsw" id="oldPsw"></p>
    <div class="input_in">
         <span>新&ensp;密&ensp;码</span>
         <input type="password" name="newPassword" placeholder="&ensp;请输入新密码" required id="newPassword">
    </div>
    <div class="input_in">
         <span>确认密码</span>
         <input type="password" name="rePassword" placeholder="&ensp;请重复上面密码" required id="rePassword">
    </div>
    <p id="pswError"></p>
    <button class="layui-btn layui-btn-normal" id="change">修 改</button>
</div>

<script src="../js/jquery-3.2.1.min.js"></script>
<script src="../js/layui.all.js"></script>
<script>
    var username=$("#username").val();
    $("#oldPassword").blur(function () {
        //当原密码失去焦点时，去查询用户的原密码，不一致oldPsw会显示出来
        var oldPassword= $(this).val();
        $.ajax({
            url:"/CampusTrading/GetPassword/"+username,
            type:"post",
            success:function (ref) {
                if(ref!=oldPassword){
                    $("#oldPsw").html("原密码不正确，请重新输入");
                    $("#oldPassword").val("").focus();
                }
                else{
                    $("#oldPsw").html("");
                }
            }
        })

    });

    $("#rePassword").blur(function () {//判断2次输入的密码是否一样
        var newPassword=$("#newPassword").val();
        var rePassword=$("#rePassword").val();

        if(newPassword==""){
            $("#pswError").html("请先输入新密码");
            $("#newPassword").val("").focus();
        }
        else if(rePassword!=newPassword){
            $("#pswError").html("两次密码不一致，请重新输入");
            $("#newPassword").val("").focus();
            $("#rePassword").val("");
        }
        else{
            $("#pswError").html("");
        }
    });

    $("#change").click(function () {//点击修改密码
        var newPassword=$("#newPassword").val();
        var rePassword=$("#rePassword").val();
        if(newPassword==""){
            layer.alert('新密码不能为空',function () {
                $("#newPassword").val("").focus();
            });
        }
        $.ajax({
            url:"/CampusTrading/ChangePassword",
            data:{"username":username,"password":newPassword},
            type:"post",
            success:function (ref) {
                if(ref>0){
                    layui.use('layer', function(){
                        var layer = layui.layer;
                        layer.open({
                            title:'重新登录'
                            ,content: '密码修改成功，请点击确定前去重新登录'
                            ,closeBtn: 0
                            ,btn: ['确定']
                            ,shade: [0.1, '#000']
                            ,anim: 4
                            ,yes: function(index, layero){
                                window.parent.location.href="/CampusTrading/Login"
                            }
                            ,cancel: function(){
                                return false;// 开启该代码可禁止点击该按钮关闭
                            }
                        });
                    });

                }else {
                    layui.use('layer', function(){
                        var layer = layui.layer;
                        layer.msg('密码修改失败，当前不是修改密码的好时间哟！请等一会在修改。',{icon: 5,time:2000,anim:3});
                    });
                }

            },
            error: function() {
                alert("修改失败");
            }

        })

    });
</script>
</body>
</html>
