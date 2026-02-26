/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.Product;
import javax.persistence.*;
import java.util.List;
/**
 *
 * @author nhatp
 */
public class ProductDAO implements Accessible<Product> {

    private EntityManager em;

    public ProductDAO(EntityManager em) {
        this.em = em;
    }

    @Override
    public int insertRec(Product obj) {
        em.getTransaction().begin();
        em.persist(obj);
        em.getTransaction().commit();
        return 1;
    }

    @Override
    public int updateRec(Product obj) {
        em.getTransaction().begin();
        em.merge(obj);
        em.getTransaction().commit();
        return 1;
    }

    @Override
    public int deleteRec(Product obj) {
        em.getTransaction().begin();
        em.remove(em.contains(obj) ? obj : em.merge(obj));
        em.getTransaction().commit();
        return 1;
    }

    @Override
    public Product getObjectById(String id) {
        return em.find(Product.class, id);
    }

    @Override
    public List<Product> listAll() {
        return em.createQuery("SELECT p FROM Product p", Product.class)
                 .getResultList();
    }
}
