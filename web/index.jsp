<%-- 
    Document   : Index
    Created on : 11 Dec 2024, 00.38.55
    Author     : raya
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega Museum of Indonesia</title>
    <link rel="shortcut icon" href="Gambar/LOGO.png">
    <link rel="stylesheet" href="CSS/MainDashboard.css">
    <script src="JS/MainDashboard.js" defer></script>
</head>
<body>
    <div class="Header">
        <h1>
            <span>MEGA MUSEUM</span>
            <span>OF INDONESIA</span>
        </h1>
        <img class="PicHeader" src="Gambar/NavbarPIC_MainMenu.jpg" alt="HeaderPic">
        <div class="hamburger-menu" onclick="toggleMenu()">
            <span></span>
            <span></span>
            <span></span>
        </div>

        <div class="overlay" id="menuOverlay">
            <div class="menu-content">
                <span class="close" onclick="toggleMenu()">X</span>
                <ul>
                    <li><a href="Login.jsp">Login</a></li>
                    <li><a href="Login.jsp">Buy Online Ticket</a></li>
                    <li><a href="Login.jsp">Online Obyek Display</a></li>
                    <li><a href="Login.jsp">Article Collection</a></li>
                    <li><a href="aboutus.jsp">About Us</a></li>
                </ul>
            </div>
        </div>

        <img class="PICLogo" src="Gambar/LOGO.png" alt="LogoPIC">
        <h2>All History Is In Your Hand</h2>
    </div>
    
    <diV class="Main">
        <h3>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur posuere augue id sem lacinia tincidunt. Fusce lacus justo, imperdiet ac massa non, egestas interdum risus. Aenean consectetur quam purus, a vulputate diam mollis eu.</p>
            <p>Donec luctus dapibus mollis. Pellentesque mollis, tellus id faucibus fermentum, felis magna sagittis metus, vel sollicitudin metus velit vitae erat. Quisque a sagittis velit. Quisque nec libero urna. Praesent felis ex, convallis sed eleifend sit amet, rutrum id neque. Phasellus luctus nunc nec orci porta varius. Quisque congue porta leo, ac faucibus sem maximus in.</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum neque in vehicula imperdiet. Praesent id convallis arcu, sit amet varius libero. Nunc ullamcorper magna at nisi tincidunt mollis. Donec facilisis bibendum volutpat. Curabitur consequat ultricies imperdiet. Vivamus et ex fermentum, mollis ligula vitae, sagittis erat.</p>
        </h3>
        <div class="Partner">
            <h2>Meet Our Partner</h2>
            <div class="slider-container">
                <div class="image-slider">
                    <div class="slide-container">
                        <img src="Gambar/Museum_Bank_Indonesia.jpg" alt="Museum Bank Indonesia" class="slide">
                        <p class="caption">Museum Bank Indonesia</p>
                    </div>
                    <div class="slide-container">
                        <img src="Gambar/Museum_Nasional_Indonesia.jpg" alt="Museum Nasional Indonesia" class="slide">
                        <p class="caption">Museum Nasional Indonesia</p>
                    </div>
                    <div class="slide-container">
                        <img src="Gambar/Museum-Pos-Indonesia.jpg" alt="Museum Pos Indonesia" class="slide">
                        <p class="caption">Museum Pos Indonesia</p>
                    </div>
                    <div class="slide-container">
                        <img src="Gambar/MuseumWayang.jpg" alt="Museum Wayang" class="slide">
                        <p class="caption">Museum Wayang</p>
                    </div>
                    <div class="slide-container">
                        <img src="Gambar/Museum_Fatahillah.jpg" alt="Museum Fatahillah" class="slide">
                        <p class="caption">Museum Fatahillah</p>
                    </div>
                    <div class="slide-container">
                        <img src="Gambar/MuseumTamanPrasasti.jpg" alt="Museum Taman Prasasti" class="slide">
                        <p class="caption">Museum Taman Prasasti</p>
                    </div>
                </div>
            </div>
            
            <div class="buttons">
                <button id="prev">
                    <img src="Gambar/Arror_left.png" alt="Previous" class="arrow-icon">
                </button>
                <button id="next">
                    <img src="Gambar/Arrow_right.png" alt="Next" class="arrow-icon">
                </button>
            </div>
        </div>
        
        <div class="EnjoyServices">
            <h2>Enjoy Our Services</h2>
            <div class="service-container">
                <div class="service-item">
                    <a href="Login.jsp">
                        <img src="Gambar/MuseumTicket.png" alt="Museum Ticket" class="services-pic">
                    </a>
                    <p class="caption2">Buy Museum Ticket</p>
                </div>
                <div class="service-item">
                    <a href="Login.jsp">
                        <img src="Gambar/OnlineObyekDisplay.jpg" alt="Obyek Display" class="services-pic">
                    </a>
                    <p class="caption2">Online Obyek Display</p>
                </div>
                <div class="service-item">
                    <a href="Login.jsp">
                        <img src="Gambar/artikel.jpg" alt="Artikel" class="services-pic">
                    </a>
                    <p class="caption2">Article</p>
                </div>
            </div>
        </div>  
        
        <footer>
            <div class="footerUp">
                <img src="Gambar/LOGO.png" alt="logo" class="logo-footer">
                <ul>
                    <li>Email: megamuseumidn@megamuseum.co.id</li>
                    <li>Instagram: @megamuseum</li>
                    <li>Telepon : (021) 8888888</li>
                </ul>
            </div>
            <div class="footerDown">
                <p>COPYRIGHT 2024 MEGA MUSEUM IDN, ALL RIGHT RESERVED. TERMS OF USE. PRIVACY STATEMENT</p>
            </div>
        </footer>

    </div>
    
</body>
</html>