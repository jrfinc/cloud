<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="com.br.ideapp.Idea" %>
<%@ page import="com.br.ideapp.Subscriber" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link href="stylesheets/css/bootstrap.min.css" rel="stylesheet">
        <link href="stylesheets/css/sb-admin.css" rel="stylesheet">
        <link href="stylesheets/css/plugins/morris.css" rel="stylesheet">
        <link href="stylesheets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <title>Subir idea</title>
    </head>

    <body>
        <div id="wrapper">
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <div class="navbar-header">
                  <a class="navbar-brand" href="" >Ideapp</a>
                </div>
                            <%
                                UserService userService = UserServiceFactory.getUserService();
                                User user = userService.getCurrentUser();
                                boolean existsSubscription = true;
                                if (user != null) {
                                    pageContext.setAttribute("user", user);
                                    String email = user.getEmail();
                                    existsSubscription = ObjectifyService.ofy().load().type(Subscriber.class).id(email).now() != null;

                            %>
                <ul class="nav navbar-right top-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> Hello,${fn:escapeXml(user.nickname)}!<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">
                                    <i class="fa fa-fw fa-user"></i>
                                    Sign Out
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
                                <%
                                    } else {
                                        String redirectURL = userService.createLoginURL(request.getRequestURI());
                                        response.sendRedirect(redirectURL);
                                    }
                                %>
                </ul>
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav side-nav">
                        <li>
                            <a href="/ideaLibrary.jsp"><i class="fa fa-fw fa-dashboard"></i> Listado de Ideas</a>
                        </li>
                        <li>
                            <a href="/bestIdeasLibrary.jsp"><i class="fa fa-fw fa-dashboard"></i> Ideas más exitosas</a>
                        </li>
                        <li>
                            <a href="/myIdeasLibrary.jsp"><i class="fa fa-fw fa-dashboard"></i> Mis ideas</a>
                        </li>
                        <li>
                            <a href="/uploadIdea.jsp"><i class="fa fa-fw fa-dashboard"></i> Subir idea</a>
                        </li>
                            <%
                                if (!existsSubscription) {
                            %>
                        <li>
                            <form action="/subscribe" method="post" class="fa fa-fw fa-dashboard">
                                <div><input type="submit" value="Suscribirse al newsletter semanal!" /></div>
                            </form>
                        </li>
                            <%
                                }
                            %>
                    </ul>
                </div>
            </nav>

            <div id="page-wrapper">
                <div class="container-fluid">
                    <h1>Nueva Idea: </h1>

                    <script>
                        function checkform(evt)    {
                            var myForm = document.frmhot;
                            var condition = true;
                            if(myForm.content.value==""){
                                alert("Una idea no puede ser vacía");
                                myForm.status.focus();
                                condition = false;
                            }
                            return condition;
                        }
                    </script>
                    <form action="/submitIdea" name="frmhot" method="post" >
                        <div><textarea name="content" rows="3" cols="60"></textarea></div>
                        <div><input type="button" class = "btn btn-primary" value="Subir Idea" onclick="return checkform(event);"/></div>
                    </form>
                </div>
            </div>
        </div>
            <script src="stylesheets/js/jquery.js"></script>
            <script src="stylesheets/js/bootstrap.min.js"></script>
    </body>
</html>

