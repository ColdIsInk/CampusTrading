<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2018/12/16
  Time: 21:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户列表页面</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        table tbody a:hover{color: rgba(238,72,86,0.98)}
    </style>
</head>
<body>

<table id="usersTable" class="layui-table" lay-filter="users"></table>


<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<!--在表格的每行数据后加编辑和删除按钮-->
<script type="text/html" id="barDemo">

    <a class="layui-btn layui-btn-sm" lay-event="edit" title="编辑">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del" title="删除">删除</a>
</script>
<!--判断性别，1改为男，0改为女-->
<script type="text/html" id="sexDemo">
    {{#if (d.sex == 1) { }}
    <span>男</span>
    {{# }else if(d.sex == 0){ }}
    <span>女</span>
    {{# } }}
</script>

<script>
    //加载用户的表格
    layui.use('table', function(){
        var table = layui.table;
        table.render({
            elem: '#usersTable'
            ,cols: [[ //表头
                {field: 'id', title: '编号'}
                ,{field: 'username', title: '姓名'}
                ,{field: 'age', title: '年龄'}
                ,{field: 'sex', title: '性别' ,toolbar:'#sexDemo'}
                ,{field: 'phone', title: '电话号码'}
                ,{field: 'email', title: '邮箱'}
                ,{fixed: 'right',title:'操作', width: 180, align:'center', toolbar: '#barDemo'}
            ]]
            ,data:${users}
            ,page: true //开启分页
            ,limit:5
            ,limits:[5,8,10]
        });

        //执行table中的编辑和删除按钮，实现编辑、删除数据
        table.on('tool(users)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'del'){
                layer.confirm('真的删除该行记录么', function(index){
                    layer.close(index);
                    $.ajax({
                        url:"/CampusTrading/DeleteUser/",
                        data:{"id":data.id},
                        type:"post",
                        success: function (ref) {
                            if (ref == "1") {
                                layui.use("layer", function () {
                                    var layer = layui.layer;
                                    location.reload();
                                    layer.msg("删除成功", {icon: 1, time: 2000})
                                });
                            }
                            else {
                                layui.use("layer", function () {
                                    var layer = layui.layer;
                                    layer.alert("删除成功", {icon: 1})
                                });
                            }

                        }
                    });
                });
            }else if(layEvent === 'edit'){
                location.href="/CampusTrading/EditUser/"+data.id;
            }
        });

    });






</script>
</body>
</html>
