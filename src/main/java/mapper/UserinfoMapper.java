package mapper;

import entity.Userinfo;

public interface UserinfoMapper {

    int selectUidByUsername(String username);//根据用户名查询到id

    String selectEmailByUsername(String username);//发送邮箱

    Userinfo selectByName(String username);    //及时自己定义一个方法

    int deleteByPrimaryKey(Integer uId);

    int insert(Userinfo record);

    int insertSelective(Userinfo record);

    Userinfo selectByPrimaryKey(Integer uId);

    int updateByPrimaryKeySelective(Userinfo record);

    int updateByPrimaryKey(Userinfo record);

}