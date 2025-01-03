<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hasil Pembelian Tiket</title>
</head>
<body>
    <h1>Hasil Pembelian Tiket</h1>
    <%
        String result = (String) request.getAttribute("result");
        if ("success".equals(result)) {
    %>
        <p>Tiket berhasil dibuat dan ditambahkan ke database.</p>
    <% 
        } else {
    %>
        <p>Gagal membuat tiket. Silakan coba lagi.</p>
    <% 
        }
    %>
    <br>
    <a href="Home.jsp">Kembali ke Halaman Utama</a>
</body>
</html>
