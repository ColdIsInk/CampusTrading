package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.Goods;
import com.entity.GoodsType;
import com.entity.User;
import com.service.GoodsService;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
public class GoodsController {
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private UserService userService;

    @RequestMapping("AddGoods/{username}")
    public String addGoods(HttpServletRequest request,@PathVariable("username")String username){//去到发布商品的页面
        User user=userService.getUserByName(username);
        int uId=user.getId();
        request.setAttribute("uId", uId);
        return "Goods/addGoods";
    }

    @RequestMapping(value="GetGoodsType",method = RequestMethod.POST,produces="application/json;charset=utf-8")
    @ResponseBody
    public String getGoodsType(){//查询商品的所有类型
        List<GoodsType> goodsType= goodsService.getGoodsType();
        String type=JSONObject.toJSONString(goodsType);
        return type;
    }

    @RequestMapping(value="PublishGoods",method=RequestMethod.POST,consumes = "multipart/form-data")
    @ResponseBody
    public String publishGoods(@RequestParam("photo") MultipartFile file,
                               HttpServletRequest request, Goods goods, Model model)throws IOException {
        String sqlPath = null;
        //获取文件名
        String filename = file.getOriginalFilename();
        //获取文件保存到服务器上的地址
        String path = request.getServletContext().getRealPath("") + "images/goods_pic/" + filename;
        String CTpath="/CampusTrading/images/goods_pic/" + filename;

        File f = new File(path);
        //判断upload文件夹是否存在，如果不存在则创建
        if (!f.getParentFile().exists()) {
            f.getParentFile().mkdirs();
        }
        //将上传的文件传输到指定路径
        file.transferTo(f);
        File c = new File(CTpath);
        //判断upload文件夹是否存在，如果不存在则创建
        if (!c.getParentFile().exists()) {
            c.getParentFile().mkdirs();
        }
        //将上传的文件传输到指定路径
        file.transferTo(c);
        //用户编号是否唯一
        //传入照片地址进数据库
        sqlPath = "/CampusTrading/images/goods_pic/" + filename;
        goods.setPicture(sqlPath);
        int g=goodsService.insertGoods(goods);
        if(g>0){
            return "1";
        }else {
            return "0";
        }


    }

    @RequestMapping(value = "SelectGoods",produces="application/json;charset=utf-8")
    @ResponseBody
    public String selectGoods(){
        List<Goods> list=goodsService.selectGoods();
        return JSONObject.toJSONString(list);
    }

    @RequestMapping(value="QueryGoodsByName/{name}",produces="application/json;charset=utf-8")
    @ResponseBody
    public String queryGoodsByName(@PathVariable("name")String name){//用户根据商品名或类型搜索商品
        List<Goods> queryGoods=goodsService.queryGoodsByName(name);
        return JSONObject.toJSONString(queryGoods);
    }

    @RequestMapping(value = "QueryGoodsDetail/{id}" ,produces="application/json;charset=utf-8")
    public String queryGoodsDetail(@PathVariable("id")int id,Model model){//查看商品详情,进入查看商品详情页面
        Goods goods=goodsService.queryGoodsDetail(id);
        model.addAttribute("Goods",goods);
        return "Goods/goodsDetail";
    }

    @RequestMapping("SelectGoodsNum")
    @ResponseBody
    public String selectGoodsNumBySeller(String username){//根据卖家的姓名查询卖家正在出售的商品数量
        int s=goodsService.selectGoodsNumWithSeller(username);
        return String.valueOf(s);
    }

    @RequestMapping(value = "SelectGoodsBySeller" ,produces="application/json;charset=utf-8")
    @ResponseBody
    public  String selectGoodsBySeller(String username){//根据卖家的姓名查询卖家正在出售的商品信息
        List<Goods> list=goodsService.selectGoodsBySeller(username);
        return JSONObject.toJSONString(list);
    }

    @RequestMapping(value = "GetGoodsDetail" ,produces="application/json;charset=utf-8")
    @ResponseBody
    public String getGoodsDetail(int gid){//查看商品详情,进入查看商品详情页面
        Goods goods=goodsService.queryGoodsDetail(gid);
        return JSONObject.toJSONString(goods);
    }

}
