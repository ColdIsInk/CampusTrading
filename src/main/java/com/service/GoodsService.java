package com.service;

import com.dao.GoodsDao;
import com.entity.Goods;
import com.entity.GoodsType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsService {
    @Autowired
    private GoodsDao goodsDao;

    public List<GoodsType> getGoodsType(){//得到商品类型的类表
        return goodsDao.getGoodsType();
    }

    public int insertGoods(Goods goods){//添加新商品
        return  goodsDao.insertGoods(goods);
    }

    public List<Goods> selectGoods(){
        return goodsDao.selectGoods();
    }

    public List<Goods> queryGoodsByName(String name){//跟进商品名模糊查询商品
        return goodsDao.queryGoodsByName(name);
    }

    public int selectGoodsNumWithSeller(String username){
        return goodsDao.selectGoodsNumWithSeller(username);
    }

    public  List<Goods> selectGoodsBySeller(String username){//卖家姓名模糊查询自己正在出售的商品
        return goodsDao.selectGoodsBySeller(username);
    }

    public Goods queryGoodsDetail(int id){//根据ID查看商品详情
        return goodsDao.queryGoodsDetail(id);
    }

    public int modifyGoodsNum(int number,int gId){
        return goodsDao.modifyGoodsNum(number,gId);
    }

    public int editGoodsInfo(Goods goods){
        return goodsDao.editGoodsInfo(goods);
    }

    public int deleteGoodsById(int gId){
        return goodsDao.deleteGoodsById(gId);
    }

    public String queryGoodsTypeById(int id){
        return goodsDao.queryGoodsTypeById(id);
    }

    public int editGoodsType(String name,int id){
        return goodsDao.editGoodsType(name,id);
    }

    public int deleteGoodsType(int id){
        return goodsDao.deleteGoodsType(id);
    }

    public int addGoodsType(String name){
        return goodsDao.addGoodsType(name);
    }

}
