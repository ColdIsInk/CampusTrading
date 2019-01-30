<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2018/12/26
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-cn">
<head>
    <title>发布新商品</title>
    <link rel="stylesheet" type="text/css" href="../css/layui.css"/>
    <style>
        h2{ width: 380px;text-align: center;margin-top: 60px; margin-left: auto;
            margin-right: auto;font-weight: 600;font-family: 华文行楷;font-size: 32px}
        form{
            width: 380px;
            height: 310px;
            margin-top: 10px;
            margin-left: auto;
            margin-right: auto;
        }
        .input_in{width: 380px;height: 40px;margin-left: auto;margin-right: auto;}
        .input_in>span,.goodsDetail>span{display: inline-block;width: 78px;height: 34px;line-height: 32px;
            font-size: 16px;margin-top: 10px;text-align: center;margin-left: 4px;
        }
        .input_in>input,.input_in>select{width: 280px;height: 34px;border-radius: 6px;
            border: rgba(167,232,238,0.98) solid 1px;padding-left: 4px;}

        .goodsDetail{width:380px;height: 72px;margin-left: auto;margin-right: auto;margin-top: 10px;}
        .goodsDetail textarea{width: 280px;height: 70px;border-radius: 6px;margin-left: 4px;
            border: rgba(167,232,238,0.98) solid 1px;padding-left: 4px;}
        .goodsDetail>span{float: left;margin-top: 20px;}
        form button{margin-left: 88px;margin-top: 24px}

    </style>
</head>
<body>
<h2>发布新商品</h2>
<form id="form" enctype="multipart/form-data">
    <div class="input_in">
        <span>商品名称</span>
        <input type="text" name="name" required id="name" placeholder=" 请输入商品名称" >
    </div>
    <div class="input_in">
        <span>商品价格</span>
        <input type="text" name="price" required id="price" min="0" placeholder=" 请输入商品价格">
    </div>
    <div class="input_in">
        <span>商品数量</span>
        <input type="number" name="number" required id="number" min="1" placeholder=" 请输入商品数量">
    </div>
    <div class="input_in">
        <span>商品类型</span>
        <select name="type_id" id="typeId" lay-verify="">
        </select>
    </div>
    <div class="goodsDetail">
        <span>商品详情</span>
        <textarea type="text" name="content" id="describe" placeholder=" 情描述商品的详细情况"></textarea>
    </div>
    <div class="input_in">
        <span>商品图片</span>
        <input type="file" name="photo" required id="picture" >
    </div>
    <input type="hidden" id="sellerId" name="uId" value="${uId}">

    <button class="layui-btn layui-btn-normal" id="publish">发布</button>
    <button type="reset" class="layui-btn layui-btn-danger">重置</button>
</form>

<div id="test"></div>
<script src="../js/jquery-3.2.1.min.js"></script>
<script src="../js/layui.all.js"></script>
<script>
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

    //点击发布按钮，发布新商品
    $("#publish").click(function () {
        var formData = new FormData($("#form")[0]);
        $.ajax({
            url:"/CampusTrading/PublishGoods",
            type:"post",
            async: false,
            cache: false,//上传文件无需缓存
            processData: false,//用于对data参数进行序列化处理 这里必须false
            contentType: false, //必须
            data:formData,
            success:function (data) {
                if(data=="1"){
                    layui.use('layer', function(){
                        var layer = layui.layer;
                        layer.msg('成功发布新商品!',{icon: 1,time:2000,anim:3});
                    });
                }else {
                    layui.use('layer', function(){
                        var layer = layui.layer;
                        layer.alert('抱歉，发布新商品失败。',{icon: 5,time:2000,anim:3});
                    });
                }
            }
        })
    });




</script>
</body>
</html>
