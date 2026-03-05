document.addEventListener('DOMContentLoaded', () => {
    const container = document.getElementById('moire');
    if (!container) return;

    function createRipple(cx, cy, maxRadius, step, className) {
        for (let r = 0; r < maxRadius; r += step) {
            const circle = document.createElement('div');
            circle.classList.add(className);
            circle.style.width = (r * 2) + 'px';
            circle.style.height = (r * 2) + 'px';
            container.appendChild(circle);
        }
    }

    createRipple(30, 50, 1500, 25, 'ripple-center');
    createRipple(80, 20, 1500, 25, 'ripple-secondary');

    document.addEventListener('mousemove', (e) => {
        const x = e.clientX / window.innerWidth;
        const y = e.clientY / window.innerHeight;

        document.querySelectorAll('.ripple-center').forEach(c => {
            c.style.transform = `translate(-50%, -50%) translate(${x * 20}px, ${y * 20}px)`;
        });

        document.querySelectorAll('.ripple-secondary').forEach(c => {
            c.style.transform = `translate(-50%, -50%) translate(${-x * 20}px, ${-y * 20}px)`;
        });
    });
});
