package com.project.shuttle;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.project.shuttle.intercepter.LoginSessionIntercepter;

@SpringBootApplication
public class FinalProject02Application implements WebMvcConfigurer {

	public static void main(String[] args) {
		SpringApplication.run(FinalProject02Application.class, args);
	}
	
	@Autowired
    LoginSessionIntercepter loginSessionIntercepter;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginSessionIntercepter)
                .addPathPatterns("/mypage_main.do")
                .addPathPatterns("/mypage_update.do")
                .addPathPatterns("/signUp.do")
                ;
    }
	
	/*
	 * registry.addInterceptor(new MyInterceptor())  //만들어준 인터셉터
			.addPathPatterns(URL_PATTERNS)   //이런식으로 배열로도 가능하고,
			.excludePathPatterns("/원하는패턴1")   //1개1개씩 추가도 가능하다.
			.excludePathPatterns("/원하는패턴2");
	 * 
	 * 
	 */
	
	

}
