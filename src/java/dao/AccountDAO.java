package dao;

import dto.Account;
import javax.persistence.EntityManager;
import java.util.List;

public class AccountDAO implements Accessible<Account> {

    private EntityManager em;

    public AccountDAO(EntityManager em) {
        this.em = em;
    }

    @Override
    public int insertRec(Account obj) {
        try {
            em.getTransaction().begin();
            em.persist(obj);
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int updateRec(Account obj) {
        try {
            em.getTransaction().begin();
            em.merge(obj);
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int deleteRec(Account obj) {
        try {
            em.getTransaction().begin();
            Account managed = em.find(Account.class, obj.getAccount());
            if (managed != null) em.remove(managed);
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public Account getObjectById(String id) {
        return em.find(Account.class, id);
    }

    @Override
    public List<Account> listAll() {
        return em.createQuery("SELECT a FROM Account a", Account.class)
                 .getResultList();
    }

    /**
     * Returns the Account if credentials match and account is active, else null.
     */
    public Account loginSuccess(String account, String pass) {
        try {
            return em.createQuery(
                    "SELECT a FROM Account a WHERE a.account = :acc AND a.pass = :pass AND a.isUse = true",
                    Account.class)
                    .setParameter("acc", account)
                    .setParameter("pass", pass)
                    .getSingleResult();
        } catch (Exception e) {
            return null;  // no match or multiple results
        }
    }

    /**
     * Update only the isUse field without touching other fields.
     */
    public int updateIsUsed(String accountId, boolean isUse) {
        try {
            em.getTransaction().begin();
            Account a = em.find(Account.class, accountId);
            if (a != null) a.setIsUse(isUse);
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            return 0;
        }
    }
}
