document.addEventListener('DOMContentLoaded', () => {
    const dialog = document.getElementById('inquire');
    if (!dialog || typeof dialog.showModal !== 'function') return;

    const form = document.getElementById('inquiry-form');
    const done = document.getElementById('inquiry-done');
    const status = document.getElementById('inquiry-status');
    const submitBtn = document.getElementById('inquiry-submit');
    const re = document.getElementById('inquiry-re');
    const topic = document.getElementById('inquiry-topic');
    const chips = [...form.querySelectorAll('input[name="service"]')];
    let opener = null;
    dialog.tabIndex = -1;

    // A link's data-service either selects a matching chip or is shown as the topic
    function setService(service) {
        chips.forEach(c => { c.checked = false; });
        const chip = chips.find(c => c.value === service);
        if (chip) chip.checked = true;
        topic.value = service && !chip ? service : '';
        re.textContent = topic.value;
    }

    function open(service) {
        form.hidden = false;
        done.hidden = true;
        status.hidden = true;
        setService(service);
        document.getElementById('inquiry-page').value = location.href.split('#')[0];
        if (!dialog.open) { dialog.showModal(); dialog.focus(); }
        if (window.dataLayer) window.dataLayer.push({ event: 'inquiry_open', inquiry_service: service || '' });
    }

    // Any link to #inquire opens the dialog in place
    document.addEventListener('click', (e) => {
        const link = e.target.closest('a[href="#inquire"]');
        if (!link) return;
        e.preventDefault();
        opener = link;
        open(link.dataset.service);
    });

    // Deep links: /#inquire or ?service=Enterprise%20AI%20Agents#inquire
    const openFromHash = () => {
        if (location.hash === '#inquire') open(new URLSearchParams(location.search).get('service'));
    };
    openFromHash();
    window.addEventListener('hashchange', openFromHash);

    document.getElementById('inquiry-close').addEventListener('click', () => dialog.close());
    dialog.addEventListener('click', (e) => {
        if (e.target.closest('[data-close]')) { dialog.close(); return; }
        if (e.target !== dialog) return;
        // Click on the backdrop closes
        const r = dialog.getBoundingClientRect();
        const inside = e.clientX >= r.left && e.clientX <= r.right && e.clientY >= r.top && e.clientY <= r.bottom;
        if (!inside) dialog.close();
    });

    dialog.addEventListener('close', () => {
        if (location.hash === '#inquire') history.replaceState(null, '', location.pathname + location.search);
        if (opener) opener.focus();
        opener = null;
    });

    // Mirror email into hidden _replyto so Formspree sets reply-to correctly
    form.elements.email.addEventListener('input', function () {
        form.elements._replyto.value = this.value;
    });
    form.querySelectorAll('[required]').forEach(i => i.addEventListener('input', () => i.removeAttribute('aria-invalid')));

    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        const invalid = [...form.querySelectorAll('[required]')].filter(i => !i.checkValidity());
        invalid.forEach(i => i.setAttribute('aria-invalid', 'true'));
        if (invalid.length) { invalid[0].reportValidity(); return; }

        submitBtn.disabled = true;
        submitBtn.textContent = 'Sending...';
        status.hidden = true;

        try {
            const response = await fetch(form.action, {
                method: 'POST',
                body: new FormData(form),
                headers: { 'Accept': 'application/json' }
            });
            if (!response.ok) {
                const data = await response.json().catch(() => ({}));
                throw new Error(data.errors ? data.errors.map(x => x.message).join(', ') : 'Submission failed.');
            }
            const first = form.elements.name.value.trim().split(/\s+/)[0];
            document.getElementById('inquiry-done-name').textContent = first ? ', ' + first : '';
            if (window.dataLayer) window.dataLayer.push({ event: 'inquiry_submit', inquiry_service: (chips.find(c => c.checked) || {}).value || topic.value });
            form.reset();
            form.hidden = true;
            done.hidden = false;
            done.querySelector('[data-close]').focus();
        } catch (err) {
            status.hidden = false;
            status.textContent = '';
            status.append(err.message + ' Please email ');
            const mail = document.createElement('a');
            mail.href = 'mailto:innovation@ajared.ca';
            mail.textContent = 'innovation@ajared.ca';
            status.append(mail, ' directly.');
        }
        submitBtn.textContent = 'Send inquiry ↗';
        submitBtn.disabled = false;
    });
});
