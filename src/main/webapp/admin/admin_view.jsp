<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <title>회원정보 관리</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <style>
      body {
          margin: 0;
          font-family: 'Noto Sans KR', sans-serif;
          background-color: #f0f4f8;
          display: flex;
          height: 100vh;
          font-size: 14px; /* 기본 글자 크기 약간 줄임 */
      }

      .sidebar {
          width: 200px; /* 너비 줄임 */
          background-color: #2c3e50;
          color: white;
          padding: 15px 20px;
          display: flex;
          flex-direction: column;
          font-size: 14px; /* 사이드바 글자 크기 */
      }

      .sidebar a {
          color: white;
          text-decoration: none;
          margin-bottom: 12px;
          padding: 8px 10px;
          border-radius: 5px;
          transition: background 0.3s;
          font-size: 14px;
      }

      .sidebar a:hover {
          background-color: #34495e;
      }

      .page-title {
          font-size: 32px;
          font-weight: bold;
          color: #000000;
          margin-bottom: 30px;
      }

      .main-content {
          flex: 1;
          padding: 30px 40px;
          background-color: #fff;
          overflow-y: auto;
          display: flex;
          flex-direction: column;
          font-size: 14px;
      }


      .search-area {
          margin-bottom: 15px;
      }

      form.search-form {
          display: flex;
          gap: 8px;
          align-items: center;
      }

      select, input[type="text"] {
          padding: 6px 10px;
          font-size: 13px;
          border: 1px solid #cbd5e1;
          border-radius: 5px;
          outline: none;
          font-family: 'Noto Sans KR', sans-serif;
          box-sizing: border-box;
      }

      button {
          padding: 7px 16px;
          background-color: #2563eb; /* 요청하신 색 */
          color: white;
          border: none;
          border-radius: 5px;
          font-weight: 500;
          cursor: pointer;
          font-size: 14px;
          transition: background-color 0.3s;
      }

      button:hover {
          background-color: #1d4ed8;
      }

      table {
          width: 100%;
          border-collapse: collapse;
          border-radius: 5px;
          overflow: hidden;
          box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
          margin-bottom: 25px;
          font-size: 14px;
      }

      thead {
          background-color: #2563eb; /* 요청 색으로 변경 */
          color: white;
          font-weight: 600;
      }

      th, td {
          padding: 12px 10px;
          text-align: left;
          border-bottom: 1px solid #e2e8f0;
          font-size: 13px;
      }

      tbody tr:hover {
          background-color: #f0f4f8;
          cursor: pointer;
      }

      tbody tr td a {
          color: #2563eb; /* 링크 색상도 동일 */
          text-decoration: none;
          font-size: 13px;
      }

      tbody tr td a:hover {
          text-decoration: underline;
      }

      .paging-area {
          display: flex;
          justify-content: space-between;
          align-items: center;
          font-size: 13px;
      }

      ol.paging {
          list-style: none;
          display: flex;
          gap: 6px;
          padding: 0;
          margin: 0;
      }

      ol.paging li {
          padding: 5px 10px;
          border-radius: 5px;
          border: 1px solid #cbd5e1;
          font-size: 13px;
          cursor: pointer;
          user-select: none;
      }

      ol.paging li.now {
          background-color: #2563eb;
          color: white;
          border-color: #2563eb;
          cursor: default;
      }

      ol.paging li.disable {
          color: #a0aec0;
          cursor: default;
          border-color: #e2e8f0;
      }

      ol.paging li a {
          text-decoration: none;
          color: inherit;
          display: block;
          width: 100%;
          height: 100%;
      }

      input[type="button"].write-btn {
          background-color: #2563eb;
          padding: 8px 18px;
          border: none;
          color: white;
          font-weight: 600;
          border-radius: 5px;
          cursor: pointer;
          transition: background-color 0.3s;
          font-size: 14px;
      }

      input[type="button"].write-btn:hover {
          background-color: #1d4ed8;
      }


  </style>
</head>
<body>

<c:import url="/common/adminSidebar.jsp"/>


<c:set var="vo" value="${requestScope.vo}" scope="page"/>
<div class="main-content">

  <h1 class="page-title">회원정보 관리</h1>
    <div class="MyInfo-container" id="MyInfo-container">
        <form action="AdminController?type=adminmeminfo" method="post" name="MyInfo_form">
            <input type="hidden" id="member_idx" name="member_idx" value="${vo.member_idx}" />
            <table class="MyInfo-table">
