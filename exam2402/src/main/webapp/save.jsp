<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 폼에서 전송된 데이터 가져오기
String title = request.getParameter("title");
String author = request.getParameter("author");
String content = request.getParameter("content");

// 데이터베이스 연결
Connection conn = null;
PreparedStatement pstmt = null;
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");

    // 쿼리 작성 및 실행
    String sql = "INSERT INTO board (num, title, content, regtime, hits, memberno)" + "VALUES (seq_board.nextval, ?, ?, SYSDATE, 0,  (SELECT memberno FROM member WHERE id=?))";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setString(3, author); // 사용자 입력값인 author를 바인딩
    pstmt.executeUpdate();

    // 작성이 완료되면 게시판 페이지로 리다이렉트
    response.sendRedirect("board.jsp");
} catch (SQLException e) {
    // SQL 예외 처리
    e.printStackTrace(); // 에러 로그 출력
    out.println("<p>글 작성 중 오류가 발생했습니다. 다시 시도해주세요.</p>"); // 클라이언트에게 오류 메시지 전송
} catch (Exception e) {
    // 그 외 예외 처리
    e.printStackTrace(); // 에러 로그 출력
    out.println("<p>글 작성 중 예기치 못한 오류가 발생했습니다. 다시 시도해주세요.</p>"); // 클라이언트에게 오류 메시지 전송
} finally {
    // 리소스 해제
    if (pstmt != null) {
        try {
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (conn != null) {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>
