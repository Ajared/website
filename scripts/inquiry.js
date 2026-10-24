document.addEventListener('DOMContentLoaded', () => {
    const dialog = document.getElementById('inquire');
    if (!dialog || typeof dialog.showModal !== 'function') return;

    const form = document.getElementById('inquiry-form');
    const status = document.getElementById('inquiry-status');
    const submitBtn = document.getElementById('inquiry-submit');
    const re = document.getElementById('inquiry-re');
    const serviceInput = document.getElementById('inquiry-service');
    const deliverableField = document.getElementById('inquiry-deliverable-field');
    const deliverableSelect = document.getElementById('inquiry-deliverable');
    const scopeLabel = document.getElementById('inquiry-scope-label');
    let opener = null;

    // Service-specific deliverables mapping
    const deliverables = {
        'Product Development & Management': ['UX & Market Research', 'Testing Business Ideas', 'Product Strategy', 'Roadmap', 'Model Selection & Integration', 'Launch', 'Product Analytics'],
        'Enterprise AI Agents': ['AI Agents', 'Task Automation', 'Multi-Agent Coordination', 'RAG Pipelines', 'Production LLM Ops'],
        'Data & AI Strategy': ['Data Audit', 'Readiness Assessment', 'Knowledge Graph', 'Governance', 'GEO (Generative Engine Optimization)']
    };

    function setService(service) {
        serviceInput.value = service || '';
        re.textContent = service ? '/ ' + service : '';
        deliverableSelect.length = 1;
        const list = deliverables[service];
        if (list) {
            list.forEach(d => deliverableSelect.add(new Option(d, d)));
        }
        deliverableField.hidden = !list;
        scopeLabel.textContent = (list ? '04' : '03') + ' / Project Scope / Brief';
    }

    function open(service) {
        setService(service);
        document.getElementById('inquiry-page').value = location.href.split('#')[0];
        status.style.display = 'none';
        if (!dialog.open) dialog.showModal();
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

    // Deep links: /#inquire or ?service=Applied%20Research#inquire
    const openFromHash = () => {
        if (location.hash === '#inquire') open(new URLSearchParams(location.search).get('service'));
    };
    openFromHash();
    window.addEventListener('hashchange', openFromHash);

    document.getElementById('inquiry-close').addEventListener('click', () => dialog.close());

    // Click on the backdrop closes
    dialog.addEventListener('click', (e) => {
        if (e.target !== dialog) return;
        const r = dialog.getBoundingClientRect();
        const inside = e.clientX >= r.left && e.clientX <= r.right && e.clientY >= r.top && e.clientY <= r.bottom;
        if (!inside) dialog.close();
    });

    dialog.addEventListener('close', () => {
        if (location.hash === '#inquire') {
            history.replaceState(null, '', location.pathname + location.search);
        }
        if (opener) opener.focus();
        opener = null;
    });

    // Mirror email into hidden _replyto so Formspree sets reply-to correctly
    form.querySelector('[name="email"]').addEventListener('input', function () {
        form.querySelector('[name="_replyto"]').value = this.value;
    });

    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        submitBtn.disabled = true;
        submitBtn.textContent = 'Sending...';
        status.style.display = 'none';

        try {
            const response = await fetch(form.action, {
                method: 'POST',
                body: new FormData(form),
                headers: { 'Accept': 'application/json' }
            });

            if (response.ok) {
                status.style.display = 'block';
                status.style.color = 'var(--color-ink-dark)';
                status.textContent = '✓ Message received — we will respond within 48–72 hours.';
                if (window.dataLayer) window.dataLayer.push({ event: 'inquiry_submit', inquiry_service: serviceInput.value });
                const service = serviceInput.value;
                form.reset();
                setService(service);
            } else {
                const data = await response.json();
                throw new Error(data.errors ? data.errors.map(e => e.message).join(', ') : 'Submission failed.');
            }
        } catch (err) {
            status.style.display = 'block';
            status.style.color = '#a1665e';
            status.innerHTML = '✗ ' + err.message + ' Please email <a href="mailto:innovation@ajared.ca" style="color: inherit; text-decoration: underline;">innovation@ajared.ca</a> directly.';
        }
        submitBtn.textContent = 'Send Message ↗';
        submitBtn.disabled = false;
    });
});
