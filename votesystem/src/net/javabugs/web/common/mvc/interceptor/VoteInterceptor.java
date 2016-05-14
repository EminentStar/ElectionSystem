package net.javabugs.web.common.mvc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.javabugs.web.example.model.dto.CheckParam;
import net.javabugs.web.example.service.VoteService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class VoteInterceptor implements HandlerInterceptor{
	
	@Autowired
	private VoteService voteService;	
	
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response,
			Object handler) throws Exception {
		
		//CheckParam checkPr = new CheckParam();
		
		int json = voteService.checkVoteTerm();
		
		boolean result = true;
		System.out.println(json);
		
		if(json !=1){
			request.getRequestDispatcher("/vote/votecheck").forward(request, response);
			result = false;
		}		

		return result;
		/*switch(status){
		case 1:
			//투표 기간 중이라면
			request.getRequestDispatcher("/vote/votelist").forward(request, response);
			result = false;
			break;
		case 2:
			//투표 결과 열람 기간 중이라면
			request.getRequestDispatcher("/vote/voteerror").forward(request, response);
			result = false;
			break;
		}*/
		//return result;
	}

	

}
