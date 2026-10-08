document.addEventListener('DOMContentLoaded', () => {
    const hero = document.getElementById('hero-carousel');
    if (!hero) return;

    const tabs = Array.from(hero.querySelectorAll('.hero-tab'));
    const slides = Array.from(hero.querySelectorAll('.hero-slide'));
    const themes = slides.map(s => 'th-' + s.dataset.theme);
    const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    let current = 0;

    function show(index, moveFocus) {
        current = (index + slides.length) % slides.length;
        tabs.forEach((tab, i) => {
            const on = i === current;
            tab.setAttribute('aria-selected', on ? 'true' : 'false');
            tab.tabIndex = on ? 0 : -1;
        });
        slides.forEach((slide, i) => {
            const on = i === current;
            slide.classList.toggle('is-active', on);
            if (on) slide.removeAttribute('aria-hidden');
            else slide.setAttribute('aria-hidden', 'true');
        });
        hero.classList.remove(...themes);
        hero.classList.add(themes[current]);
        hero.dataset.active = String(current);
        if (moveFocus) tabs[current].focus();
    }

    tabs.forEach((tab, i) => {
        tab.addEventListener('click', () => show(i));
        tab.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowDown' || e.key === 'ArrowRight') { e.preventDefault(); show(current + 1, true); }
            if (e.key === 'ArrowUp' || e.key === 'ArrowLeft') { e.preventDefault(); show(current - 1, true); }
        });
        // The active tab's progress line doubles as the timer: when it fills, advance.
        tab.addEventListener('animationend', () => { if (i === current) show(current + 1); });
    });

    if (!reduceMotion) hero.classList.add('is-auto');

    const pause = (on) => hero.classList.toggle('is-paused', on);
    hero.addEventListener('mouseenter', () => pause(true));
    hero.addEventListener('mouseleave', () => pause(false));
    hero.addEventListener('focusin', () => pause(true));
    hero.addEventListener('focusout', () => pause(false));
});
