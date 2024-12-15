<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Article</title>
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
    <a href="HomeServlet">Kembali</a>
</body>
</html>
