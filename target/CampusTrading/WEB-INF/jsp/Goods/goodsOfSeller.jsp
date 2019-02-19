<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/2/1
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>卖家正在出售的商品</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        .noGoods{width: 600px;margin-left: auto;margin-right: auto;margin-top: 30px;display: none;}
        .noGoods span{color: #666666;}
        .noGoods span a:hover{color: #ff48b1;font-size: 16px;margin-left: 6px;cursor: pointer;}
        .allGoodsInfo{width: 800px;margin-left: auto;margin-right: auto;margin-top: 20px;}
        .allGoodsInfo ul li{width:100%;height: 150px;margin-top: 10px;background: #e0d2ff}
        .allGoodsInfo ul li div{float: left}
        .allGoodsInfo ul li div img{width: 160px;height: 140px;margin-top: 5px;margin-left: 10px;}
        .allGoodsInfo ul li p{margin-top: 8px;}
        .allGoodsInfo .gName{width: 300px;height: 128px;margin-left: 20px;text-align: center;margin-top:20px;}
        .allGoodsInfo .price{width: 120px;margin-left: 30px;margin-top:30px;}
        .allGoodsInfo .price span{color: #ff8511;font-size: 16px;}
        .allGoodsInfo .edit{width: 120px;margin-left: 20px;margin-top:50px;}
        .allGoodsInfo ul li .edit button{border-radius: 10px;}
        .oneGoodsInfo{width: 394px;height: 340px;margin-left: auto;margin-right: auto;background: #e7ffda}
        .oneGoodsInfo form{padding-top: 20px;}
        .oneGoodsInfo form div{width: 390px;margin-top: 8px;}
        .oneGoodsInfo form div label{display:inline-block;margin-left: 10px;width: 60px;}
        .oneGoodsInfo form div input{margin-left: 8px;width: 300px;height: 30px;}
        .oneGoodsInfo form div textarea{margin-left: 10px;width: 300px;height: 90px;resize:none;}
        .oneGoodsInfo form div select{margin-left: 8px;width: 300px;height: 30px;}
        .oneGoodsInfo .btn{margin-top: 30px;margin-left: 78px;width: 200px;}
        .oneGoodsInfo .btn button:nth-child(2){margin-left: 26px;}
    </style>
</head>
<body>
<!--没有正在出售的商品时-->
<div class="noGoods" id="noGoods">
    <img src="images/noGoods.png">
    <span>您还没有正在出售的货物哟,<a id="addGoods" title="添加商品">点击去添加商品</a></span>
</div>
<!--正在出售的所有商品的基本信息-->
<div class="allGoodsInfo" id="allGoodsInfo">
    <ul class="allGoodsInfoUI" id="allGoodsInfoUI"></ul>
</div>

<!--当点击每个商品后面的编辑按钮后，弹出该商品的基本信息，进行修改-->
<div class="oneGoodsInfo" id="oneGoodsInfo">
    <form id="form" enctype="multipart/form-data">
        <div>
            <label>商品名称</label>
            <input type="text" name="name" id="name">
        </div>
        <div>
            <label style="float: left;">商品描述</label>
            <textarea name="content" id="content">
            </textarea>
        </div>
        <div>
            <label>商品类型</label>
            <select name="type_id" id="typeId" lay-verify=""></select>
        </div>
        <div>
            <label>商品数量</label>
            <input type="number" name="number" id="number" min="1">
        </div>
        <div>
            <label>商品价格</label>
            <input type="text" name="price" id="price">
        </div>
    </form>
    <div class="btn">
        <button class="layui-btn layui-btn-warm" id="keep" title="保存">保存</button>
        <button class="layui-btn layui-btn-normal" id="cancel" title="取消">取消</button>
    </div>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    //var sName=parent.$("#username").val();//获取卖家，用户的用户名
    var sName='云龙';
    //ajax请求获取卖家正在出售中商品的信息
    $.ajax({
        url:"/CampusTrading/SelectGoodsBySeller",
        data:{"sName":sName},
        type:"post",
        dataType:"json",
        success:function (data) {
            var infoHtml="";
            for(var i=0;i<data.length;i++){
               infoHtml+="<li><div><img src='"+data[i].picture+"'></div><div class='gName'>" +
                   "<p>"+data[i].name+"</p><p>"+data[i].content+"</p></div><div class='price'>" +
                   "<p>单价:&emsp;<span>￥"+data[i].price+"</span></p><p>库存:&emsp;"+data[i].number+"件</p>" +
                   "</div><div class='edit'> <button class='layui-btn layui-btn-warm' onclick='editGoods("+data[i].g_id+")' " +
                   "title='修改'>编辑商品信息</button></div></li>";
            }
            $("#allGoodsInfoUI").append(infoHtml);

        }
    });

    //获取商品的所有的类型
    $.ajax({
        url:"/CampusTrading/GetGoodsType",
        type:"post",
        dataType:"json",
        success:function (res) {
            var option="";
            for(var i=0;i<res.length;i++){
                option+="<option value='"+res[i].id+"'>"+res[i].name+"</option>";
            }
            $("#typeId").append(option);
        }
    });

    //当这个卖家没有货物在出售时，点击添加货物的按钮，进入添加商品的页面
    $("#addGoods").click(function () {
        location.href="/CampusTrading/AddGoods/"+sName;
    });

    //点击编辑商品信息按钮，对商品进行的内容进行修改
    function editGoods(gId) {
        //先根据商品ID请求商品的基本信息
        $.ajax({
            url:"/CampusTrading/GetGoodsDetail",
            data:{"gid":gId},
            type:"post",
            dataType:"json",
            success:function (data) {
                //该表单里面的东西赋值
                $("#name").val(data.name);
                $("#content").val(data.content);
                $("#typeId").val(data.type_id);
                $("#number").val(data.number);
                $("#price").val(data.price);
            }
        })
    }

    //点击编辑里面的保存按钮，对修改的商品信息进行修改
    $("#keep").click(function () {
        var form=$("#form").serialize();
        console.log(form);
    });
    //点击编辑里面的取消按钮，取消修改，隐藏改件商品的信息
    $("#cancel").click(function () {
        
    });

</script>
</body>
</html>
