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
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * AccountUpdateServlet
 *  GET  /private/accounts/update          → show empty add form
 *  GET  /private/accounts/update?id=xx   → show pre-filled edit form
 *  POST /private/accounts/update          → save (insert or update)
 */
@WebServlet("/private/accounts/update")
public class AccountUpdateServlet extends HttpServlet {

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

    // ── GET ──────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        if (id != null) {
            EntityManager em = emf.createEntityManager();
            try {
                Account a = new AccountDAO(em).getObjectById(id);
                request.setAttribute("account", a);
            } finally {
                em.close();
            }
        }
        // no id → add mode, account attribute stays null → JSP shows empty form
        request.getRequestDispatcher("/WEB-INF/views/private/accountUpdate.jsp")
               .forward(request, response);
    }

    // ── POST ─────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String originalAccount = request.getParameter("originalAccount"); // null on add
        String accountId       = request.getParameter("account");
        String pass            = request.getParameter("pass");
        String lastName        = request.getParameter("lastName");
        String firstName       = request.getParameter("firstName");
        String phone           = request.getParameter("phone");
        String birthdayStr     = request.getParameter("birthday");
        boolean gender         = Boolean.parseBoolean(request.getParameter("gender"));
        int     roleInSystem   = Integer.parseInt(request.getParameter("roleInSystem"));
        boolean isUse          = "true".equals(request.getParameter("isUse"));

        Date birthday = null;
        try {
            birthday = new SimpleDateFormat("yyyy-MM-dd").parse(birthdayStr);
        } catch (Exception e) {
            // leave null if parse fails
        }

        EntityManager em = emf.createEntityManager();
        try {
            AccountDAO dao = new AccountDAO(em);

            if (originalAccount == null) {
                // ── INSERT ──────────────────────────────────────────────
                Account a = new Account(accountId, pass, lastName, firstName,
                                        birthday, gender, phone, isUse, roleInSystem);
                int result = dao.insertRec(a);
                if (result == 0) {
                    request.setAttribute("errorMessage", "Failed to add account. ID may already exist.");
                    request.getRequestDispatcher("/WEB-INF/views/private/accountUpdate.jsp")
                           .forward(request, response);
                    return;
                }
            } else {
                // ── UPDATE ──────────────────────────────────────────────
                Account a = dao.getObjectById(originalAccount);
                if (a == null) {
                    response.sendRedirect(request.getContextPath() + "/private/accounts");
                    return;
                }
                a.setLastName(lastName);
                a.setFirstName(firstName);
                a.setPhone(phone);
                a.setBirthday(birthday);
                a.setGender(gender);
                a.setRoleInSystem(roleInSystem);
                a.setIsUse(isUse);
                if (pass != null && !pass.trim().isEmpty()) {
                    a.setPass(pass);
                }
                dao.updateRec(a);
            }

            response.sendRedirect(request.getContextPath() + "/private/accounts");

        } finally {
            em.close();
        }
    }
}
