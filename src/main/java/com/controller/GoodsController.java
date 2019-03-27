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
    public String selectGoods(){//所有商品
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

    @RequestMapping("GoodsOfSellerView")
    public String goodsOfSeller(){//卖家进入查看自己正在出售的商品信息页面
        return "Goods/goodsOfSeller";
    }

    @RequestMapping(value = "SelectGoodsBySeller" ,produces="application/json;charset=utf-8")
    @ResponseBody
    public  String selectGoodsBySeller(String sName){//根据卖家的姓名查询卖家正在出售的商品信息
        List<Goods> list=goodsService.selectGoodsBySeller(sName);
        return JSONObject.toJSONString(list);
    }

    @RequestMapping(value = "GetGoodsDetail" ,produces="application/json;charset=utf-8")
    @ResponseBody
    public String getGoodsDetail(int gid){//根据商品ID得到商品详情,
        Goods goods=goodsService.queryGoodsDetail(gid);
        return JSONObject.toJSONString(goods);
    }

    @RequestMapping("ModifyGoodsNum")
    @ResponseBody
    public String modifyGoodsNum(int number,int gId){//卖家发货后，修改商品数量
        int m=goodsService.modifyGoodsNum(number,gId);
        return m>0?"1":"0";
    }

    @RequestMapping("EditGoodsInfo")
    @ResponseBody
    public String editGoodsInfo(Goods goods){//修改商品信息
        int e=goodsService.editGoodsInfo(goods);
        return e>0?"1":"0";
    }

    @RequestMapping("DeleteGoods")
    @ResponseBody
    public String deleteGoods(int gid){
        int d=goodsService.deleteGoodsById(gid);
        return d>0?"1":"0";
    }

    @RequestMapping("AllGoods")
    public String allGoods(){
        return "Goods/allGoods";
    }

    @RequestMapping("GoodsType")
    public String goodsType(){
        return "Goods/goodsType";
    }

    /**
     * 商品类型的管理
     */
    @RequestMapping(value = "QueryGoodsTypeById",produces="text/html;charset=utf-8")
    @ResponseBody
    public String queryGoodsTypeById(int id){
        return goodsService.queryGoodsTypeById(id);
    }

    @RequestMapping("EditGoodsType")
    @ResponseBody
    public String editGoodsType(String name,int id){
        int e= goodsService.editGoodsType(name,id);
        return e>0?"1":"0";
    }

    @RequestMapping("DeleteGoodsType")
    @ResponseBody
    public String deleteGoodsType(int id){
        int d= goodsService.deleteGoodsType(id);
        return d>0?"1":"0";
    }

    @RequestMapping("AddGoodsType")
    @ResponseBody
    public String addGoodsType(String name){
        int a= goodsService.addGoodsType(name);
        return a>0?"1":"0";
    }


}
