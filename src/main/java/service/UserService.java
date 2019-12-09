package service;

import entity.Userinfo;

import java.util.List;

public interface UserService {
    int selectUidByUsername(String username);

    Userinfo selectByName(String username);

    String selectEmailByUsername(String username);

    int deleteByPrimaryKey(Integer uId);

    int insert(Userinfo record);

    int insertSelective(Userinfo record);

    Userinfo selectByPrimaryKey(Integer uId);

    int updateByPrimaryKeySelective(Userinfo record);

    int updateByPrimaryKey(Userinfo record);
}
