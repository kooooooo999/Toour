
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${requestScope.searchValue eq null}">
  <div id="post">
    <div id="search-area">
      <form method="post" action="Controller?type=postSearch">
        <input type="hidden" name="category_idx" value="2">
        <select id="searchType" name="searchType">
          <option value="post_title">제목</option>
          <option value="post_content">내용</option>
        </select>
        <input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue"/>
        <button type="button" class="search-btn" id="search-btn" onclick="mysearch()">검색</button>
      </form>
    </div>
    <table summary="검색결과 목록">
      <caption>검색결과 목록</caption>
      <thead>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>별점</th>
        <th>조회수</th>
        <th>작성일</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${not empty requestScope.myPost_ar}">
        <c:set var="p" value="${requestScope.page}" />
        <c:forEach items="${requestScope.myPost_ar}" var="vo" varStatus="vs">
          <c:set var="num" value="${p.totalCount -((p.nowPage-1)*p.numPerPage+vs.index)}"/>
          <tr>
            <td>${num}</td>
            <td style="text-align: left">
              <a href="Controller?type=view&post_idx=${vo.post_idx}&cPage=${nowPage}">
                  ${vo.post_title}
                <c:if test="${vo.c_list != null and fn:length(vo.c_list) > 0}">
                  (<c:out value="${fn:length(vo.c_list)}"/>)
                </c:if>
              </a>
            </td>
            <td>${vo.member_nickname}</td>
            <td>${vo.post_star}</td>
            <td>${vo.post_views}</td>
            <td>${vo.post_created_at.substring(0,10)}</td>
          </tr>
        </c:forEach>
      </c:if>
      <c:if test="${empty requestScope.myPost_ar}">
        <tr><td colspan="6">작성한 게시글이 없습니다.</td></tr>
      </c:if>
      </tbody>
    </table>
  </div>

  <div class="paging-area">
    <ol class="paging">
      <c:set var="p" value="${requestScope.page}" />
      <c:if test="${p.startPage < p.pagePerBlock}">
        <li class="disable">&lt;</li>
      </c:if>
      <c:if test="${p.startPage >= p.pagePerBlock}">
        <li><a href="javascript:movePage(${p.startPage-p.pagePerBlock})">&lt;</a></li>
      </c:if>
      <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
        <c:if test="${p.nowPage == vs.index}">
          <li class="now">${vs.index}</li>
        </c:if>
        <c:if test="${p.nowPage != vs.index}">
          <li><a href="javascript:movePage(${vs.index})">${vs.index}</a></li>
        </c:if>
      </c:forEach>
      <c:if test="${p.endPage < p.totalPage}">
        <li><a href="javascript:movePage(${p.endPage+1})">&gt;</a></li>
      </c:if>
      <c:if test="${p.endPage >= p.totalPage}">
        <li class="disable">&gt;</li>
      </c:if>
    </ol>
    <input type="button" value="댓글" class="comment-btn" onclick="javascript:location.href=''">
  </div>
</c:if>




<c:if test="${requestScope.searchValue ne null}">

  <div id="post">
    <div id="search-area">
      <form method="post" action="Controller?type=postSearch">
        <input type="hidden" name="searchTypeHidden" value="${requestScope.searchType}">
        <input type="hidden" name="searchValueHidden" value="${requestScope.searchValue}">

        <select id="searchType" name="searchType">
          <option value="post_title" <c:if test="${requestScope.searchType== 'post_title'}">selected </c:if> >제목</option>
          <option value="post_content" <c:if test="${requestScope.searchType== 'post_content'}">selected </c:if> >내용</option>
        </select>
        <input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue" value="${requestScope.searchValue}"/>
        <button type="button" class="search-btn" id="search-btn" onclick="mysearch()">검색</button>
      </form>
    </div>
    <table summary="검색결과 목록">
      <caption>검색결과 목록</caption>
      <thead>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>별점</th>
        <th>조회수</th>
        <th>작성일</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${not empty requestScope.myPost_ar}">
        <c:set var="p" value="${requestScope.page}" />
        <c:forEach items="${requestScope.myPost_ar}" var="vo" varStatus="vs">
          <c:set var="num" value="${p.totalCount -((p.nowPage-1)*p.numPerPage+vs.index)}"/>
          <tr>
            <td>${num}</td>
            <td style="text-align: left">
              <a href="Controller?type=view&post_idx=${vo.post_idx}&cPage=${nowPage}">
                  ${vo.post_title}
                <c:if test="${vo.c_list != null and fn:length(vo.c_list) > 0}">
                  (<c:out value="${fn:length(vo.c_list)}"/>)
                </c:if>
              </a>
            </td>
            <td>${vo.member_nickname}</td>
            <td>${vo.post_star}</td>
            <td>${vo.post_views}</td>
            <td>${vo.post_created_at.substring(0,10)}</td>
          </tr>
        </c:forEach>
      </c:if>
      <c:if test="${empty requestScope.myPost_ar}">
        <tr><td colspan="6">작성한 게시글이 없습니다.</td></tr>
      </c:if>
      </tbody>
    </table>
  </div>

  <div class="paging-area">
    <ol class="paging">
      <c:set var="p" value="${requestScope.page}" />
      <c:if test="${p.startPage < p.pagePerBlock}">
        <li class="disable">&lt;</li>
      </c:if>
      <c:if test="${p.startPage >= p.pagePerBlock}">
        <li><a href="javascript:moveSearchPage(${p.startPage-p.pagePerBlock})">&lt;</a></li>
      </c:if>
      <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
        <c:if test="${p.nowPage == vs.index}">
          <li class="now">${vs.index}</li>
        </c:if>
        <c:if test="${p.nowPage != vs.index}">
          <li><a href="javascript:moveSearchPage(${vs.index})">${vs.index}</a></li>
        </c:if>
      </c:forEach>
      <c:if test="${p.endPage < p.totalPage}">
        <li><a href="javascript:moveSearchPage(${p.endPage+1})">&gt;</a></li>
      </c:if>
      <c:if test="${p.endPage >= p.totalPage}">
        <li class="disable">&gt;</li>
      </c:if>
    </ol>
  </div>
</c:if>