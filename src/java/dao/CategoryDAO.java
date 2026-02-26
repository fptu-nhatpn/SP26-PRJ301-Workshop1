/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author nhatp
 */

import dto.Category;
import javax.persistence.EntityManager;
import java.util.List;

public class CategoryDAO implements Accessible<Category> {

    private EntityManager em;

    public CategoryDAO(EntityManager em) {
        this.em = em;
    }

    @Override
    public int insertRec(Category obj) {
        try {
            em.getTransaction().begin();
            em.persist(obj);
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return 0;
        }
    }

    @Override
    public int updateRec(Category obj) {
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
    public int deleteRec(Category obj) {
        try {
            em.getTransaction().begin();
            Category c = em.find(Category.class, obj.getTypeId());
            if (c != null) {
                em.remove(c);
            }
            em.getTransaction().commit();
            return 1;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return 0;
        }
    }

    @Override
    public Category getObjectById(String id) {
        return em.find(Category.class, Integer.parseInt(id));
    }

    @Override
    public List<Category> listAll() {
        return em.createQuery("SELECT c FROM Category c", Category.class)
                 .getResultList();
    }
}