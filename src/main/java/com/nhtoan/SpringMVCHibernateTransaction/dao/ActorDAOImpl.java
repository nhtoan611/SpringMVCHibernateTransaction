package com.nhtoan.SpringMVCHibernateTransaction.dao;

import java.util.List;

import javax.transaction.Transactional;

import com.nhtoan.SpringMVCHibernateTransaction.entity.Actor;

import org.hibernate.SessionFactory;

import org.hibernate.Session;

@Transactional
public class ActorDAOImpl implements ActorDAO {

	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public void addActor(Actor actor) {
		// TODO Auto-generated method stub
		try {
			Session session = this.sessionFactory.getCurrentSession();
			session.saveOrUpdate(actor);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@Override
	public void updateActor(Actor actor) {
		// TODO Auto-generated method stub
		try {
			Session session = this.sessionFactory.getCurrentSession();
			session.update(actor);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@Override
	public List<Actor> listActors() {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<Actor> actorList = session.createQuery("from Actor").list();
		return actorList;
	}

	@Override
	public Actor getActorById(short id) {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		Actor actor = (Actor) session.load(Actor.class, new Short(id));
		return actor;
	}

	@Override
	public void removeActor(short id) {
		// TODO Auto-generated method stub
		Session session = this.sessionFactory.getCurrentSession();
		Actor actor = (Actor) session.load(Actor.class, new Short(id));
		if(null != actor) {
			session.delete(actor);
		}
	}

}
