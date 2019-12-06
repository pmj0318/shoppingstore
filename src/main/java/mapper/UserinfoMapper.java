package mapper;

import entity.Userinfo;

public interface UserinfoMapper {
    //及时自己定义一个方法
    Userinfo selectByName(String username);

    String selectEmailByUsername(String username);//发送邮箱

    int deleteByPrimaryKey(Integer uId);

    int insert(Userinfo record);

    int insertSelective(Userinfo record);

    Userinfo selectByPrimaryKey(Integer uId);

    int updateByPrimaryKeySelective(Userinfo record);

    int updateByPrimaryKey(Userinfo record);

}