package com.project.shuttle.model.biz;

import java.net.URI;
import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.project.shuttle.model.dao.TBUserDao;
import com.project.shuttle.model.dto.KakaoPayDto;
import com.project.shuttle.model.dto.KakaoResponseDto;
import com.project.shuttle.model.dto.TBUserDto;

@Service
public class KakaoPayBiz {
	private static final String HOST = "https://kapi.kakao.com";

	private KakaoPayDto kakaoPayDto;
	private KakaoResponseDto kakaoRes;
	
	@Autowired
	private TBUserDao userDao;
	
	@Autowired
	private TBUserBiz userBiz;
	
	private String title = "Shuttle";	// 프로젝트 제목, 카카오로 보낼 partner_id
	private String adminKey = "61535a445b0b977d7b87e197ada1ebb5";	// 카카오 어드민키
	private int quantity;
	private int totalAmount;
	
	public String kakaoPayReady(String userId, int paramQuantity) {
		RestTemplate restTemplate = new RestTemplate();

		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + adminKey);
		headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
		// APPLICATION_JSON_UTF8_VALUE => deprecated
		// 크롬같은 주 브라우저들이 UTF-8을 잘 받아들이므로 매개변수로 UTF-8을 보낼 필요가 없어짐
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		
		quantity = paramQuantity;
		
		String itemName = "bread";
		int taxFree = (int) ((quantity * 100) * 0.1);
		totalAmount = (quantity * 110)-taxFree;
		
		String successURL = "http://localhost:2222/main_pay_success.do";
		String cancelURL = "http://localhost:2222/main.do";
		String failURL = "http://localhost:2222/main.do";

		// 서버로 요청할 Body
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
		params.add("partner_order_id", title);
		params.add("partner_user_id", userId);
		params.add("item_name", itemName);
		params.add("quantity", quantity+"");
		params.add("total_amount", totalAmount+"");
		params.add("tax_free_amount", taxFree+"");
		params.add("approval_url", successURL);
		params.add("cancel_url", cancelURL);
		params.add("fail_url", failURL);

		HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);

		try {
			kakaoPayDto = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayDto.class);

			return kakaoPayDto.getNext_redirect_pc_url();

		} catch (RestClientException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		return "/pay";

	}
	
	
	

	public KakaoResponseDto kakaoPayInfo(String pg_token, TBUserDto loginInfo, HttpSession session) {
		
		String userId = loginInfo.getUserId();
		
//		TBUserDto dto = new TBUserDto();
//		dto.setUserId(userId);
//		dto.setUserCoin(quantity);
		loginInfo.setUserCoin(quantity);
		
		userDao.kakaoUpdateBread(loginInfo);
		
		TBUserDto updateLoginInfo = userBiz.login(loginInfo);
		session.setAttribute("loginInfo", updateLoginInfo);
			
		RestTemplate restTemplate = new RestTemplate();

		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + adminKey);
		headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
		// APPLICATION_JSON_UTF8_VALUE => deprecated
		// 크롬같은 주 브라우저들이 UTF-8을 잘 받아들이므로 매개변수로 UTF-8을 보낼 필요가 없어짐
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");

		// 서버로 요청할 Body
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
		params.add("tid", kakaoPayDto.getTid());
		params.add("partner_order_id", title);
		params.add("partner_user_id", userId);
		params.add("pg_token", pg_token);
		params.add("total_amount", totalAmount+"");

		HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);

		try {
			kakaoRes = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body,
					KakaoResponseDto.class);
			return kakaoRes;

		} catch (RestClientException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	
	
}
