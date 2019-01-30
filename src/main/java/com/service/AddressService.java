package com.service;

import com.dao.AddressDao;
import com.entity.Receive;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AddressService {
    @Autowired
    private AddressDao addressDao;

    public List<Receive> selectAllAddress(String username){//查询所有的收货地址信息
        return addressDao.selectAllAddress(username);
    }

    public Receive selectDefaultAddress(String username){;//查询用户的默认地址
        return addressDao.selectDefaultAddress(username);
    }

    public Receive selectAddressById(int id){
        return addressDao.selectAddressById(id);
    }

    public int addNewAddress(Receive receive){//添加一个新地址
        /**
         * 添加的地址为默认地址时
         */
        if(receive.getIsDefault()==1){
            return addressDao.updateAddressNotDefault(receive.getUsername());
        }
        return addressDao.newAddress(receive);

    }

    public int modifyAddress(Receive receive){//修改用户收货地址信息
        /**
         * 要把某个地址修改为为默认地址时
         */
        if(receive.getIsDefault()==1){
            addressDao.updateAddressNotDefault(receive.getUsername());
        }
        return addressDao.updateAddress(receive);

    }

    public int deleteAddress(int id){//用户删除某条收货地址信息
        return addressDao.deleteAddress(id);
    }

}
