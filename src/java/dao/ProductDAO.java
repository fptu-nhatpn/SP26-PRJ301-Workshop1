package dao;

import dto.Product;
import javax.persistence.*;
import java.util.List;

public class ProductDAO implements Accessible<Product> {

    private EntityManager em;

    public ProductDAO(EntityManager em) {
        this.em = em;
    }

    @Override
    public int insertRec(Product obj) {
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
    public int updateRec(Product obj) {
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
    public int deleteRec(Product obj) {
        try {
            em.getTransaction().begin();
            Product managed = em.contains(obj) ? obj : em.find(Product.class, obj.getProductId());
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
    public Product getObjectById(String id) {
        return em.find(Product.class, id);
    }

    @Override
    public List<Product> listAll() {
        return em.createQuery("SELECT p FROM Product p", Product.class)
                 .getResultList();
    }

    public List<Product> listByCategory(int categoryId) {
        return em.createQuery(
                "SELECT p FROM Product p WHERE p.type.typeId = :cid", Product.class)
                .setParameter("cid", categoryId)
                .getResultList();
    }
}
