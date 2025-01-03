<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String userType = (String) session.getAttribute("userType"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>
    <link rel="stylesheet" href="CSS/aboutus.css">
    <style>
        @font-face {
            font-family: 'Jacques Francois';
            src: url('JacquesFrancois-Regular.ttf') format('truetype'); /* Ganti dengan path yang sesuai */
        }

        body {
            font-family: 'Jacques Francois', serif;
            margin: 0;
            padding: 0;
            background-image:linear-gradient(#eee, #aaa);
            background-size: cover;
            color: #333;
        }

        main {
            padding: 50px 20px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            justify-items: center;
            margin-top: 100px;
        }

        p {
            margin: 0;
            color: black;
            font-size: 1.2em;
            margin-top: 10px;
        }

        .profile {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            background: rgba(255, 255, 255, 0.7);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .profile:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }

        .profile img {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #fff;
            margin-bottom: 20px;
        }

        .profile p {
            font-size: 1.1em;
            color: #555;
        }

        footer {
            
            padding: 10px;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            font-size: 1em;
            margin-top: 20px;
        }

        footer p {
            margin: 0;
            color: #ddd;
        }
        
        .header{
            width: 100%;
            height: 100px;
            background-color: #333333;
            position: fixed;
            top: 0;
            left: 0;
        }

        .Logo{
            position: absolute;
            top: 50%;
            left: 3%;
            transform: translate(-50%, -50%); /* Memindahkan setengah dari lebar dan tinggi elemen */
            width: 4%;
            border-radius: 50%;
        }
        
        .logo-footer{
            width: 100px;
        }
        
        .footerUp {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 20px;
            color: white;
        }
        
        ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        ul li {
            margin-bottom: 15px;
        }

        .footerDown {
            text-align: center;
            color: white;
            font-size: 0.8rem;
        }

        .footerDown p {
            margin: 0;
            padding: 5px 0;
        }
        
        .header{
            color: beige;
        }
        
        .header h1{
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="header">
        <%if ("staff".equals(userType)) {%>
            <a href="HomeStaff.jsp">
                <img src="Gambar/LOGO.png" alt="LOGO" class="Logo">
            </a>
        <%}else if ("visitor".equals(userType)){%>
            <a href="Home.jsp">
                <img src="Gambar/LOGO.png" alt="LOGO" class="Logo">
            </a>
        <%}else{%>
            <a href="index.jsp">
                <img src="Gambar/LOGO.png" alt="LOGO" class="Logo">
            </a> 
        <%}%>
        <h1>Mega Museum of Indonesia</h1>
    </div>
    
    <main>
        <div class="profile jonson">
            <img src="Gambar/Johnson.png" alt="Johnson Dharma Leman">
            <p>Nama saya Johnson Dharma Leman, di sini saya bertanggung jawab atas fitur Buy Online Ticket.</p>
        </div>

        <div class="profile maziyah">
            <img src="Gambar/Maziyah.jpg" alt="Maziyah Nurul Huda Agustina">
            <p>Nama saya Maziyah Nurul Huda Agustina, di sini saya bertanggung jawab atas fitur Article.</p>
        </div>

        <div class="profile akmal">
            <img src="Gambar/Akmal.jpg" alt="Muhamad Akmal Insan">
            <p>Nama saya Muhamad Akmal Insan, di sini saya bertanggung jawab atas fitur Profil & List Ticket.</p>
        </div>

        <div class="profile raya">
            <img src="Gambar/Raya.jpg" alt="Sutan Raya Dharma Namanika">
            <p>Nama saya Sutan Raya Dharma Namanika, di sini saya bertanggung jawab atas fitur Top Up & Verification Top Up.</p>
        </div>

        <div class="profile tyas">
            <img src="Gambar/Tyas.jpg" alt="Retno Cahyaningtyas">
            <p>Nama saya Retno Cahyaningtyas, di sini saya bertanggung jawab atas fitur Object.</p>
        </div>

        <div class="profile dani">
            <img src="Gambar/Dani.jpg" alt="Ramadani Saputra">
            <p>Nama saya Ramadani Saputra, di sini saya bertanggung jawab atas fitur Register, Log In, dan Log Out.</p>
                    </div>
    </footer>
</body>
</html>
