<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
// 게시물 번호를 받아옴
int num = Integer.parseInt(request.getParameter("num"));

// 데이터베이스 연결
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String username = "scott";
String password = "tiger";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, username, password);

    // 게시물 삭제 쿼리 실행
    String deleteSql = "DELETE FROM board WHERE num = ?";
    pstmt = conn.prepareStatement(deleteSql);
    pstmt.setInt(1, num);
    pstmt.executeUpdate();

    // 삭제가 완료되면 게시판 목록 페이지로 리다이렉트
    response.sendRedirect("board.jsp");
} catch (Exception e) {
    e.printStackTrace();
} finally {
    // 리소스 해제
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
