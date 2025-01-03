<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mega Museum of Indonesia</title>
    <style>
        body {
            background-color: #f0f0f0; /* Warna abu muda */
            font-family: Arial, sans-serif;
            color: #333;
            padding: 20px;
        }

        h1 {
            color: #2c3e50; /* Biru tua */
            text-align: center;
        }

        form {
            background-color: #e6e2d3; /* Beige */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 20px auto;
        }

        label {
            font-size: 16px;
            color: #2c3e50; /* Biru tua */
        }

        input[type="text"], textarea, input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        textarea {
            resize: vertical;
        }

        input[type="submit"] {
            background-color: #2c3e50; /* Biru tua */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #34495e; /* Biru lebih gelap */
        }

        a {
            color: #2c3e50;
            text-decoration: none;
            font-size: 16px;
            margin-top: 20px;
            display: inline-block;
            text-align: center;
            transition: color 0.3s;
        }

        a:hover {
            color: #34495e; /* Biru lebih gelap saat hover */
        }
    </style>
</head>
<body>
    <h1>Tambahkan Article Baru</h1>
    <form action="AddArticleServlet" method="post" enctype="multipart/form-data">
        <label for="title">Judul Article:</label><br>
        <input type="text" id="title" name="title" required><br><br>

        <label for="content">Content:</label><br>
        <textarea id="content" name="content" rows="10" cols="50" required></textarea><br><br>

        <label for="image">Image:</label><br>
        <input type="file" id="image" name="image"><br><br>

        <input type="submit" value="Add Article">
    </form>
    <br>
    <a href="Article.jsp">Kembali</a>
</body>
</html>