<%--                <caption class="hidden">개인정보 테이블</caption>--%>
                <tbody>
                <tr>
                    <td>ID:</td>
                    <td>
                        <div class="input-group">
                            <div class="input-with-message">
                                <input type="text" id="u_id" name="u_id" class="input-field input-field-full" placeholder="아이디" value="${vo.member_id}" disabled/>
                                <div id="id_usable" class="validation-message"></div>
                            </div>
                        </div>
                    </td>
                </tr>
<%--                <tr id="pw" hidden="hidden">--%>
<%--                    <td>PW:</td>--%>
<%--                    <td>--%>
<%--                        <div class="input-group">--%>
<%--                            <div class="input-with-message">--%>
<%--                                <input type="password" id="u_pw" name="u_pw" class="input-field input-field-full" placeholder="비밀번호" />--%>
<%--                                <div id="pw_usable" class="validation-message"></div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--                <tr id="re-pw" hidden="hidden">--%>
<%--                    <td>RE-PW:</td>--%>
<%--                    <td>--%>
<%--                        <div class="input-group">--%>
<%--                            <div class="input-with-message">--%>
<%--                                <input type="password" id="u_repw" name="u_repw" class="input-field input-field-full" placeholder="비밀번호 확인"/>--%>
<%--                                <div id="repw_usable" class="validation-message"></div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
                <tr>
                    <td>별명:</td>
                    <td>
                        <div class="input-group">
                            <div class="input-with-message">
                                <input type="text" id="u_nickname" name="u_nickname" class="input-field input-field-full" placeholder="별명" value="${vo.member_nickname}" disabled/>
                                <div id="nickname_usable" class="validation-message"></div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>이름:</td>
                    <td>
                        <input type="text" id="u_name" name="u_name" class="input-field" placeholder="이름" value="${vo.member_name}" disabled/>
                    </td>
                </tr>
                <tr>
                    <td>이메일:</td>
                    <td>
                        <div class="input-group">
                            <div class="email-group">
                                <c:set var="emailIndex" value="${fn:indexOf(vo.member_email, '@')}"/>
                                <c:set var="email1" value="${fn:substring(vo.member_email,0,emailIndex)}"/>
                                <c:set var="email2" value="${fn:substring(vo.member_email,emailIndex+1,fn:length(vo.member_email))}"/>
                                email2: ${email2} <br/>
                                email1: ${email1} <br/>
                                emailIndex: ${emailIndex} <br/>
                                <input type="email" id="u_email" name="u_email" class="input-field" placeholder="이메일" value="${email1}" disabled/>
                                <span class="email-separator">@</span>
                                <input type="email" id="u_email2" name="u_email2" class="input-field" placeholder="직접 입력" value="${email2}" disabled/>
                                <select id="emailAddr" name="emailAddr" class="email-select">
                                    <option value="">직접 입력</option>
                                    <option value="naver.com" <c:if test="${email2.equals('naver.com')}" > selected</c:if> >naver.com</option>
                                    <option value="gmail.com" <c:if test="${email2.equals('gmail.com')}" > selected</c:if> >gmail.com</option>
                                    <option value="daum.com" <c:if test="${email2.equals('daum.com')}" > selected</c:if> >daum.com</option>
                                    <option value="nate.com" <c:if test="${email2.equals('nate.com')}" > selected</c:if> >nate.com</option>
                                </select>
                            </div>
                            <div style="display: flex; align-items: center; margin-top: 5px;">
                                <button type="button" id="chkEmail" class="action-button">중복 검사</button>
                                <div id="email_usable" class="validation-message" style="margin-left: 10px;"></div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>경고횟수:</td>
                    <td>
                        <input type="text" id="u_warning" name="u_warning" class="input-field" placeholder="경고횟수" value="현재 경고횟수:${vo.member_warning}" disabled/>
                        <p>변경할 경고횟수:</p>
                        <select id="warning" name="u_warning" class="warning" disabled>
                            <option value="">직접 입력</option>
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select>
                    </td>
                </tr>
                <tr id="revision_btn">
                    <td colspan="2">
                        <button type="button" onclick="goChange()" class="">수정하기</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>

