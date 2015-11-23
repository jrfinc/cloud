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
</head>

<body>
    <div id="wrapper">
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="navbar-header">
                  <a class="navbar-brand" href="" >Ideapp</a>
                        <%
                            UserService userService = UserServiceFactory.getUserService();
                            User user = userService.getCurrentUser();
                            if (user != null) {
                                pageContext.setAttribute("user", user);
                        %>
            </div>
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">

                    <a><span class="label label-default">Hello, ${fn:escapeXml(user.nickname)}!
                        <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>
                    </span></a>
                            <%
                                } else {
                            %>
                    <a><span class="label label-default">Hello!
                        <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
                        to submit ideas.
                    </span></a>
                            <%
                               }
                            %>
                </li>
            </ul>
        </nav>

        <div id="page-wrapper">
            <div class="container-fluid">

                    <%

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

                <form action="/submitVote" method="post">
                    <div><input type="submit" value="+1" /></div>
                    <input type="hidden" name="ideaId" value='<%= ideaId%>'/>
                    <input type="hidden" name="vote" value='1'/>
                </form>
                <form action="/submitVote" method="post">
                    <div><input type="submit" value="-1" /></div>
                    <input type="hidden" name="ideaId" value='<%= ideaId%>'/>
                    <input type="hidden" name="vote" value='-1'/>
                </form>

                                <%
                                        }
                                    }
                                %>

                <form action="/submitComment" method="post">
                    <div><textarea name="content" rows="3" cols="60"></textarea></div>
                    <div><input type="submit" value="Subir Comentario" /></div>
                    <input type="hidden" name="ideaId" value='<%= ideaId%>'/>
                </form>


                <a href="/ideaLibrary.jsp">Listado de ideas</a></p>

            </div>
        </div>

    </div>

    <script src="stylesheets/js/jquery.js"></script>
    <script src="stylesheets/js/bootstrap.min.js"></script>
</body>

</html>