<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="com.br.ideapp.Idea" %>
<%@ page import="com.br.ideapp.Comment" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
</head>

<body>

<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
        pageContext.setAttribute("user", user);
%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
    <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
    } else {
%>
<p>Hello!
    <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
    to submit ideas.</p>
<%
    }

    Long ideaId = new Long(request.getParameter("ideaId"));
    Idea idea = ObjectifyService.ofy().load().type(Idea.class).id(ideaId).now();
    String ideaContent = idea.getContent();

%>
    <p><b><%= ideaContent%></b></p>
<%
    //List<Comment> comments = ObjectifyService.ofy().load().type(Comment.class).ancestor(idea).list();
    List<Comment> comments = ObjectifyService.ofy().load().type(Comment.class).list();
    for (Comment c : comments) {
        String commentContent = c.getContent();
%>
     <p><%= commentContent%></p>
<%
    }
%>

<form action="/submitComment" method="post">
    <div><textarea name="content" rows="3" cols="60"></textarea></div>
    <div><input type="submit" value="Subir Comentario" /></div>
</form>

</body>
</html>