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
    <title>所有商品管理员页面</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
</head>
<body>
<table id="goodsTable" class="layui-table" lay-filter="goods"></table>


<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<!--在表格的每行数据后加编辑和删除按钮-->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger" lay-event="delete" title="下架商品">下架</a>
</script>
<!--商品类型-->
<script type="text/html" id="goodsType">


</script>

<script>
    $.ajax({
        url: "/CampusTrading/SelectGoods",
        type: "post",
        async: false,
        dataType: "json",
        success: function (res) {
            layui.use(['table', 'layer'], function () {
                var table = layui.table;
                var layer = layui.layer;
                table.render({
                    elem: '#goodsTable'
                    , cols: [[ //表头
                        {field: 'g_id', title: '商品编号', width: 100}
                        , {field: 'name', title: '商品名',width:160}
                        , {field: 'price', title: '单价(元)',width:100}
                        , {field: 'number', title: '商品库存',width:100}
                        , {field: 'type_id', title: '商品类型', width: 130}
                        , {field: 'content', title: '商品描述'}
                        , {field: 'u_id', title: '卖家姓名',width:120}
                        , {fixed: 'right', title: '操作', width: 80, align: 'center', toolbar: '#barDemo'}
                    ]]
                    ,done: function(res, page, count){
                        //根据每列的商品类型的编号，来查询商品类型的名称
                        $("[data-field='type_id']").children().each(function(){
                            var typeID=$(this);
                            var id=parseInt($(this).text());
                            $.ajax({
                                url:"/CampusTrading/QueryGoodsTypeById",
                                data:{"id":id},
                                type:"post",
                                success:function (ref) {
                                    typeID.text(ref);
                                }
                            })
                        });
                        //根据每列的卖家的编号来查询并显示出卖家的姓名
                        $("[data-field='u_id']").children().each(function(){
                            var name=$(this);
                            var nameId=parseInt($(this).text());
                            $.ajax({
                                url:"/CampusTrading/GetNameById",
                                data:{"id":nameId},
                                type:"post",
                                success:function (ref) {
                                    name.text(ref);
                                }
                            })
                        });

                    }
                    , data: res
                    , page: true //开启分页
                    , limit: 8
                    , limits: [8, 12, 16]
                });
                table.on('tool(goods)', function(obj){ //注：tool 是工具条事件名，goods 是 table 原始容器的属性 lay-filter="对应的值"
                    var data = obj.data //获得当前行数据
                        ,layEvent = obj.event; //获得 lay-event 对应的值
                    console.log(data);
                    if(layEvent === 'delete'){
                        layer.confirm('您确认要下架该商品吗？', function(index){
                            layer.close(index);
                            $.ajax({
                                url:"/CampusTrading/DeleteGoods",
                                data:{"gid":data.g_id},
                                type:"post",
                                success: function (ref) {
                                    if (ref == "1") {
                                            layer.msg("下架成功", {icon: 1, time: 1500},function () {
                                                location.reload();
                                            })
                                    }
                                    else {
                                            layer.alert("下架失败", {icon: 1})
                                    }

                                }
                            });
                        });
                    }

                });
            });
        }
    });
</script>
</body>
</html>
