<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/3/25
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品类型管理页面</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        .layui-form{
            margin-left: auto;
            margin-right: auto;
        }
        .layui-table,.layui-table-view{
            margin-top: 0px;
        }
        .add{width: 500px;margin-left: auto;
            margin-right: auto;margin-top: 20px;
        }
        .add button{background: #37e7ff;width: 100px;font-size: 16px;margin-left: 6px;}
        .addType{
            width: 360px;
            height: 40px;margin-top: 10px;
            font-size: 16px;margin-left: auto;margin-right: auto;display: none;
        }
        .addType input{
            width: 220px;
            height: 25px;
            margin-left: 8px;
            border-radius: 4px;border: #56fff2 1px solid;
        }
    </style>
</head>
<body>
<div class="add">
    <button class="layui-btn" id="add" title="添加">添加</button>
</div>
<table id="goodsTypeTable" class="layui-table" lay-filter="goodsType"></table>

<div class="addType" id="addType">
    商品类型名称: <input type="text" id="typeName">
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<!--在表格的每行数据后加编辑和删除按钮-->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-sm" lay-event="keep" title="保存">保存</a>
    <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="delete" title="删除">删除</a>
</script>

<script>
    //加载商品类型表格
    $.ajax({
        url: "/CampusTrading/GetGoodsType",
        type: "post",
        async: false,
        dataType: "json",
        success: function (res) {
            layui.use(['table', 'layer'], function () {
                var table = layui.table;
                var layer = layui.layer;
                table.render({
                    elem: '#goodsTypeTable'
                    ,width:490
                    , cols: [[ //表头
                        {field: 'id', title: '商品类型编号', width: 130}
                        , {field: 'name', title: '商品类型名',width:216,edit:"text"}
                        , {fixed: 'right', title: '操作', width: 140, align: 'center', toolbar: '#barDemo'}
                    ]]
                    , data: res
                    , page: true //开启分页
                    , limit: 5
                    , limits: [5, 10, 15]
                });
                table.on('tool(goodsType)', function(obj){ //注：tool 是工具条事件名，goods 是 table 原始容器的属性 lay-filter="对应的值"
                    var data = obj.data //获得当前行数据
                        ,layEvent = obj.event; //获得 lay-event 对应的值
                    var id=parseInt(data.id);
                    //点击表格中某行最后一列的删除按钮
                    if(layEvent === 'delete'){
                        layer.confirm('您确认要删除该种商品类型吗吗？', function(index){
                            layer.close(index);
                            $.ajax({
                                url:"/CampusTrading/DeleteGoodsType",
                                data:{"id":id},
                                type:"post",
                                success: function (ref) {
                                    if (ref == "1") {
                                            layer.msg("删除成功", {icon: 1, time: 1500},function () {
                                                location.reload();
                                            })
                                    }
                                    else {
                                            layer.alert("删除失败", {icon: 1});
                                    }
                                }
                            });
                        });
                    }
                    //点击表格中某行最后一列的保存按钮
                    else {
                        $.ajax({
                            url:"/CampusTrading/EditGoodsType",
                            data:{"name":data.name,"id":id},
                            type:"post",
                            success:function (ref) {
                                if (ref == "1") {
                                    layer.msg("保存成功", {icon: 1, time: 1500})
                                }
                                else {
                                    layer.alert("保存失败", {icon: 1});
                                }
                            }
                        })

                    }

                });
            });
        }
    });
    //点击添加按钮
    $("#add").click(function () {
        layer.open({
            type:1,
            title:['添加商品类型','background: #91ffdb;font-size:18px'],
            btn:['添加','取消'],
            anim:3,
            area:["400px",'160px'],
            shade: [0.4, '#cccccc'],
            content:$('#addType'),
            cancel:function (index) {
                $('#addType').hide();
            }
            ,yes: function(index){
                //点击弹窗层的确认按钮，执行添加操作
                var name=$("#typeName").val();
                if(name==""){
                    layer.msg("请输入商品类型的名字", {icon: 1, time: 1500},function () {
                        $("#typeName").focus();
                    });
                }
                else {
                    $.ajax({
                        url:"/CampusTrading/AddGoodsType",
                        data:{"name":name},
                        type:"post",
                        success:function (res) {
                            if (ref == "1") {
                                layer.msg("添加成功", {icon: 1, time: 1500},function () {
                                    location.reload();
                                })
                            }
                            else {
                                layer.alert("添加失败", {icon: 1});
                            }
                        }
                    })
                }


            }
            ,btn2: function(index){
                layer.close(index);
                $('#addType').hide();
            }
        });
    });
</script>
</body>
</html>
