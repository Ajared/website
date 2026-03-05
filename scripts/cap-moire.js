document.addEventListener('DOMContentLoaded', () => {
    // === HERO TRIANGLE MOIRÉ ===
    const canvas = document.getElementById('moireCanvas');
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    let mouseX = 0.5, mouseY = 0.5;

    function resizeCanvas() {
        const c = canvas.parentElement;
        canvas.width = c.offsetWidth * 2;
        canvas.height = c.offsetHeight * 2;
        canvas.style.width = c.offsetWidth + 'px';
        canvas.style.height = c.offsetHeight + 'px';
        ctx.scale(2, 2);
    }

    function drawTriangleOn(c, cx, cy, size, rotation) {
        c.save();
        c.translate(cx, cy);
        c.rotate(rotation);
        c.beginPath();
        c.moveTo(size * 0.5, -size * 0.5);
        c.lineTo(-size * 0.5, 0);
        c.lineTo(size * 0.5, size * 0.5);
        c.closePath();
        c.restore();
    }

    function drawLayerOn(c, ox, oy, maxR, step, rot, alpha, color) {
        c.strokeStyle = color ? `rgba(${color}, ${alpha})` : `rgba(5, 140, 140, ${alpha})`;
        c.lineWidth = 1.5;
        for (let r = step; r < maxR; r += step) {
            drawTriangleOn(c, ox, oy, r, rot);
            c.stroke();
        }
    }

    function render() {
        const w = canvas.width / 2;
        const h = canvas.height / 2;
        ctx.clearRect(0, 0, w, h);
        const ox = (mouseX - 0.5) * 50;
        const oy = (mouseY - 0.5) * 50;
        const maxDim = Math.max(w, h) * 2;
        drawLayerOn(ctx, w * 0.48 + ox, h * 0.48 + oy, maxDim, 26, 0, 0.4);
        drawLayerOn(ctx, w * 0.52 - ox, h * 0.52 - oy, maxDim, 26, Math.PI * 0.018, 0.25);
        drawLayerOn(ctx, w * 0.5 + ox * 0.4, h * 0.45 + oy * 0.4, maxDim * 0.8, 34, -Math.PI * 0.01, 0.12);
        drawLayerOn(ctx, w * 0.5 - ox * 0.3, h * 0.52 + oy * 0.3, maxDim * 0.75, 30, Math.PI * 0.03, 0.07, '161, 102, 94');
        requestAnimationFrame(render);
    }

    document.addEventListener('mousemove', (e) => {
        mouseX = e.clientX / window.innerWidth;
        mouseY = e.clientY / window.innerHeight;
    });
    window.addEventListener('resize', resizeCanvas);
    resizeCanvas();
    render();
});
