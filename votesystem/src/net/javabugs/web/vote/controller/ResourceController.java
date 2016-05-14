package net.javabugs.web.example.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Locale;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
@RequestMapping("/rsc")
public class ResourceController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@RequestMapping(value = "/i18n" , method = {RequestMethod.GET})
	public @ResponseBody JSONObject i18n(Locale locale){
		
		JSONObject messageObj = new JSONObject();
		//우리는 프로퍼티에 주석라인은 없애고 없는라인은없애고 =은 :으로 바꾸고 해야한다?
	
		BufferedReader br = null;
		try{
			br = new BufferedReader(new InputStreamReader(
//					this.getClass().getResourceAsStream("/messages_ko.properties")));
					(this.getClass().getResourceAsStream(String.format("/messages_%s.properties",locale.getLanguage())))));
			String line = null;
			while((line = br.readLine()) != null ){ //라인이 비어잇는라인과 주석라인이 있었죠
				//그걸 처리할꺼에요
				line = line.trim();
				//공백이거나 주석문자 #으로 시작하는것 제외시킨다.
				if(line.length()>0 && line.indexOf("#") != 0){//첫번째는 #이 아니여야한다! 그럼 정상적인 대상이다
					String[] keyVal = line.split("=");
					if(keyVal.length ==2){//그럼 제이슨에 집어넣으면 되는거죠
						messageObj.accumulate(keyVal[0].replace(".","_"), StringEscapeUtils.unescapeJava(keyVal[1]));
					}
				}
			}
		}catch(Exception e){
			
		}finally{
			if(br != null)try{ br.close(); }catch(Exception e){}
		}
		
		return messageObj;
	}
}
