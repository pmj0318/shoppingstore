package serviceImpl;

import entity.Userinfo;
import mapper.UserinfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.UserService;

@Service
//就是获取springmvc.xml那个bean里面了
public class UserServiceImpl implements UserService {
    //为什么?spring-mybatis已经扫描了,mapper,所以可以注入
@Autowired
    UserinfoMapper uim;

    @Override
    public Userinfo selectByName(String username) {
        return uim.selectByName(username);
    }

    @Override
    public int deleteByPrimaryKey(Integer uId) {
        return uim.deleteByPrimaryKey(uId);
    }

    @Override
    public int insert(Userinfo record) {
        return uim.insert(record);
    }

    @Override
    public int insertSelective(Userinfo record) {
        return uim.insertSelective(record);
    }

    @Override
    public Userinfo selectByPrimaryKey(Integer uId) {
        return uim.selectByPrimaryKey(uId);
    }

    @Override
    public int updateByPrimaryKeySelective(Userinfo record) {
        return uim.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Userinfo record) {
        return uim.updateByPrimaryKey(record);
    }
}
