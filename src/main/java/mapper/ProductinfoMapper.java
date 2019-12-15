package mapper;

import entity.Productinfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductinfoMapper {

    //day12根据上下架商品查询,所有的商品显示,只需要一个参数
    List<Productinfo> selectAllProductsByP_types(String p_type);

    /*day11上下架：查询为0或为0的商品信息，使其上下架*/
    List<Productinfo> selectUpAndDownProducts();

    int selectTotallPage( String p_type);//计算总条数


    //根据种类查询,多个参数传值需要指定,因为与数据库打交道,他需要指定,其他的不需要g改
    List<Productinfo> selectAllProductsByP_type(@Param(value = "p_type") String p_type, @Param(value="page") Integer page);

    //操作是商品就到这张表,//数组不好转,list//<>泛型,你要的就是p_type,可以是String.是对象-就是方便一点,存储的数据多
    List<String> selectAllp_type();

    int deleteByPrimaryKey(Integer pId);

    int insert(Productinfo record);

    int insertSelective(Productinfo record);

    Productinfo selectByPrimaryKey(Integer pId);

    int updateByPrimaryKeySelective(Productinfo record);   /*商品上下架需要修改商品表中Status商品状态信息*/

    int updateByPrimaryKey(Productinfo record);
}