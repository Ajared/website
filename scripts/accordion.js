// === ACCORDION ===
function toggleCap(index) {
    const detail = document.getElementById('detail-' + index);
    const toggle = document.getElementById('toggle-' + index);
    const isOpening = !detail.classList.contains('open');

    // Close all others, show their teasers if something is opening
    document.querySelectorAll('.capability-detail').forEach((d, i) => {
        if (i !== index) {
            d.classList.remove('open');
            const otherToggle = document.getElementById('toggle-' + i);
            if (otherToggle) {
                otherToggle.classList.remove('open');
                otherToggle.textContent = '+';
            }
        }
    });

    detail.classList.toggle('open');
    toggle.classList.toggle('open');
    toggle.textContent = isOpening ? '×' : '+';
}

document.addEventListener('DOMContentLoaded', () => {
    // === HOVER PEEK ===
    document.querySelectorAll('.capability-header').forEach((header, i) => {
        header.addEventListener('mouseenter', () => {
            const detail = document.getElementById('detail-' + i);
            if (detail && !detail.classList.contains('open')) {
                const peek = document.getElementById('peek-' + i);
                if (peek) peek.classList.add('show');
            }
        });
        header.addEventListener('mouseleave', () => {
            const peek = document.getElementById('peek-' + i);
            if (peek) peek.classList.remove('show');
        });
    });
});
