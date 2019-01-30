package com.entity;

/**
 * 购物车实例
 */
public class ShoppingCart {
    /**
     * 购物车ID 用户ID 里面的商品ID
     */
    private int cId;
    private String uName;
    private int gId;
    private String addTime;


    public int getgId() {
        return gId;
    }

    public void setgId(int gId) {
        this.gId = gId;
    }

    public String getuName() {
        return uName;
    }

    public void setuName(String uName) {
        this.uName = uName;
    }

    public int getcId() {
        return cId;
    }

    public void setcId(int cId) {
        this.cId = cId;
    }

    public String getAddTime() {
        return addTime;
    }

    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }
}
