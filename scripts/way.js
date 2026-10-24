// The Ajared Way: the highlighted step moves at random, since you can start at any step
document.addEventListener('DOMContentLoaded', () => {
    const steps = [...document.querySelectorAll('.way-track li')];
    if (steps.length < 2) return;
    let current = steps.findIndex(s => s.classList.contains('is-active'));

    const show = (i) => {
        steps.forEach((s, j) => s.classList.toggle('is-active', j === i));
        current = i;
    };
    const pickOther = () => {
        let i;
        do { i = Math.floor(Math.random() * steps.length); } while (i === current);
        return i;
    };

    show(pickOther());
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;

    let timer = null;
    const start = () => { if (!timer) timer = setInterval(() => show(pickOther()), 2200); };
    const stop = () => { clearInterval(timer); timer = null; };

    // Only animate while the track is on screen
    new IntersectionObserver(([entry]) => (entry.isIntersecting ? start() : stop()))
        .observe(document.querySelector('.way-track'));
});
