<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="com.br.ideapp.Idea" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/css/bootstrap.css"/>
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
%>

<form action="/submitIdea" method="post">
    <div><textarea name="content" rows="3" cols="60"></textarea></div>
    <div><input type="submit" value="Subir Idea" /></div>
</form>

<form action="/newsletter" method="post">
    <div><textarea name="content" rows="3" cols="60"></textarea></div>
    <div><input type="submit" value="Mandar mail" /></div>
</form>

<h1>Últimas ideas</h1>

<%

List<Idea> lastIdeas = ObjectifyService.ofy().load().type(Idea.class).order("-date").limit(5).list();
for (Idea idea : lastIdeas) {
    pageContext.setAttribute("idea_content", idea.getContent());
    String url = "ideaDetail.jsp?ideaId=" + idea.getId();
%>

    <a href='<%= url%>'><blockquote>${fn:escapeXml(idea_content)}</blockquote></a>
<%
    }
%>


<h1>Ideas más exitosas</h1>

<%

List<Idea> famousIdeas = ObjectifyService.ofy().load().type(Idea.class).order("-score").limit(5).list();
for (Idea idea : famousIdeas) {
    pageContext.setAttribute("idea_content", idea.getContent());
    String url = "ideaDetail.jsp?ideaId=" + idea.getId();
%>

    <a href='<%= url%>'><blockquote>${fn:escapeXml(idea_content)}</blockquote></a>
<%
    }
%>

</body>
</html>