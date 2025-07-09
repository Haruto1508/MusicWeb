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
        <!-- about -->
        <div class="about">
            <a class="bg_links social portfolio" href="https://www.rafaelalucas.com" target="_blank">
                <span class="icon"></span>
            </a>
            <a class="bg_links social dribbble" href="https://dribbble.com/rafaelalucas" target="_blank">
                <span class="icon"></span>
            </a>
            <a class="bg_links social linkedin" href="https://www.linkedin.com/in/rafaelalucas/" target="_blank">
                <span class="icon"></span>
            </a>
            <a class="bg_links logo"></a>
        </div>
        <!-- end about -->

        <nav>
            <div class="menu">
                <p class="website_name">LOGO</p>
                <div class="menu_links">
                    <a href="" class="link">about</a>
                    <a href="" class="link">projects</a>
                    <a href="" class="link">contacts</a>
                </div>
                <div class="menu_icon">
                    <span class="icon"></span>
                </div>
            </div>
        </nav>

        <section class="wrapper">

            <div class="container">

                <div id="scene" class="scene" data-hover-only="false">


                    <div class="circle" data-depth="1.2"></div>

                    <div class="one" data-depth="0.9">
                        <div class="content">
                            <span class="piece"></span>
                            <span class="piece"></span>
                            <span class="piece"></span>
                        </div>
                    </div>

                    <div class="two" data-depth="0.60">
                        <div class="content">
                            <span class="piece"></span>
                            <span class="piece"></span>
                            <span class="piece"></span>
                        </div>
                    </div>

                    <div class="three" data-depth="0.40">
                        <div class="content">
                            <span class="piece"></span>
                            <span class="piece"></span>
                            <span class="piece"></span>
                        </div>
                    </div>

                    <p class="p404" data-depth="0.50">404</p>
                    <p class="p404" data-depth="0.10">404</p>

                </div>

                <div class="text">
                    <article>
                        <p>Uh oh! Looks like you got lost. <br>Go back to the homepage if you dare!</p>
                        <button>i dare!</button>
                    </article>
                </div>

            </div>
        </section>
    </body>
</html>
