package com.dao;

import com.entity.Goods;
import com.entity.GoodsType;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoodsDao {

    /**
     * 得到商品的种类，用户添加商品时选择商品的类型
     * @return
     */
    List<GoodsType> getGoodsType();

    int insertGoods(Goods goods);

    List<Goods> selectGoods();

    List<Goods> queryGoodsByName(String name);

    int selectGoodsNumWithSeller(String username);

    /**
     * 根据卖家的姓名查询卖家正在出售的商品信息，
     * @param username
     * @return
     */
    List<Goods> selectGoodsBySeller(String username);

    Goods queryGoodsDetail(int id);

    int modifyGoodsNum(@Param("number")int number,@Param("gId")int gId);//卖家发货后，修改商品数量

    int editGoodsInfo(Goods goods);

    int deleteGoodsById(int gId);

    String queryGoodsTypeById(int id);

    int editGoodsType(@Param("name")String name,@Param("id")int id);

    int deleteGoodsType(int id);

    int addGoodsType(String name);
}
