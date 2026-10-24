// Collaboration pill shrinks to its pyramid once the page scrolls
(() => {
    const root = document.documentElement;
    let ticking = false;
    const update = () => { root.classList.toggle('is-scrolled', window.scrollY > 60); ticking = false; };
    window.addEventListener('scroll', () => {
        if (!ticking) { ticking = true; requestAnimationFrame(update); }
    }, { passive: true });
    update();
})();
