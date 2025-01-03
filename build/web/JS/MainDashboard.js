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


let currentIndex = 0;
const slides = document.querySelectorAll('.slide');
const totalSlides = slides.length;
const slidesToShow = 3; // Jumlah gambar yang ditampilkan sekaligus
const slideWidth = 300; // Lebar setiap gambar dalam satuan pixel

document.getElementById('next').addEventListener('click', () => {
    if (currentIndex < totalSlides - slidesToShow) {
        currentIndex++;
    } else {
        currentIndex = 0; // Kembali ke awal jika sudah mencapai akhir
    }
    updateSlider();
});

document.getElementById('prev').addEventListener('click', () => {
    if (currentIndex > 0) {
        currentIndex--;
    } else {
        currentIndex = totalSlides - slidesToShow; // Pindah ke akhir jika sudah di awal
    }
    updateSlider();
});

function updateSlider() {
    const slider = document.querySelector('.image-slider');
    slider.style.transform = `translateX(-${currentIndex * slideWidth}px)`;
}