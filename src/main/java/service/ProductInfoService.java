package service;

import entity.Productinfo;

import java.util.List;

public interface ProductInfoService {

    //day12根据商品查询,所有的商品显示,只需要一个参数
    List<Productinfo> selectAllProductsByP_types(String p_type);

    //查询商品上下架
    List<Productinfo> selectUpAndDownProducts();

    int selectTotallPage( String p_type);//计算总的条数

    List<Productinfo> selectAllProductsByP_type(String p_type,Integer page);
    //操作是商品就到这张表,//数组不好转,list//<>泛型,你要的就是p_type,可以是String.是对象.这个是两个参数

    List<String> selectAllp_type();
    int deleteByPrimaryKey(Integer pId);

    int insert(Productinfo record);

    int insertSelective(Productinfo record);

    Productinfo selectByPrimaryKey(Integer pId);

    int updateByPrimaryKeySelective(Productinfo record);

    int updateByPrimaryKey(Productinfo record);
}
