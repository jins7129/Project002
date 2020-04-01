package com.project.shuttle.model.biz;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.project.shuttle.model.dto.KakaoPayDto;
import com.project.shuttle.model.dto.KakaoResponseDto;

@Service
public class KakaoPayBiz {
	private static final String HOST = "https://kapi.kakao.com";

	private KakaoPayDto kakaoPayDto;
	private KakaoResponseDto kakaoRes;

	public String kakaoPayReady(String userId, int paramQuantity) {

		RestTemplate restTemplate = new RestTemplate();

		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + "61535a445b0b977d7b87e197ada1ebb5");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");

		// userId  유저아이디
		String itemName = "bread";
		int quantity = paramQuantity;
		int totalAmount = quantity * 110;
		int taxFree = (int) ((totalAmount * 100) * 0.1);

		String successURL = "http://localhost:2222/main_pay_success.do";
		String cancelURL = "http://localhost:2222/main.do";
		String failURL = "http://localhost:2222/main.do";

		// 서버로 요청할 Body
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
		params.add("partner_order_id", "Shuttle");
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

	public KakaoResponseDto kakaoPayInfo(String pg_token) {

		RestTemplate restTemplate = new RestTemplate();

		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + "61535a445b0b977d7b87e197ada1ebb5");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");

		// 서버로 요청할 Body
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
		params.add("tid", kakaoPayDto.getTid());
		params.add("partner_order_id", "Shuttle");
		params.add("partner_user_id", "test");
		params.add("pg_token", pg_token);
		params.add("total_amount", "110");

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
