package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.Receive;
import com.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class AddressController {
    @Autowired
    private AddressService addressService;

    /**
     * /进入我的收货地址页面
     */
    @RequestMapping( "ReceiptAddress/{username}")
    public String receiptAddress(@PathVariable("username")String username, HttpServletRequest request){
        request.setAttribute("username",username);
        return "Address/receiptAddress";
    }

    @RequestMapping(value = "QueryAllAddress",produces="application/json;charset=utf-8")
    @ResponseBody
    public String queryAllAddress(String username){//查询某个用户的所有收货地址
        List<Receive> list=addressService.selectAllAddress(username);
        return JSONObject.toJSONString(list);
    }

    @RequestMapping(value = "QueryDefaultAddress",produces="application/json;charset=utf-8")
    @ResponseBody
    public String queryDefaultAddress(String username){//查询用户的默认地址
        Receive receive=addressService.selectDefaultAddress(username);
        return JSONObject.toJSONString(receive);
    }

    @RequestMapping(value = "QueryAddressById",produces="application/json;charset=utf-8")
    @ResponseBody
    public String queryAddressById(int id){//根据收货地址的id来查询详细信息
        Receive receive=addressService.selectAddressById(id);
        return JSONObject.toJSONString(receive);
    }

    @RequestMapping("AddNewAddress")
    @ResponseBody
    public String addNewAddress(String username,String receiveMan,String receiveAddress,String receiveTel,int isDefault){
        //添加一条新的收货地址
        Receive receive=new Receive();
        receive.setUsername(username);
        receive.setReceiveMan(receiveMan);
        receive.setReceiveAddress(receiveAddress);
        receive.setReceiveTel(receiveTel);
        receive.setIsDefault(isDefault);
        int n=addressService.addNewAddress(receive);
        return n>0?"1":"0";
    }

    @RequestMapping("ModifyAddress")
    @ResponseBody
    public String modifyAddress(Receive receive){//修改自己收货地址
        System.out.print(receive);
        int m=addressService.modifyAddress(receive);
        return m>0?"1":"0";
    }

    @RequestMapping("DeleteAddress")
    @ResponseBody
    public String delelteAddress(int id){//删除一条收货地址
        int d=addressService.deleteAddress(id);
        return d>0?"1":"0";
    }

}
