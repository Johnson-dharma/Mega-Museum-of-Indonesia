<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mega Museum of Indonesia</title>
        <link rel="shortcut icon" href="Gambar/LOGO.png">
        <style>
            @font-face {
                font-family: 'Jacques Francois';
                src: url('JacquesFrancois-Regular.ttf') format('truetype');
            }
            body {
                font-family: 'Jacques Francois', serif;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 0;
                overflow: hidden;
                background-image: url('Gambar/Login.png');
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;
            }
            .decor {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
            }
            .decor::before, .decor::after {
                content: '';
                position: absolute;
                background: linear-gradient(135deg, beige, #a59a9a, #646153);
                border-radius: 50%;
                animation: move 3s infinite alternate;
            }
            .decor::before {
                width: 200px;
                height: 200px;
                top: 10%;
                left: 10%;
            }
            .decor::after {
                width: 300px;
                height: 300px;
                bottom: 10%;
                right: 10%;
            }
            @keyframes move {
                0% {
                    transform: translateY(0);
                }
                100% {
                    transform: translateY(-20px) translateX(20px);
                }
            }
            .container {
                width: 320px;
                background: linear-gradient(to right, #494848, #6b6b6b, #8c8c8c);
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                transition: transform 0.3s ease-in-out;
                left: 36.5%;
                position: absolute;
                padding: 3%;
            }
            .container h2 {
                text-align: center;
                margin-bottom: 20px;
                color: beige;
            }
            .form-group {
                margin-bottom: 15px;
                padding: 0 20px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                color: rgb(215, 215, 161);
            }
            .form-group input {
                width: 100%;
                padding: 10px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 5px;
                transition: border 0.3s ease;
            }
            .form-group input:focus {
                border-color: #fda085;
            }
            .button-group {
                text-align: center;
                padding: 0 20px 20px;
            }
            .button-group button {
                width: 100%;
                padding: 10px;
                border: none;
                border-radius: 5px;
                background: beige;
                color: black;
                cursor: pointer;
            }
            .button-group button:hover {
                background: #2f2828;
                color: beige;
            }
            .toggle-link {
                text-align: center;
                display: block;
                margin: 10px 0 20px;
                color: rgb(215, 215, 161);
                cursor: pointer;
                text-decoration: none;
            }
            .toggle-link:hover {
                text-decoration: underline;
            }
            .container.hidden {
                transform: scale(0);
            }
            .role{
                padding: 20px;
            }

            select {
                background-color: #ffffff;
                border-radius: 8px;
                padding: 10px 15px;
                font-size: 15px;
                color: #333;
                cursor: pointer;
                width: 200px;
                transition: all 0.3s ease;
            }
        </style>
    </head>
    <body>
        <div class="decor"></div>
        <div class="container" id="login-form">
            <h2>Login</h2>
            <form action="LoginServlet" class="form-login" method="post">
                <div class="form-group">
                    <label for="login-input-user">Username</label>
                    <input type="text" id="login-input-user" name="username" placeholder="Masukkan Username" required>
                </div>
                <div class="form-group">
                    <label for="login-input-password">Password</label>
                    <input id="login-input-password" type="password" name="password" placeholder="Masukkan Password">
                </div>
                <div class="form-group">
                    <label for="role">Login sebagai:</label>
                    <select id="role" name="userType">
                        <option value="visitor">User</option>
                        <option value="staff">Staff</option>
                    </select>
                </div>
                <div class="button-group">
                    <button type="submit">Login</button>
                </div>
            </form>
            <a class="toggle-link" onclick="showRegister()">Belum punya akun? Register di sini</a>
        </div>

        <div class="container hidden" id="register-form">
            <h2>Register</h2>
            <form action="RegisterServlet" method="post">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Masukkan Email">
                </div>
                <div class="form-group">
                    <label for="new-username">Username</label>
                    <input type="text" id="new-username" name="username" placeholder="Masukkan Username">
                </div>
                <div class="form-group">
                    <label for="new-password">Password</label>
                    <input type="password" id="new-password" name="password" placeholder="Masukkan Password">
                </div>
                <div class="button-group">
                    <input type="hidden" name="userType" value="visitor">
                    <button type="submit">Register</button>
                </div>
            </form>
            <a class="toggle-link" onclick="showLogin()">Sudah punya akun? Login di sini</a>
        </div>

        <script>
            function showRegister() {
                document.getElementById('login-form').classList.add('hidden');
                setTimeout(() => {
                    document.getElementById('register-form').classList.remove('hidden');
                }, 300);
            }

            function showLogin() {
                document.getElementById('register-form').classList.add('hidden');
                setTimeout(() => {
                    document.getElementById('login-form').classList.remove('hidden');
                }, 300);
            }
        </script>
        <%String errorMessage = (String) request.getAttribute("errorMessage");%>
        <%if (errorMessage != null) {%>
        <script>
                alert('<%= errorMessage%>'); // Menampilkan pesan error
        </script>
        <%}%>
        
       
    </body>
</html>