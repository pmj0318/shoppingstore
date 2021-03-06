package serviceImpl;

import entity.Productinfo;
import mapper.ProductinfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.ProductInfoService;

import java.util.List;
@Service
//就是获取springmvc.xml那个bean里面了
public class ProductInfoServiceImpl implements ProductInfoService {
    //为什么?spring-mybatis已经扫描了,mapper,所以可以注入
    @Autowired
    ProductinfoMapper pfm;


    @Override
    public List<Productinfo> selectAllProductsByP_types(String p_type) {//上下架根据type查询所有的产品
        return pfm.selectAllProductsByP_types(p_type);
    }

    @Override
    public List<Productinfo> selectUpAndDownProducts() {//查询商品上下架
        return pfm.selectUpAndDownProducts();
    }

    @Override
    public int selectTotallPage(String p_type) {
        return pfm.selectTotallPage(p_type);
    }

    @Override
    public List<Productinfo> selectAllProductsByP_type(String p_type,Integer page) {
        return pfm.selectAllProductsByP_type(p_type,page);
    }

    @Override
    public List<String> selectAllp_type() {
        return pfm.selectAllp_type();
    }

    @Override
    public int deleteByPrimaryKey(Integer pId) {
        return pfm.deleteByPrimaryKey(pId);
    }

    @Override
    public int insert(Productinfo record) {
        return pfm.insert(record);
    }

    @Override
    public int insertSelective(Productinfo record) {
        return pfm.insertSelective(record);
    }

    @Override
    public Productinfo selectByPrimaryKey(Integer pId) {
        return pfm.selectByPrimaryKey(pId);
    }

    @Override
    public int updateByPrimaryKeySelective(Productinfo record) {
        return pfm.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Productinfo record) {
        return pfm.updateByPrimaryKey(record);
    }
}
