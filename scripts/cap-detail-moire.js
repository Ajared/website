document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('heroMoire');
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    let mx = 0.5, my = 0.5;
    const STRENGTH = 32;
    function resize() {
        const r = window.devicePixelRatio || 1, hero = canvas.parentElement;
        const w = hero.offsetWidth, h = hero.offsetHeight;
        canvas.width = w * r; canvas.height = h * r;
        canvas.style.width = w + 'px'; canvas.style.height = h + 'px';
        ctx.setTransform(1, 0, 0, 1, 0, 0); ctx.scale(r, r);
        canvas._w = w; canvas._h = h;
    }
    function draw() {
        const W = canvas._w, H = canvas._h;
        const ax = W * .5 + (mx - .5) * STRENGTH, ay = H * .5 + (my - .5) * STRENGTH;
        const bx = W * .5 - (mx - .5) * STRENGTH, by = H * .5 - (my - .5) * STRENGTH;
        ctx.clearRect(0, 0, W, H); ctx.lineWidth = 0.6;
        const step = 28, max = Math.hypot(W, H) * .9;
        function tri(cx, cy, r, c) { ctx.strokeStyle = c; ctx.beginPath(); for (let i = 0; i < 3; i++) { const a = (i * 2 * Math.PI / 3) - Math.PI / 2; i === 0 ? ctx.moveTo(cx + r * Math.cos(a), cy + r * Math.sin(a)) : ctx.lineTo(cx + r * Math.cos(a), cy + r * Math.sin(a)); } ctx.closePath(); ctx.stroke(); }
        for (let s = step; s < max; s += step) { tri(ax, ay, s, 'rgba(140,202,202,0.38)'); tri(bx, by, s, 'rgba(161,102,94,0.28)'); }
    }
    let raf;
    window.addEventListener('mousemove', e => { mx = e.clientX / innerWidth; my = e.clientY / innerHeight; cancelAnimationFrame(raf); raf = requestAnimationFrame(draw); });
    window.addEventListener('resize', () => { resize(); draw(); });
    resize(); draw();
});
