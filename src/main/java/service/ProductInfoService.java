package service;

import entity.Productinfo;

import java.util.List;

public interface ProductInfoService {

    int selectTotallPage( String p_type);//计算总的条数

    List<Productinfo> selectAllProductsByP_type(String p_type,Integer page);
    //操作是商品就到这张表,//数组不好转,list
    //<>泛型,你要的就是p_type,可以是String.是对象

    List<String> selectAllp_type();
    int deleteByPrimaryKey(Integer pId);

    int insert(Productinfo record);

    int insertSelective(Productinfo record);

    Productinfo selectByPrimaryKey(Integer pId);

    int updateByPrimaryKeySelective(Productinfo record);

    int updateByPrimaryKey(Productinfo record);
}
