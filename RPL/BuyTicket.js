function toggleMenu() {
    const overlay = document.getElementById('menuOverlay');
    overlay.classList.toggle('active'); // Menambahkan atau menghapus kelas 'active' untuk overlay

    // Menambahkan animasi transisi pada hamburger
    const spans = document.querySelectorAll('.hamburger-menu span');
    spans.forEach((span, index) => {
        if (overlay.classList.contains('active')) {
            // Mengubah tampilan hamburger menjadi "X" saat aktif
            span.style.transform = index === 1 ? 'scale(0)' : `translateY(${index === 0 ? '8px' : '-8px'}) rotate(${index === 0 ? '45deg' : '-45deg'})`;
        } else {
            // Kembalikan tampilan hamburger ke bentuk semula
            span.style.transform = 'none';
        }
    });
}
