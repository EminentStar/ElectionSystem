package net.javabugs.web.common.extend.advisors;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;

import net.javabugs.web.common.constant.VSConstants;
import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.common.mvc.model.vo.ResultVO;

@Aspect
public class ControllerAdvisor {
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Around("execution(net.javabugs.web.common.mvc.model.vo.ResultVO+ net.javabugs.web..controller.*Controller.*(*,org.springframework.validation.BindingResult,..)) && args(*,bindingResult,..)")
	public ResultVO aroundAdviceForResultVO(ProceedingJoinPoint joinPoint, BindingResult bindingResult) throws Throwable {
		if(bindingResult.hasErrors()) {
			ResultVO rvo = new ResultVO();//수정된부분
			rvo.put("error",bindingResult.getFieldErrors()); //수정된 부분
			
			if (logger.isDebugEnabled()) {
				logger.debug("ResultVO Validation Error");
				logger.debug(bindingResult.getFieldErrors());
			}
			
			return rvo;
		}
		return (ResultVO)joinPoint.proceed();
	}
}
