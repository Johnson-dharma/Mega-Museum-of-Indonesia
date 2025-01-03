<%@page import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="classes.JDBC"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    JDBC jdbc = new JDBC();
     int id = (int) session.getAttribute("id");
    double megaWallet = 0;
     try {
        String query = "SELECT megaWallet FROM users WHERE id = ?";
        java.sql.Connection con = jdbc.getConnection();
        PreparedStatement stm = con.prepareStatement(query);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            megaWallet = rs.getDouble("megaWallet");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega Museum of Indonesia</title>
    <link rel="shortcut icon" href="Gambar/LOGO.png">
    <link rel="stylesheet" href="CSS/BuyTicket.css">
    <style>
        body {
            color:black;
            font-family: "Questrial", sans-serif;
            background-color: #494848;
            background-image: linear-gradient(
                45deg,
                black 25%,
                transparent 25%,
                transparent 75%,
                black 75%,
                black
                ),
                linear-gradient(
                -45deg,
                rgb(56, 54, 54) 25%,
                transparent 25%,
                transparent 75%,
                rgb(56, 54, 54) 75%,
                rgb(56, 54, 54)
                );
            background-size: 60px 60px;
            background-position: 0 0;
            animation: slide 4s infinite linear;
            font-family: 'Jacques Francois', serif; 
        }

        @keyframes slide {
            from {
                background-position: 0 0;
            }

            to {
                background-position: -120px 60px;
            }
        }
        
        .konten h1{
            display: flex;
            justify-content: center;
            align-items: center;
            color: whitesmoke;
            font-size: 300%;
            margin-top: 18%;
        }
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* Latar belakang gelap dengan transparansi */
            display: none; /* Tidak terlihat secara default */
            backdrop-filter: blur(5px); /* Efek blur pada latar belakang */
            z-index: 998; /* Pastikan overlay berada di atas konten lainnya */
        }

        .modal {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            width: auto;
            display: none; /* Modal tidak terlihat secara default */
            flex-direction: column;
            align-items: center;
            padding: 1.6rem 3rem;
            border: 3px solid black;
            border-radius: 5px;
            background: white;
            box-shadow: 8px 8px 0 rgba(0, 0, 0, 0.2);
            z-index: 999; /* Pastikan modal berada di atas overlay */
        }

        .modal.active {
            display: inline-flex; /* Tampilkan modal ketika class 'active' ditambahkan */
        }

        .overlay.active {
            display: block; /* Tampilkan overlay ketika modal aktif */
        }
    
        .message {
          font-size: 1.1rem;
          margin-bottom: 1.6rem;
          margin-top: 0;
        }
    
        .btn {
          color: black;
          font-family: inherit;
          font-size: inherit;
          background: white;
          padding: 0.3rem 3.4rem;
          border: 3px solid black;
          margin-right: 2.6rem;
          box-shadow: 0 0 0 black;
          transition: all 0.2s;
        }
    
        .btn:last-child {
          margin: 0;
        }
    
        .btn:hover {
          box-shadow: 0.4rem 0.4rem 0 black;
          transform: translate(-0.4rem, -0.4rem);
        }
    
        .btn:active {
          box-shadow: 0 0 0 black;
          transform: translate(0, 0);
        }
    
        .options {
          display: flex;
          flex-direction: row;
          justify-content: space-between;
        }

        .modal p{
            color: black;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header">
            <a href="Home.jsp">
                <img src="Gambar/LOGO.png" alt="LOGO" class="Logo">
            </a>
        </div>
    </div>

    <div class="konten">
        <h1>BUY TICKET</h1>
        <div class="Buying">
            <h2>Book Your Ticket Now!</h2>
            <form action="BuyTicketServlet" method="post">
                <div class="tanggal">
                    <label for="date">Date</label> <br>
                    <input type="date" id="date" name="date" required>
                </div>
                
                <div class="lokasi">
                    <label for="location">Location</label> <br>
                    <select id="location" name="location" required>
                        <option value="Museum-Bank-Indonesia">Museum Bank Indonesia</option>
                        <option value="Museum-Nasional-Indonesia">Museum Nasional Indonesia</option>
                        <option value="Museum-Pos-Indonesia">Museum Pos Indonesia</option>
                        <option value="Museum-Wayang">Museum Wayang</option>
                        <option value="Museum-Fatahillah">Museum Fatahillah</option>
                        <option value="Museum-Taman-Prasasti">Museum Taman Prasasti</option>
                    </select>
                </div>
                
                <div class="jumlah">
                    <label for="quantity">Quantity</label> <br>
                    <input type="number" id="quantity" name="quantity" step="1" min="1" required>
                </div>

                <button id="openModal" class="btn" type="button">Find Ticket</button>

                <div class="overlay" id="overlay">
                    <div class="modal" id="modal">
                        <p class="message">Saldo MegaWallet anda: Rp. <%= String.format("%,.0f", megaWallet) %></p>
                        <p class="message">Total Harga Tiket: Rp. <span id="totalPrice">0</span></p>
                        <p class="message">Are you sure you want to book the ticket?</p>
                        <div class="options">
                            <button class="btn" id="confirmYes" type="submit">Yes</button>
                            <button class="btn" type="button" id="closeModal2">No</button>
                        </div>
                    </div>        
                </div>

            </form>
        </div>
    </div>

    <script>
        const locationPrices = {
    "Museum-Bank-Indonesia": 50000,  // harga untuk Museum Bank Indonesia
    "Museum-Nasional-Indonesia": 40000,  // harga untuk Museum Nasional Indonesia
    "Museum-Pos-Indonesia": 15000,  // harga untuk Museum Pos Indonesia
    "Museum-Wayang": 30000,  // harga untuk Museum Wayang
    "Museum-Fatahillah": 10000,  // harga untuk Museum Fatahillah
    "Museum-Taman-Prasasti": 60000  // harga untuk Museum Taman Prasasti
};

const openModalBtn = document.getElementById('openModal');
const modal = document.getElementById('modal');
const overlay = document.getElementById('overlay');
const closeModalBtn = document.getElementById('closeModal2');
const totalPriceSpan = document.getElementById('totalPrice');
const locationSelect = document.getElementById('location');
const quantityInput = document.getElementById('quantity');

// Tampilkan modal dan overlay ketika tombol "Find Ticket" diklik
openModalBtn.addEventListener('click', () => {
    const location = locationSelect.value;
    const pricePerTicket = locationPrices[location];  // Ambil harga berdasarkan lokasi yang dipilih
    const quantity = parseInt(quantityInput.value, 10);

    if (!isNaN(pricePerTicket) && !isNaN(quantity)) {
        const totalPrice = pricePerTicket * quantity; // Hitung total harga
        totalPriceSpan.textContent = totalPrice.toLocaleString(); // Format total harga ke format angka
    } else {
        totalPriceSpan.textContent = '0'; // Default jika input tidak valid
    }

    modal.classList.add('active');
    overlay.classList.add('active'); // Tampilkan overlay
});

// Sembunyikan modal dan overlay ketika tombol "No" diklik
closeModalBtn.addEventListener('click', () => {
    modal.classList.remove('active');
    overlay.classList.remove('active'); // Sembunyikan overlay
});

    </script>
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if ("insufficient".equals(request.getAttribute("result"))) {%>
    <script>
        alert('<%= errorMessage%>'); // Menampilkan pesan error
    </script>
    <%}%>

</body>
</html>
