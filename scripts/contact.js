document.addEventListener('DOMContentLoaded', () => {
    // Service-specific deliverables mapping
    const deliverables = {
        'Applied Research': ['UX Research', 'Market Research', 'Experimental Design', 'Meta-Analysis'],
        'AI Product Development': ['Product Strategy', 'Roadmap', 'Model Selection & Integration', 'Launch', 'Product Analytics'],
        'Enterprise AI Agents': ['AI Agents', 'Task Automation', 'Multi-Agent Coordination', 'RAG Pipelines', 'Production LLM Ops'],
        'Data & AI Strategy': ['Data Audit', 'Readiness Assessment', 'Knowledge Graph', 'Governance', 'GEO (Generative Engine Optimization)']
    };

    // Read URL parameter and populate form
    const urlParams = new URLSearchParams(window.location.search);
    const service = urlParams.get('service');
    const deliverableSelect = document.getElementById('deliverable-select');

    if (service && deliverables[service] && deliverableSelect) {
        // Populate dropdown with deliverables and show the field
        deliverables[service].forEach(deliverable => {
            const option = document.createElement('option');
            option.value = deliverable;
            option.textContent = deliverable;
            deliverableSelect.appendChild(option);
        });
        document.getElementById('deliverable-field').style.display = 'block';
        document.getElementById('scope-label').textContent = '04 / Project Scope / Brief';
    }

    const map = document.getElementById('coord-map');
    const display = document.getElementById('coord-display');
    const chV = document.getElementById('ch-v');
    const chH = document.getElementById('ch-h');

    if (map) {
        map.addEventListener('mousemove', (e) => {
            const rect = map.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;

            const lat = ((y / rect.height) * 180 - 90).toFixed(4);
            const long = ((x / rect.width) * 360 - 180).toFixed(4);

            chV.style.left = x + 'px';
            chH.style.top = y + 'px';

            display.innerText = `LAT: ${lat} / LONG: ${long}`;
        });
    }

    const form = document.getElementById('commission-form');
    const status = document.getElementById('form-status');
    const submitBtn = document.getElementById('submit-btn');

    if (form) {
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
                    form.reset();
                    submitBtn.textContent = 'Send Message ↗';
                    submitBtn.disabled = false;
                } else {
                    const data = await response.json();
                    throw new Error(data.errors ? data.errors.map(e => e.message).join(', ') : 'Submission failed.');
                }
            } catch (err) {
                status.style.display = 'block';
                status.style.color = '#a1665e';
                status.innerHTML = '✗ ' + err.message + ' Please email <a href="mailto:innovation@ajared.ca" style="color: inherit; text-decoration: underline;">innovation@ajared.ca</a> directly.';
                submitBtn.textContent = 'Send Message ↗';
                submitBtn.disabled = false;
            }
        });
    }
});
