package mapper;

import entity.Productinfo;


import java.util.List;

public interface ProductinfoMapper {
    //操作是商品就到这张表,//数组不好转,list
    //<>泛型,你要的就是p_type,可以是String.是对象-就是方便一点,存储的数据多

    List<String> selectAllp_type();
    int deleteByPrimaryKey(Integer pId);

    int insert(Productinfo record);

    int insertSelective(Productinfo record);

    Productinfo selectByPrimaryKey(Integer pId);

    int updateByPrimaryKeySelective(Productinfo record);

    int updateByPrimaryKey(Productinfo record);
}