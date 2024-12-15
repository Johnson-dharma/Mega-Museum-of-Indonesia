<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Object</title>
</head>
<body>
    <h1>Tambahkan Object Baru</h1>
    <form action="AddObjectServlet" method="post" enctype="multipart/form-data">
        <label for="title">Nama Object:</label><br>
        <input type="text" id="title" name="title" required><br><br>

        <label for="description">Description:</label><br>
        <textarea id="description" name="description" rows="10" cols="50" required></textarea><br><br>

        <label for="image">Image:</label><br>
        <input type="file" id="image" name="image"><br><br>

        <input type="submit" value="Add Object">
    </form>
    <br>
    <a href="HomeServlet">Kembali</a>
</body>
</html>
