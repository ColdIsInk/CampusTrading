<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/1/2
  Time: 21:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>公告列表页面</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        .layui-table{width: 95%;margin-right: auto;margin-left: auto;}
        .layui-btn-danger:hover{color: rgba(238,65,124,0.98);text-decoration: underline;cursor: pointer;}
        .editNotice{display: none;}
        .noticeDetail{width: 420px;height:256px;margin-right: auto;
            margin-left: auto;}
        .noticeDetail h3{width:100%;text-align: center;margin-top: 16px;
            font-weight: 600;font-family: 华文行楷;font-size: 32px}
        .noticeCon{
            margin-top: 10px;
        }
        .noticeCon span{
            display: inline-block;
            height: 30px;
            line-height: 30px;
            font-size: 16px;
            margin-right: 10px;
            text-align: center;

        }
        .noticeCon input[type=text]{
            width: 320px;
            height: 30px;
            padding-left: 4px;
        }

        .noticeCon textarea{
            width: 320px;
            height: 90px;
        }
        .layui-form-radio{margin-top: 0px;padding: 0;}
        .layui-form-radio>i{font-size: 18px}
    </style>
</head>
<body>
<table id="noticesTable" class="layui-table" lay-filter="test"></table>
<!--某条公告的具体内容的弹窗-->
<div id="editNotice" class="editNotice">
<form class="noticeDetail layui-form" id="form">
    <h3>修改公告内容</h3>
    <div class="noticeCon">
        <span>公告编号:</span><input type="text" name="id" id="noticeId" readonly>
    </div>
    <div class="noticeCon">
        <span>公告标题:</span><input type="text" name="title" id="noticeTitle">
    </div>
    <div class="noticeCon">
        <span style="float: left">公告内容:</span><textarea name="content" id="content"></textarea>
    </div>
    <div class="noticeCon">
        <span>公告状态:</span><input type="radio" name="state" title="可看" value="1" checked>
               <input type="radio" name="state" title="过期" value="0">
    </div>
</form>
</div>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<!--在表格的最右边加上一个删除按钮，编辑公告-->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-warm layui-btn-sm" lay-event="edit" title="编辑">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del" title="删除">删除</a>
</script>
<script>
    $.ajax({
        url:"/CampusTrading/GetAllNotices",
        type:"post",
        async:false,
        dataType:"json",
        success:function (res) {
            layui.use(['table','layer'], function(){
                var table = layui.table;
                var layer = layui.layer;
                table.render({
                    elem: '#noticesTable'
                    ,cols: [[ //表头
                        {field: 'id', title: '编号',width:80}
                        ,{field: 'title', title: '标题',width:280}
                        ,{field: 'content', title: '内容'}
                        ,{fixed: 'right',title:'操作', width: 160, align:'center', toolbar: '#barDemo'}
                    ]]
                    ,data:res
                    ,page: true //开启分页
                    ,limit:5
                    ,limits:[5,8,10]
                });

                //执行table中的删除，删除数据
                table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                    var data = obj.data //获得当前行数据
                        ,layEvent = obj.event; //获得 lay-event 对应的值
                    if(layEvent === 'del'){
                        layer.confirm('真的删除行么', function(index){
                            layer.close(index);
                            $.ajax({
                                url:"/CampusTrading/DeleteNotice/"+data.id,
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
                    }
                    else if(layEvent === 'edit'){//编辑
                        $.ajax({
                            url:"/CampusTrading/QueryNoticeById",
                            data:{"id":data.id},
                            type:"post",
                            async:false,
                            dataType:"json",
                            success:function (ref) {
                                $("#noticeId").val(ref.id);
                                $("#noticeTitle").val(ref.title);
                                $("#content").val(ref.content);
                                layer.open({
                                    type: 1,
                                    title: ['修改公告内容', 'font-size:18px;'],
                                    content: $('#editNotice'),
                                    btn: ['修改', '取消'],
                                    shade: [0.6, '#cccccc'],
                                    anim: 4,
                                    area: ['500px', '400px'],
                                    cancel: function (index) {
                                            layer.close(index);
                                            $("#editNotice").hide();
                                        },
                                    yes: function (index) {//点击修改按钮
                                            $.ajax({
                                                url:"/CampusTrading/EditNotice",
                                                data:$("#form").serialize(),
                                                type:"post",
                                                success:function (data) {
                                                    if(data>0){
                                                        layer.msg('修改公告成功',{icon:1,time:2000,anim:3});
                                                        window.location.reload();
                                                    }else {
                                                        layer.msg('修改公告失败',{icon:2,time:2000,anim:3});
                                                    }

                                                }
                                            });
                                            layer.close(index);
                                            $("#editNotice").hide();
                                        },
                                    btn2: function (index) {//取消修改按钮
                                            layer.close(index);
                                            $("#editNotice").hide();
                                        },

                                });


                            }
                        });

                    }
                });

            });

        }
    });

</script>

</body>
</html>
