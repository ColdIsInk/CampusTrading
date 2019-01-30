package com.dao;

import com.entity.Receive;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 收货地址
 */
@Repository
public interface AddressDao {
    List<Receive> selectAllAddress(String username);//查询所有的收货地址信息

    Receive selectDefaultAddress(String username);//查询用户的默认地址

    Receive selectAddressById(int id);//根据id查询一条收货地址的信息，用来编辑查看

    int newAddress(Receive receive);//添加一个新的收货地址信息,

    int updateAddressNotDefault(String username);//把这个用户下面的所有收货地址都改为非默认

    int updateAddress(Receive receive);//修改收货地址的信息，


    int deleteAddress(int id);//删除某天收货地址信息
}
