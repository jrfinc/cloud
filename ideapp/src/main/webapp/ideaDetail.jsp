<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="com.br.ideapp.Idea" %>
<%@ page import="com.br.ideapp.Comment" %>
<%@ page import="com.br.ideapp.Vote" %>
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
    <title>Idea</title>
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
                            if (user != null) {
                                pageContext.setAttribute("user", user);
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
                            %>
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>Hello, Guest!<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">
                                <i class="fa fa-fw fa-user"></i>
                                Sign In
                            </a>
                        </li>
                    </ul>
                </li>
                            <%
                               }
                            %>
            </ul>
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li>
                        <a href="/ideaLibrary.jsp"><i class="fa fa-fw fa-dashboard"></i> Listado de Ideas</a>
                    </li>
                </ul>
            </div>

        </nav>


        <div id="page-wrapper">
            <div class="container-fluid">

                    <%

                        if (request.getParameter("ideaId") != null) {
                            Long ideaId = new Long(request.getParameter("ideaId"));
                            Idea idea = ObjectifyService.ofy().load().type(Idea.class).id(ideaId).now();
                            String ideaContent = idea.getContent();
                            String ideaAuthor = idea.getAuthor_id();
                            int score = idea.getScore();

                    %>
                <p>
                    <h1><%= ideaContent%></h1><br>
                    <b>Autor:</b> <%= ideaAuthor%><br>
                    <b>Puntaje:</b> <%= score%>
                </p>
                    <%
                        List<Comment> comments = ObjectifyService.ofy().load().type(Comment.class).ancestor(idea).list();
                        if (comments.size() > 0) {
                            %>
                            <h3>Comentarios:</h3><br>
                            <%
                        }
                        for (Comment c : comments) {
                            String commentContent = c.getContent();
                            String commentAuthor = c.getAuthor_id();
                    %>
                 <p><%= commentContent%> <i><%= commentAuthor%></i></p>
                            <%
                                }
                                if (user != null) {
                                    String voteId = ideaId + "-" + user.getNickname();
                                    boolean existsVote = ObjectifyService.ofy().load().type(Vote.class).filter("id", voteId).count() != 0;
                                    if (!existsVote) {
                            %>

                <table>
                    <form action="/submitVote" method="post">
                        <div><input type="submit"  class = "btn btn-success" value="+1" /></div>
                        <input type="hidden" name="ideaId" value='<%= ideaId%>'/>
                        <input type="hidden" name="vote" value='1'/>
                    </form>
                    <form action="/submitVote" method="post">
                        <div><input type="submit"  class = "btn btn-danger" value="-1" /></div>
                        <input type="hidden" name="ideaId" value='<%= ideaId%>'/>
                        <input type="hidden" name="vote" value='-1'/>
                    </form>
                </table>

                                <%
                                        }
                                    }

                                %>

                 <script>
                    function checkform(evt)    {
                        var myForm = document.frmhot;
                        var condition = true;
                        if(myForm.content.value==""){
                            alert("Un comentario no puede ser vacío");
                            myForm.status.focus();
                            condition = false;
                        }
                        return condition;
                    }
                </script>
                <form action="/submitComment" name="frmhot" method="post">
                    <div><textarea name="content" rows="3" cols="60"></textarea></div>
                    <div><input type="button"  class = "btn btn-primary" value="Subir Comentario" onclick="return checkform(event);" /></div>
                    <input type="hidden" name="ideaId" value='<%= ideaId%>'/>
                </form>
                <%
                    }
                    else {
                %>
                        <jsp:forward page = "ideaLibrary.jsp" />
                <%
                    }
                %>

            </div>
        </div>

    </div>

    <script src="stylesheets/js/jquery.js"></script>
    <script src="stylesheets/js/bootstrap.min.js"></script>
</body>

</html>