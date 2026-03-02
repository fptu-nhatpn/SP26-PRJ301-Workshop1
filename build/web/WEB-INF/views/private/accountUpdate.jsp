<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Account Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>body { background: #f0f2f5; }</style>
</head>
<body>

<%@ include file="/WEB-INF/views/private/header.jsp" %>

<div class="container mt-4" style="max-width: 700px;">

    <h4 class="mb-4">
        <c:choose>
            <c:when test="${not empty account}">Update account</c:when>
            <c:otherwise>Add new account</c:otherwise>
        </c:choose>
    </h4>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger py-2">${errorMessage}</div>
    </c:if>

    <div class="card shadow-sm">
        <div class="card-body p-4">
            <form method="post"
                  action="${pageContext.request.contextPath}/private/accounts/update">

                <c:if test="${not empty account}">
                    <input type="hidden" name="originalAccount" value="${account.account}">
                </c:if>

                <!-- Account -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Account</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="account"
                               placeholder="Enter email"
                               value="${account.account}"
                               ${not empty account ? 'readonly' : ''}
                               required>
                    </div>
                </div>

                <!-- Password -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Password</label>
                    <div class="col-sm-8">
                        <input type="password" class="form-control" name="pass"
                               placeholder="${not empty account ? 'Leave blank to keep current' : 'Enter password'}"
                               ${empty account ? 'required' : ''}>
                    </div>
                </div>

                <!-- Last name -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Last name</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="lastName"
                               placeholder="Last name"
                               value="${account.lastName}" required>
                    </div>
                </div>

                <!-- First name -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">First name</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="firstName"
                               placeholder="First name"
                               value="${account.firstName}" required>
                    </div>
                </div>

                <!-- Phone -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Phone number</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="phone"
                               placeholder="Phone number"
                               pattern="(03|05|07|08|09)[0-9]{8}"
                               title="Must start with 03/05/07/08/09 and be 10 digits"
                               value="${account.phone}" required>
                    </div>
                </div>

                <!-- Birthday -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Birth day</label>
                    <div class="col-sm-8">
                        <input type="date" class="form-control" name="birthday"
                               value="${account.birthday}" required>
                    </div>
                </div>

                <!-- Gender -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Gender</label>
                    <div class="col-sm-8">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender"
                                   id="genderMale" value="true"
                                   ${account.gender or empty account ? 'checked' : ''}>
                            <label class="form-check-label" for="genderMale">Male</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender"
                                   id="genderFemale" value="false"
                                   ${not account.gender and not empty account ? 'checked' : ''}>
                            <label class="form-check-label" for="genderFemale">Female</label>
                        </div>
                    </div>
                </div>

                <!-- Role in system -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Role in system</label>
                    <div class="col-sm-8">
                        <select class="form-select" name="roleInSystem">
                            <option value="1" ${account.roleInSystem == 1 ? 'selected' : ''}>Administrator</option>
                            <option value="0" ${account.roleInSystem == 0 ? 'selected' : ''}>Staff</option>
                        </select>
                    </div>
                </div>

                <!-- Is active -->
                <div class="row mb-4 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold"></label>
                    <div class="col-sm-8">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="isUse"
                                   id="isUse" value="true"
                                   ${account.isUse ? 'checked' : ''}>
                            <label class="form-check-label" for="isUse">Is active</label>
                        </div>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-dark">Submit</button>
                    <a href="${pageContext.request.contextPath}/private/accounts"
                       class="btn btn-outline-secondary">Cancel</a>
                </div>

            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
