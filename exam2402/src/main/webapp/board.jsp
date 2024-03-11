<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 데이터베이스 연결
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");

// 게시물 목록 조회
String sql = "SELECT * FROM board";
PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<!-- save.js 파일 추가 -->
<script src="save.js"></script>
</head>
<body>
    <div class="container" style="padding-top: 50px">
        <h1>게시판</h1>
        <a href="write.jsp" class="btn btn-primary mb-3">글 작성</a> <!-- 글 작성 버튼 -->
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">제목</th>
                    <th scope="col">작성자</th>
                    <th scope="col">내용</th>
                    <th scope="col">삭제</th> <!-- 삭제 버튼 추가 -->
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                <tr>
                    <th scope="row"><%= rs.getInt("num") %></th>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getString("memberno") != null ? rs.getString("memberno") : "미지정" %></td>
                    <td><%= rs.getString("content") %></td>
                    <td>
                        <form action="deleteBoard.jsp" method="post">
                            <input type="hidden" name="num" value="<%= rs.getInt("num") %>">
                            <button type="submit" class="btn btn-danger">삭제</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>
</html>
