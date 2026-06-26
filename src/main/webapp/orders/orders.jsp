<%--
  Created by IntelliJ IDEA.
  User: cesar
  Date: 1/1/2026
  Time: 8:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="rich" uri="http://richfaces.org/rich" %>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j" %>

<f:view>
    <html>
    <head>
        <title>&Oacute;rdenes</title>
    </head>
    <body>
    <jsp:include page="../menu.jsp"/>
    <rich:panel>
        <h:form id="formOrders">

        </h:form>
    </rich:panel>
    </body>
    </html>
</f:view>
