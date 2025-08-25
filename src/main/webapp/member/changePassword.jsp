<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경 - Toour</title>
    <link rel="stylesheet" href="<c:url value="/css/style.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <style>
        .change-password-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .change-password-title {
            margin-bottom: 30px;
            color: #333;
            font-size: 24px;
            font-weight: bold;
        }
        
        .info-message {
            background: #e7f3ff;
            border: 1px solid #b3d9ff;
            color: #0066cc;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
            font-size: 16px;
            line-height: 1.5;
        }
        
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #1a73e8;
            box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
        }
        
        .change-button {
            width: 100%;
            padding: 14px;
            background: #1a73e8;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-bottom: 20px;
        }
        
        .change-button:hover {
            background: #1557b0;
        }
        
        .change-button:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
        }
        
        .validation-message {
            font-size: 14px;
            margin-top: 5px;
            padding-left: 5px;
        }
        
        .validation-message.success {
            color: #28a745;
        }
        
        .validation-message.error {
            color: #dc3545;
        }
        
        .error-message {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .success-message {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="change-password-container">
        <h1 class="change-password-title">비밀번호 변경</h1>
        
        <div class="info-message">
            <strong>보안을 위해 비밀번호를 변경해주세요.</strong><br>
            임시 비밀번호로 로그인하셨습니다. 새로운 비밀번호로 변경 후 서비스를 이용하실 수 있습니다.
        </div>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="success-message">
                ${success}
            </div>
        </c:if>
        
        <form action="Controller?type=changePassword" method="post" id="changePasswordForm">
            <div class="form-group">
                <label for="new_password">새 비밀번호</label>
                <input type="password" id="new_password" name="new_password" required>
                <div id="password_validation" class="validation-message"></div>
            </div>
            
            <div class="form-group">
                <label for="confirm_password">새 비밀번호 확인</label>
                <input type="password" id="confirm_password" name="confirm_password" required>
                <div id="confirm_validation" class="validation-message"></div>
            </div>
            
            <button type="submit" class="change-button" id="submitBtn" disabled>비밀번호 변경</button>
        </form>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        $(document).ready(function() {
            let passwordValid = false;
            let confirmValid = false;
            
            // 새 비밀번호 유효성 검사
            $("#new_password").keyup(function() {
                const password = $(this).val().trim();
                const $validation = $("#password_validation");
                
                if (password.length < 8) {
                    $validation.removeClass('success').addClass('error').text("비밀번호는 8자 이상이어야 합니다.");
                    passwordValid = false;
                } else if (!/^(?=.*[a-zA-Z])(?=.*[0-9])/.test(password)) {
                    $validation.removeClass('success').addClass('error').text("영문과 숫자를 포함해야 합니다.");
                    passwordValid = false;
                } else {
                    $validation.removeClass('error').addClass('success').text("사용 가능한 비밀번호입니다.");
                    passwordValid = true;
                }
                
                updateSubmitButton();
            });
            
            // 비밀번호 확인 검사
            $("#confirm_password").keyup(function() {
                const password = $("#new_password").val().trim();
                const confirm = $(this).val().trim();
                const $validation = $("#confirm_validation");
                
                if (confirm.length === 0) {
                    $validation.removeClass('success error').text("");
                    confirmValid = false;
                } else if (password === confirm) {
                    $validation.removeClass('error').addClass('success').text("비밀번호가 일치합니다.");
                    confirmValid = true;
                } else {
                    $validation.removeClass('success').addClass('error').text("비밀번호가 일치하지 않습니다.");
                    confirmValid = false;
                }
                
                updateSubmitButton();
            });
            
            // 제출 버튼 활성화/비활성화
            function updateSubmitButton() {
                if (passwordValid && confirmValid) {
                    $("#submitBtn").prop('disabled', false);
                } else {
                    $("#submitBtn").prop('disabled', true);
                }
            }
            
            // 폼 제출 처리
            $("#changePasswordForm").submit(function(e) {
                if (!passwordValid || !confirmValid) {
                    e.preventDefault();
                    alert("모든 조건을 만족해주세요.");
                    return false;
                }
            });
        });
    </script>
</body>
</html>
