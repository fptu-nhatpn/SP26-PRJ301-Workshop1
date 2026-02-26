/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author nhatp
 */

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
            return 0;
        }
    }

    @Override
    public int deleteRec(Account obj) {
        try {
            em.getTransaction().begin();
            Account acc = em.find(Account.class, obj.getAccount());
            if (acc != null) {
                em.remove(acc);
            }
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            em.getTransaction().rollback();
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
}
