package com.nhtoan.SpringMVCHibernateTransaction.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.MediaType;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nhtoan.SpringMVCHibernateTransaction.dao.ActorDAO;
import com.nhtoan.SpringMVCHibernateTransaction.entity.Actor;

@Controller
public class MainController {

	@Autowired
	private ActorDAO actorDAO;
	
	@RequestMapping("/")
	public String home() {
		return "index";
	}
	
	@RequestMapping(value = "/actor", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<Actor> listActor(){	
		return actorDAO.listActors();
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public boolean deleteActor(@RequestBody String userId) throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		String id = null;
		@SuppressWarnings("unchecked")
		Map<String,Object> map = mapper.readValue(userId, Map.class);
		for(@SuppressWarnings("rawtypes") Map.Entry m:map.entrySet()) {
			id = m.getValue().toString();
		}	
		actorDAO.removeActor(Short.parseShort(id));
		return true;
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public boolean addActor(@RequestBody String actorData) throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		Actor actor = mapper.readValue(actorData, Actor.class);
		actorDAO.addActor(actor);	
		return true;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public boolean updateActor(@RequestBody String actorData) throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		Actor actor = mapper.readValue(actorData, Actor.class);
		actorDAO.updateActor(actor);
		return true;
	}
}
