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
