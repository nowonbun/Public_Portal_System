package dao;

import java.util.List;
import java.util.NoSuchElementException;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import common.MasterDao;
import model.State;

public class StateDao extends MasterDao<State> {

	protected StateDao() {
		super(State.class);
	}

	@SuppressWarnings("unchecked")
	@Override
	protected List<State> getDataList() {
		return transaction((em) -> {
			try {
				Query query = em.createNamedQuery("State.findAll", State.class);
				return (List<State>) query.getResultList();
			} catch (NoResultException e) {
				return null;
			}
		});
	}

	public State getState(int state) {
		try {
			return getData().stream().filter(x -> x.getState() == state).findFirst().get();
		} catch (NoSuchElementException e) {
			return null;
		}
	}
}