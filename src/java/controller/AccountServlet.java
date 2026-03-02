package controller;

import dao.AccountDAO;
import dto.Account;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * AccountServlet
 *  GET  /private/accounts                          → list all accounts
 *  GET  /private/accounts/delete?id=xx            → delete account, redirect back
 *  GET  /private/accounts/toggleStatus?id=xx&status=true|false → activate/deactivate
 */
@WebServlet({"/private/accounts", "/private/accounts/delete", "/private/accounts/toggleStatus"})
public class AccountServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("Workshop1.1PU");
    }

    @Override
    public void destroy() {
        if (emf != null) emf.close();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        EntityManager em = emf.createEntityManager();
        try {
            AccountDAO dao = new AccountDAO(em);

            if (path.endsWith("/delete")) {
                String id = request.getParameter("id");
                Account a = dao.getObjectById(id);
                if (a != null) dao.deleteRec(a);
                response.sendRedirect(request.getContextPath() + "/private/accounts");
                return;
            }

            if (path.endsWith("/toggleStatus")) {
                String id     = request.getParameter("id");
                boolean isUse = Boolean.parseBoolean(request.getParameter("status"));
                dao.updateIsUsed(id, isUse);
                response.sendRedirect(request.getContextPath() + "/private/accounts");
                return;
            }

            // Default: list
            request.setAttribute("accounts", dao.listAll());
            request.getRequestDispatcher("/WEB-INF/views/private/accounts.jsp")
                   .forward(request, response);

        } finally {
            em.close();
        }
    }
}
