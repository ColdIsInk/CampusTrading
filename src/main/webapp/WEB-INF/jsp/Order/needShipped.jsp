<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/1/24
  Time: 11:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>卖家需处理的订单</title>
    <link rel="stylesheet" type="text/css" href="ss/layui.css"/>
</head>
<body>
<div>
    <ul>

    </ul>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    var uName=parent.$("#username").val();//获取买家，用户的用户名
    //var uName='绫清竹';
    $.ajax({
        url:"/CampusTrading/NeedShipped",
        data:{"uName":uName},
        type:"post",
        dataType:"json",
        success:function (data) {
            console.log(data);
        }
    });
</script>

</body>
</html>
