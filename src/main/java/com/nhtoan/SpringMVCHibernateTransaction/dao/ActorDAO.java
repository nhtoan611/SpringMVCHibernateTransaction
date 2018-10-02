package com.nhtoan.SpringMVCHibernateTransaction.dao;

import java.util.List;

import com.nhtoan.SpringMVCHibernateTransaction.entity.Actor;

public interface ActorDAO {

	public void addActor(Actor actor);
	public void updateActor(Actor actor);
	public List<Actor> listActors();
	public Actor getActorById(short id);
	public void removeActor(short id);
	
}
