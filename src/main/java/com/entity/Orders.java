package com.entity;

/**
 * 订单实体类
 */
public class Orders {
    /**
     * 订单ID 卖家ID 买家ID 商品ID
     */
    private int oId;
    private String sName;
    private String uName;
    private int receiveId;
    private int gId;
    private double unitPrice;
    private double totalPrice;
    private String buyerNote;

    private int goodsNumber;
    /**
     * 订单的状态，1创建成功,2付款成功，3正在发货，4交易成功，0交易未成功订单取消
     */
    private int state;
    /**
     * 创建时间  发货时间  成交时间
     *  to_date(#{CREATE_DATE}, 'YYYY/MM/DD HH24:mi:ss' )
     */
    private String createTime;
    private String shipTime;
    private String clinchTime;


    public int getGoodsNumber() {
        return goodsNumber;
    }

    public void setGoodsNumber(int goodsNumber) {
        this.goodsNumber = goodsNumber;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getClinchTime() {
        return clinchTime;
    }

    public void setClinchTime(String clinchTime) {
        this.clinchTime = clinchTime;
    }

    public String getShipTime() {
        return shipTime;
    }

    public void setShipTime(String shipTime) {
        this.shipTime = shipTime;

    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public int getoId() {
        return oId;
    }

    public void setoId(int oId) {
        this.oId = oId;
    }


    public int getgId() {
        return gId;
    }

    public void setgId(int gId) {
        this.gId = gId;
    }

    public String getsName() {
        return sName;
    }

    public void setsName(String sName) {
        this.sName = sName;
    }

    public String getuName() {
        return uName;
    }

    public void setuName(String uName) {
        this.uName = uName;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getBuyerNote() {
        return buyerNote;
    }

    public void setBuyerNote(String buyerNote) {
        this.buyerNote = buyerNote;
    }

    public int getReceiveId() {
        return receiveId;
    }

    public void setReceiveId(int receiveId) {
        this.receiveId = receiveId;
    }
}
