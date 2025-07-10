<%-- 
    Document   : 404page
    Created on : Jul 8, 2025, 10:56:43 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/404page.css">
    </head>
    <body>
        <div class="center">
            <div class="error">
                <div class="number">4</div>
                <div class="illustration">
                    <div class="circle"></div>
                    <div class="clip">
                        <div class="paper">
                            <div class="face">
                                <div class="eyes">
                                    <div class="eye eye-left"></div>
                                    <div class="eye eye-right"></div>
                                </div>
                                <div class="rosyCheeks rosyCheeks-left"></div>
                                <div class="rosyCheeks rosyCheeks-right"></div>
                                <div class="mouth"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="number">4</div>
            </div>

            <div class="text">Oops. The page you're looking for doesn't exist.</div>
            <a class="button" href="${pageContext.request.contextPath}/home">Back Home</a>
        </div>
    </body>
</html>
