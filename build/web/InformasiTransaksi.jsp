<!DOCTYPE html>
<html>
    <head>
        <title>Pembelian Berhasil</title>
        <style>
            @font-face {
                font-family: 'Jacques Francois';
                src: url('JacquesFrancois-Regular.ttf') format('truetype'); /* Ganti dengan path yang sesuai */
            }
            body {
                font-family: 'Jacques Francois', serif;
                background: linear-gradient(to right, #494848, #6b6b6b, #8c8c8c);
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 0;
            }
            .container {
                background: #6d6857;
                border-radius: 10px;
                padding: 40px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                text-align: center;
                animation: fadeIn 1s ease-in-out;
            }
            .container h1 {
                color: white;
                margin-bottom: 20px;
            }
            .container p {
                color: beige;
                margin-bottom: 30px;
            }
            .button {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                background: beige;
                color: black;
                cursor: pointer;
            }
            .button:hover {
                background: rgb(57, 55, 55);
                color: white;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.9);
                }
                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Pembelian Berhasil!</h1>
            <p>Terima kasih atas pembelian tiket Anda. Kami tunggu kedatangan anda.</p>
            <button class="button" onclick="goToHomepage()">Kembali ke Beranda</button>
        </div>

        <script>
            function goToHomepage() {
                window.location.href = 'Home.jsp'; // Ganti dengan URL beranda Anda
            }
        </script>
    </body>
</html>