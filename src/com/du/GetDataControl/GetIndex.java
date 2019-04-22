package com.du.GetDataControl;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GetIndex {


    @RequestMapping("/getIndex/index1.do")
    public String getIndex1(){
        return "index1";
    }
}
