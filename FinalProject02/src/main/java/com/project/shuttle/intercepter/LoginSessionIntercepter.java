package com.project.shuttle.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.project.shuttle.model.dto.TBUserDto;

@Component
public class LoginSessionIntercepter implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		TBUserDto userInfo = (TBUserDto) session.getAttribute("loginInfo");
		if (userInfo != null) {
			// 로그인 정보가 있는 상태로 페이지 요청을 했을 경우
			if(request.getRequestURI().contains("/signUp.do")) {
				// 로그인 정보가 있는 상태로 회원가입폼을 들어갈 경우(불허)
				response.sendRedirect("/main.do");	// main으로 던짐
				return false;
			}
			
			return true;
		} else {
			// 로그인 정보가 없는 상태로 페이지 요청을 했을 경우
			if(request.getRequestURI().contains("/signUp.do")) {
				return true;	// 로그인 정보가 없는 상태로 회원가입폼을 들어갈 경우(허용)
			} 
			response.sendRedirect("/main.do");	// main으로 던짐
			return false;
		}
	}
}
