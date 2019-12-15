package controller;

import entity.Productinfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import serviceImpl.ProductInfoServiceImpl;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

/*增加商品*/
/*上传照片的controller*/
@RestController
public class UpLoadImgController {
    @Autowired
    ProductInfoServiceImpl pisi;

    @RequestMapping("/addProducts")
//                                                                                                                                                                                                                                  MultipartFile multipartFile图片
    public @ResponseBody
    String addProducts(@RequestParam String p_code, @RequestParam String p_name, @RequestParam String p_type, @RequestParam String brand, @RequestParam String p_num, @RequestParam String price, @RequestParam String intro, @RequestParam(value = "pic") MultipartFile multipartFile, HttpServletRequest request) throws IOException, IOException {
        System.out.println("++++++++++++++"+p_code);
        //获取文件名字，getOriginalFilename获取图片原始的名字
        String originalFilename = multipartFile.getOriginalFilename();
        System.out.println("上传的文件名:"+originalFilename);

        //获取不会重复的毫秒数(获取当前的毫秒数)
        long l = System.currentTimeMillis();
        //拼接成新名字，原始名字+毫秒数=存储在数据库中的名字
        String newName = l + originalFilename;
        System.out.println("毫秒数+原文件名:"+newName);

        //获取图片的输入流名字
        InputStream inputStream = multipartFile.getInputStream();


        //存到数据库中的路径
        String ljPath = "/image/" + newName;
        System.out.println("我是存在数据库的图片路径"+ljPath);

        /*获取父级根目录，判断是否有此文件夹，再创建文件夹，再把图片存储在此文件夹中*/

        //项目根目录
        String realPath = request.getSession().getServletContext().getRealPath("/");
        System.out.println("我是项目根目录realPath  "+realPath);

        String lsPath = realPath + ljPath;//根目录+存储路径
        System.out.println("图片在项目中的完整路径:"+lsPath);


        /*判断创建文件夹*/
        File isFile = new File(realPath + "\\image\\");
        if (!isFile.exists()) {
            /*mkdir创建文件夹*/
            isFile.mkdir();
        }

        //不为空时
        if (!multipartFile.isEmpty()) {
            /*获取输出流：给路径就能写进去，输入流不能new*/
            FileOutputStream lsStream = new FileOutputStream(lsPath);
            int len = 0;
            while ((len = inputStream.read()) != -1) {
                lsStream.write(len);

            }
            lsStream.flush();

            lsStream.close();

            inputStream.close();

        }


        Productinfo pi=new Productinfo();
        pi.setpCode(Integer.parseInt(p_code));
        pi.setpName(p_name);
        pi.setpType(p_type);
        pi.setBrand(brand);
        pi.setpNum(Integer.parseInt(p_num));
        pi.setPrice(Double.parseDouble(price));
        pi.setIntro(intro);
        pi.setPic(ljPath);
        pi.setStatus(0);//商品状态默认为0(0:上架,1:下架,2:打折)
        /*判断图片是否上传成功*/
        int index=pisi.insertSelective(pi);
        if(index>0){
            return "ok";
        }

        return  "no";

    }


}
