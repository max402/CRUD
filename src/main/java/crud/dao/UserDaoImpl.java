package crud.dao;

import crud.model.User;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDaoImpl implements UserDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addUser(User user) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(user);
    }

    @Override
    public void updateUser(User user) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(user);
    }

    @Override
    public void removeUser(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        User user = (User) session.load(User.class, new Integer(id));

        if(user!=null){
            session.delete(user);
        }
    }
    @Override
    public User getUserById(int id) {
        Session session =this.sessionFactory.getCurrentSession();
        return (User) session.load(User.class, new Integer(id));
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> listUsers() {
        Session session = this.sessionFactory.getCurrentSession();
        return session.createQuery("from User").list();
    }

    @Override
    public List<User> searchUsers(String s){
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from User as u where u.userName like ?");
        query.setString(0, s);
        return query.list();
    }
}