<script>


    $(function (){
        $("#emailAddr").change(function () {
            $("#u_email2").val("");
        })
    });


    //개인정보 확인 dialog에서 [수정하기]를 눌렀을 때
    function goChange(){
        // document.getElementById("u_id").disabled = false;
        document.getElementById("u_nickname").disabled = false;
        document.getElementById("u_name").disabled = false;
        document.getElementById("u_email").disabled = false;
        document.getElementById("u_email2").disabled = false;
        document.getElementById("u_warning").disabled = false;
        document.getElementById("warning").disabled = false;

        $("#pw").removeAttr("hidden");
        $("#re-pw").removeAttr("hidden");

        $("#revision_btn").html(
            "<button type='button' onClick='saveMemInfo()'>변경</button> <button type='button' onClick='cancelMyInfo()'>취소</button>"
        )

    }

    //개인정보 확인 dialog에서 정보 수정 후 [변경]을 눌렀을 때
    function saveMemInfo() {
        let member_idx = $("#member_idx").val();
        console.log(member_idx);
        let u_nickname = $("#u_nickname").val().trim();
        let u_name = $("#u_name").val().trim();
        let u_email = $("#u_email").val().trim();
        let u_email2 = $("#u_email2").val().trim();
        let u_warning = $("#warning").val();

        let chk = 0;

        // 별명 검사
        if ($("#nickname_usable").hasClass("error")) {
            chk++;
        }

        if (chk === 0) {
            // 데이터 준비
            const formData = {
                member_idx: member_idx,   // 추가
                u_nickname: u_nickname,
                u_name: u_name,
                u_email: u_email,
                u_email2: u_email2,
                u_warning: u_warning
            };

            console.log("전송 데이터:", formData);

            $.ajax({
                url: "AdminController?type=adminmeminfo",
                type: "POST",
                data: formData,
                success: function (res) {
                    alert("회원 정보가 성공적으로 변경되었습니다.");
                    location.href = "AdminController?type=adminmemlist";
                },
                error: function () {
                    alert("저장 중 오류가 발생했습니다.");
                }
            });
        } else {
            alert("입력 양식을 모두 충족해주세요.");
        }
    }


    // 별명 창에 타이핑을 쳤을 때
    $("#u_nickname").keyup(function (){
        const u_nickname_t = $("#u_nickname").val().trim();
        if (u_nickname_t.length > 0) {
            $.ajax({
                url: "Controller?type=chknickname",
                type: "post",
                data:{ u_nickname: u_nickname_t }
            }).done(function (res) {
                updateValidationMessage("#nickname_usable", res);
                if(u_nickname_t == "${sessionScope.member.member_nickname}"){
                    $("#nickname_usable").removeClass("success error");
                    $("#nickname_usable").addClass("success").html("");
                }
            });
        } else {
            $("#nickname_usable").html("");
        }
    });

    function updateValidationMessage(targetId, res) {
        const $target = $(targetId);
        $target.removeClass('success error');
        if (res.includes("가능")) {
            $target.addClass('success').html(res);
        } else if (res.length > 0) {
            $target.addClass('error').html(res + "<input type='hidden' class='disable_check'>");
        } else {
            $target.html('');
        }
    }


    function changeemail2(select){
        let email = document.getElementById("u_email2");
        let changeemail = select.value;

        if(changeemail === ""){
            email.value = "";
            email.disabled = false;
            email.focus();
        }
        else {
            email.value = changeemail;
            email.disabled = true;
        }

    }

    // 이메일 주소 선택했을 때
    $("#emailAddr").change(function (){
        const emailAddr_v = $(this).val().trim();
        const $u_email2 = $("#u_email2");
        if(emailAddr_v.length > 0) {
            $u_email2.val("");
            $u_email2.prop('disabled', true);
        } else {
            $u_email2.prop('disabled', false);
        }
        // 이메일 정보 변경 시 중복 검사 메시지 초기화
        $("#email_usable").html("<span class='error'>중복 검사 버튼을 눌러주세요</span><input type='hidden' class='disable_check'>");
    });

    // 이메일 중복 검사 버튼을 눌렀을 때
    $("#chkEmail").click(function (){
        const u_email_t = $("#u_email").val().trim();
        let emailAddr = $("#emailAddr").val();

        if(emailAddr.length == 0){
            emailAddr = $("#u_email2").val().trim();
        }

        if (u_email_t.length > 0 && emailAddr.length > 0) {
            $.ajax({
                url: "Controller?type=chkemail",
                type: "post",
                data:{ u_email: u_email_t, emailAddr: emailAddr }
            }).done(function (res) {
                updateValidationMessage("#email_usable", res);
            });
        } else {
            $("#email_usable").html("<span class='error'>이메일을 모두 입력해주세요</span><input type='hidden' class='disable_check'>");
        }
    });

    // 이메일 중복 검사 후에 정보를 바꿨을 때 대비
    $("#u_email, #u_email2").keyup(function (){
        $("#email_usable").html("<span class='error'>중복 검사 버튼을 눌러주세요</span><input type='hidden' class='disable_check'>");
    });


    //개인정보 확인 dialog에서 정보 수정 도중 [취소] 버튼을 눌렀을 때
    function cancelMyInfo() {
        document.location.href = "AdminController?type=adminmemlist";
    }




</script>
</div>
</body>
</html>
