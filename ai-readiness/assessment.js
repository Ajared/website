// ═══════════════════════════════════════
//  QUESTION DATA
// ═══════════════════════════════════════

const questions = [
  {
    id: "experience",
    label: "What is your experience with AI?",
    options: [
      { id: "chatgpt", text: "I've used ChatGPT or similar chatbots" },
      { id: "other_ai", text: "I've used other AI tools (image gen, transcription, etc.)" },
      { id: "paying", text: "I pay monthly for an AI subscription" },
      { id: "terminal", text: "I use AI in a terminal, IDE, or code editor" },
      { id: "none", text: "I haven't really used AI yet" }
    ],
    max: 3
  },
  {
    id: "goals",
    label: "What are your AI goals?",
    options: [
      { id: "understand", text: "Understand what's actually possible with AI" },
      { id: "plan", text: "Use AI to plan and organize my life and work" },
      { id: "pull_info", text: "Find and pull useful info from my documents & files" },
      { id: "organize", text: "Organize my digital collections or archives" },
      { id: "connect_apps", text: "Connect AI to my apps and automate tasks" },
      { id: "tasks_better", text: "Do specific work tasks better with AI" },
      { id: "new_things", text: "Do things I couldn't even begin to do before" }
    ],
    max: 3
  },
  {
    id: "learning_style",
    label: "How do you prefer to learn?",
    options: [
      { id: "self_taught", text: "Self-taught — give me docs and I'll figure it out" },
      { id: "projects", text: "Hands-on projects — learn by building" },
      { id: "classroom", text: "Classroom style — structured courses & curriculum" },
      { id: "tutor", text: "Personal tutor — 1-on-1 guidance" },
      { id: "av", text: "Audio-visual — videos, podcasts, demos" }
    ],
    max: 2
  },
  {
    id: "concerns",
    label: "What's your biggest concern about AI?",
    options: [
      { id: "keeping_up", text: "Keeping up with how fast things are changing" },
      { id: "costs", text: "The cost of AI tools and subscriptions" },
      { id: "job_loss", text: "AI replacing my job or making my skills obsolete" },
      { id: "slop", text: "AI-generated slop everywhere — low quality content" },
      { id: "privacy", text: "Privacy and data security" }
    ],
    max: 1
  },
  {
    id: "staying_updated",
    label: "How do you currently stay updated on AI?",
    options: [
      { id: "social", text: "Social media — X, LinkedIn, Reddit" },
      { id: "youtube", text: "YouTube channels and podcasts" },
      { id: "newsletters", text: "Newsletters and blogs" },
      { id: "colleagues", text: "Friends, colleagues, or communities" },
      { id: "dont_keep_up", text: "I don't really keep up" }
    ],
    max: 2
  },
  {
    id: "tried_failed",
    label: "What have you tried with AI that didn't work?",
    options: [
      { id: "generic_output", text: "Got generic or unusable outputs" },
      { id: "too_complex", text: "Tools were too complex to set up" },
      { id: "no_integration", text: "Couldn't integrate AI into my actual workflow" },
      { id: "trust_issues", text: "Couldn't trust the accuracy of AI results" },
      { id: "nothing_yet", text: "Haven't tried much yet" }
    ],
    max: 2
  },
  {
    id: "repetitive_tasks",
    label: "How do you currently handle repetitive tasks?",
    options: [
      { id: "manual", text: "Manually — I just do them every time" },
      { id: "templates", text: "Templates and checklists" },
      { id: "basic_automation", text: "Basic automation (Zapier, macros, scripts)" },
      { id: "delegate", text: "Delegate to others on my team" },
      { id: "ignore", text: "I avoid or skip them when possible" }
    ],
    max: 1
  },
  {
    id: "industry",
    label: "What best describes your field?",
    options: [
      { id: "tech", text: "Technology / Software / IT" },
      { id: "business", text: "Business / Consulting / Finance" },
      { id: "creative", text: "Creative / Media / Marketing" },
      { id: "education", text: "Education / Research / Non-profit" },
      { id: "government", text: "Government / Public Sector" },
      { id: "other", text: "Other industry" }
    ],
    max: 1
  }
];

// ═══════════════════════════════════════
//  STATE
// ═══════════════════════════════════════

const answers = {};
questions.forEach(q => answers[q.id] = []);

// ═══════════════════════════════════════
//  RENDER QUIZ
// ═══════════════════════════════════════

function renderQuiz() {
  // Progress pips
  const bar = document.getElementById('progress-bar');
  bar.innerHTML = questions.map((_, i) => `<div class="pip" id="pip-${i}"></div>`).join('');

  // Questions
  const container = document.getElementById('questions-container');
  container.innerHTML = questions.map((q, qi) => `
    <div class="question-block">
      <div class="question-header">
        <span class="question-number">0${qi + 1}</span>
        <span class="question-label">${q.label}</span>
        <span class="question-hint">${q.max === 1 ? 'Pick one' : 'Pick up to ' + q.max}</span>
      </div>
      <div class="options-list" id="options-${q.id}">
        ${q.options.map(opt => `
          <button class="option-btn" data-qid="${q.id}" data-oid="${opt.id}" onclick="toggleOption('${q.id}','${opt.id}',${q.max})">
            <div class="checkbox${q.max === 1 ? ' radio' : ''}">
              <svg width="12" height="12" viewBox="0 0 12 12">${q.max === 1
                ? '<circle cx="6" cy="6" r="3" fill="#fff"/>'
                : '<path d="M2 6l3 3 5-5" stroke="#fff" stroke-width="2" fill="none" stroke-linecap="round"/>'
              }</svg>
            </div>
            ${opt.text}
          </button>
        `).join('')}
      </div>
    </div>
  `).join('');
}

function toggleOption(qId, optId, max) {
  const arr = answers[qId];
  const idx = arr.indexOf(optId);

  if (idx > -1) {
    arr.splice(idx, 1);
  } else {
    if (max === 1) {
      // Radio behavior — replace selection
      answers[qId] = [optId];
    } else {
      if (arr.length >= max) return;
      arr.push(optId);
    }
  }

  updateUI();
}

function updateUI() {
  // Update option buttons
  questions.forEach(q => {
    const selected = answers[q.id];
    const btns = document.querySelectorAll(`[data-qid="${q.id}"]`);
    btns.forEach(btn => {
      const oid = btn.dataset.oid;
      const isSelected = selected.includes(oid);
      const isDisabled = !isSelected && selected.length >= q.max;

      btn.classList.toggle('selected', isSelected);
      btn.classList.toggle('disabled', isDisabled);
    });
  });

  // Update progress pips
  questions.forEach((q, i) => {
    const pip = document.getElementById(`pip-${i}`);
    pip.classList.toggle('filled', answers[q.id].length > 0);
  });

  // Update submit button
  const allAnswered = questions.every(q => answers[q.id].length > 0);
  const btn = document.getElementById('btn-submit');
  const hint = document.getElementById('submit-hint');
  btn.disabled = !allAnswered;
  hint.style.display = allAnswered ? 'none' : 'block';
}

// ═══════════════════════════════════════
//  SCORING
// ═══════════════════════════════════════

function computeProfile() {
  let exp = 0, amb = 0, aut = 0, awa = 0;

  const a = answers;

  // Experience
  if (a.experience.includes('terminal')) exp += 4;
  if (a.experience.includes('paying')) exp += 3;
  if (a.experience.includes('other_ai')) exp += 2;
  if (a.experience.includes('chatgpt')) exp += 1;

  // Ambition from goals
  if (a.goals.includes('new_things')) amb += 4;
  if (a.goals.includes('connect_apps')) amb += 4;
  if (a.goals.includes('tasks_better')) amb += 3;
  if (a.goals.includes('pull_info')) amb += 2;
  if (a.goals.includes('organize')) amb += 2;
  if (a.goals.includes('plan')) amb += 1;
  if (a.goals.includes('understand')) amb += 1;

  // Autonomy from learning style
  if (a.learning_style.includes('self_taught')) aut += 4;
  if (a.learning_style.includes('projects')) aut += 3;
  if (a.learning_style.includes('av')) aut += 2;
  if (a.learning_style.includes('classroom')) aut += 1;
  if (a.learning_style.includes('tutor')) aut += 1;

  // Awareness from staying updated
  if (a.staying_updated.includes('newsletters')) awa += 3;
  if (a.staying_updated.includes('social')) awa += 2;
  if (a.staying_updated.includes('youtube')) awa += 2;
  if (a.staying_updated.includes('colleagues')) awa += 1;

  // Cross-pollination
  if (a.repetitive_tasks.includes('basic_automation')) exp += 2;
  if (a.repetitive_tasks.includes('templates')) exp += 1;
  if (a.repetitive_tasks.includes('delegate')) aut += 1;
  if (a.tried_failed.includes('nothing_yet')) exp = Math.max(0, exp - 1);
  if (a.tried_failed.includes('no_integration')) amb += 1;
  if (a.tried_failed.includes('generic_output')) awa += 1;

  // maxAwa = 6: newsletters(3) + social/youtube(2) + generic_output cross-bonus(1) = 6 max achievable
  const maxExp = 10, maxAmb = 12, maxAut = 8, maxAwa = 6;

  const dims = {
    experience: Math.max(0, Math.min(100, (exp / maxExp) * 100)),
    ambition: Math.max(0, Math.min(100, (amb / maxAmb) * 100)),
    autonomy: Math.max(0, Math.min(100, (aut / maxAut) * 100)),
    awareness: Math.max(0, Math.min(100, (awa / maxAwa) * 100))
  };

  const overall = (dims.experience + dims.ambition + dims.autonomy + dims.awareness) / 4;

  let level, desc;
  if (overall <= 25) {
    level = 'Explorer';
    desc = "You're at the beginning of your AI journey — curious and open. The right guidance now will save you months of trial and error.";
  } else if (overall <= 50) {
    level = 'Activator';
    desc = "You've dipped your toes in and see the potential. Now it's about building the right habits and workflows to make AI stick.";
  } else if (overall <= 75) {
    level = 'Builder';
    desc = "You're actively using AI and ready to go deeper. The next step is connecting tools, automating workflows, and scaling what works.";
  } else {
    level = 'Catalyst';
    desc = "You're an advanced AI user ready to push boundaries. Focus on integration, custom solutions, and helping others level up.";
  }

  return { dims, overall, level, desc };
}

function getNextSteps(profile) {
  const steps = [];
  const a = answers;

  if (profile.level === 'Explorer') {
    steps.push('Start with one AI tool for a task you do weekly — writing emails, summarizing notes, or brainstorming ideas.');
    if (a.goals.includes('understand')) steps.push('Book a guided intro session to see real demos, not just theory.');
    if (a.concerns.includes('keeping_up')) steps.push('Subscribe to one curated AI newsletter — you don\'t need to follow everything.');
    if (a.concerns.includes('privacy')) steps.push('Learn which AI tools keep your data private — not all of them do.');
  } else if (profile.level === 'Activator') {
    if (a.goals.includes('pull_info')) steps.push('Set up an AI assistant connected to your documents — start with Google Drive or Notion.');
    if (a.goals.includes('plan')) steps.push('Use AI as a weekly planning partner — feed it your goals and let it structure your week.');
    if (a.tried_failed.includes('generic_output')) steps.push('Learn prompt crafting — your results are only as good as your instructions.');
    if (a.concerns.includes('costs')) steps.push('Audit which free AI tools cover your needs before committing to paid plans.');
  } else if (profile.level === 'Builder') {
    if (a.goals.includes('connect_apps')) steps.push('Build your first AI automation — connect your calendar, email, or project tools.');
    if (a.goals.includes('tasks_better')) steps.push('Create custom AI workflows for your top 3 repetitive tasks.');
    if (a.goals.includes('organize')) steps.push('Use AI to tag, categorize, and surface patterns in your digital archives.');
  } else {
    if (a.goals.includes('new_things')) steps.push('Explore agentic AI — tools that can research, plan, and execute multi-step tasks for you.');
    steps.push('Consider building custom AI solutions tailored to your industry and workflow.');
    if (a.goals.includes('connect_apps')) steps.push('Look into MCP (Model Context Protocol) to give AI deep access to your tool ecosystem.');
  }

  if (a.learning_style.includes('tutor') || a.learning_style.includes('classroom')) {
    steps.push('A structured coaching program would accelerate your growth — consider booking a consultation.');
  }

  return steps.slice(0, 3);
}

function getUseCases(profile) {
  const cases = [];
  const a = answers;

  if (a.goals.includes('pull_info')) cases.push({ title: 'Smart Document Search', desc: 'AI that reads your files and answers questions about them' });
  if (a.goals.includes('connect_apps')) cases.push({ title: 'App Automation', desc: 'AI agents that work across your tools — email, calendar, docs' });
  if (a.goals.includes('organize')) cases.push({ title: 'Digital Archive Organizer', desc: 'Auto-tag, sort, and make your file collections searchable' });
  if (a.goals.includes('plan')) cases.push({ title: 'AI Planning Assistant', desc: 'Weekly planning, goal tracking, and priority management' });
  if (a.goals.includes('tasks_better')) cases.push({ title: 'Workflow Optimizer', desc: 'AI handles the repetitive parts so you focus on the creative work' });
  if (a.goals.includes('new_things')) cases.push({ title: 'AI-Powered Research', desc: 'Deep research, analysis, and insight generation at scale' });
  if (a.repetitive_tasks.includes('manual')) cases.push({ title: 'Task Automation Starter', desc: 'Turn your most repetitive manual tasks into one-click AI workflows' });
  if (a.industry.includes('creative')) cases.push({ title: 'Creative Co-Pilot', desc: 'AI for drafting, editing, brainstorming, and content strategy' });
  if (a.industry.includes('business')) cases.push({ title: 'Business Intelligence Agent', desc: 'AI that monitors metrics, generates reports, and spots trends' });
  if (a.industry.includes('education')) cases.push({ title: 'Knowledge Graph Builder', desc: 'AI that connects and maps information across your research' });

  return cases.slice(0, 3);
}

// ═══════════════════════════════════════
//  RADAR CHART (SVG)
// ═══════════════════════════════════════

function renderRadar(dims) {
  const labels = [
    { key: 'experience', label: 'Experience' },
    { key: 'ambition', label: 'Ambition' },
    { key: 'autonomy', label: 'Autonomy' },
    { key: 'awareness', label: 'Awareness' }
  ];
  const cx = 150, cy = 150, r = 110, n = 4;
  const step = 360 / n;

  function polar(angle, radius) {
    const a = (angle - 90) * Math.PI / 180;
    return { x: cx + radius * Math.cos(a), y: cy + radius * Math.sin(a) };
  }

  function ring(scale) {
    return labels.map((_, i) => {
      const p = polar(i * step, r * scale);
      return `${p.x},${p.y}`;
    }).join(' ');
  }

  const dataPoints = labels.map((l, i) => polar(i * step, r * (dims[l.key] / 100)));
  const dataPath = dataPoints.map((p, i) => `${i === 0 ? 'M' : 'L'}${p.x},${p.y}`).join(' ') + ' Z';

  let svg = `<svg viewBox="0 0 300 300">`;

  // Grid rings
  [0.25, 0.5, 0.75, 1].forEach(s => {
    svg += `<polygon points="${ring(s)}" fill="none" stroke="#A0A0A0" stroke-width="0.5" opacity="0.3"/>`;
  });

  // Axes
  labels.forEach((_, i) => {
    const p = polar(i * step, r);
    svg += `<line x1="${cx}" y1="${cy}" x2="${p.x}" y2="${p.y}" stroke="#A0A0A0" stroke-width="0.5" opacity="0.25"/>`;
  });

  // Data shape
  svg += `<polygon points="${dataPoints.map(p => `${p.x},${p.y}`).join(' ')}" fill="rgba(5,140,140,0.15)" stroke="#058c8c" stroke-width="2.5"/>`;

  // Data dots
  dataPoints.forEach(p => {
    svg += `<circle cx="${p.x}" cy="${p.y}" r="5" fill="#058c8c" stroke="#fff" stroke-width="2"/>`;
  });

  // Labels
  labels.forEach((l, i) => {
    const p = polar(i * step, r + 24);
    svg += `<text x="${p.x}" y="${p.y}" text-anchor="middle" dominant-baseline="middle" style="font-size:12px;font-family:'iA Writer Quattro S','Helvetica Neue',Helvetica,Arial,sans-serif;fill:#323232;font-weight:700;letter-spacing:-0.02em">${l.label}</text>`;
  });

  svg += `</svg>`;
  return svg;
}

// ═══════════════════════════════════════
//  NAVIGATION
// ═══════════════════════════════════════

function showLeadCapture() {
  document.getElementById('quiz-section').style.display = 'none';
  document.getElementById('lead-section').classList.add('active');

  // Pre-fill hidden fields
  const profile = computeProfile();
  document.getElementById('hidden-level').value = profile.level;
  document.getElementById('hidden-score').value = Math.round(profile.overall);
  document.getElementById('hidden-answers').value = JSON.stringify(answers);

  window.scrollTo({ top: 0, behavior: 'smooth' });
}

function showResults(name) {
  document.getElementById('lead-section').classList.remove('active');
  document.getElementById('results-section').classList.add('active');

  const profile = computeProfile();
  const steps = getNextSteps(profile);
  const cases = getUseCases(profile);

  const levelColors = { Explorer: '#a1665e', Activator: '#8ccaca', Builder: '#046363', Catalyst: '#058c8c' };

  // Level badge
  const badge = document.getElementById('level-badge');
  badge.textContent = profile.level;
  badge.style.background = levelColors[profile.level] + '18';
  badge.style.border = `2px solid ${levelColors[profile.level]}`;
  badge.style.color = levelColors[profile.level];

  document.getElementById('level-score').textContent = Math.round(profile.overall) + '%';
  document.getElementById('level-desc').textContent = profile.desc;

  // Radar
  document.getElementById('radar-container').innerHTML = renderRadar(profile.dims);

  // Dimension bars
  const dimBars = document.getElementById('dim-bars');
  dimBars.innerHTML = Object.entries(profile.dims).map(([key, val]) => `
    <div class="dim-bar-item">
      <div class="dim-bar-track"><div class="dim-bar-fill" style="width:${val}%"></div></div>
      <span class="dim-bar-label">${key}</span>
      <span class="dim-bar-value">${Math.round(val)}%</span>
    </div>
  `).join('');

  // Next steps
  document.getElementById('next-steps').innerHTML = steps.map((s, i) => `
    <div class="step-item">
      <div class="step-number">${i + 1}</div>
      <div class="step-text">${s}</div>
    </div>
  `).join('');

  // Use cases
  const dotColors = ['#a1665e', '#046363', '#058c8c'];
  if (cases.length > 0) {
    document.getElementById('usecases-card').style.display = 'block';
    document.getElementById('usecases').innerHTML = cases.map((uc, i) => `
      <div class="usecase-item">
        <div class="usecase-dot" style="background:${dotColors[i % 3]}"></div>
        <div>
          <div class="usecase-title">${uc.title}</div>
          <div class="usecase-desc">${uc.desc}</div>
        </div>
      </div>
    `).join('');
  }

  // Build share card once fonts are ready
  buildShareCard(profile, name);

  window.scrollTo({ top: 0, behavior: 'smooth' });
}

function retake() {
  questions.forEach(q => answers[q.id] = []);
  document.getElementById('results-section').classList.remove('active');
  document.getElementById('quiz-section').style.display = 'block';
  document.getElementById('usecases-card').style.display = 'none';
  updateUI();
  window.scrollTo({ top: 0, behavior: 'smooth' });
}

// ═══════════════════════════════════════
//  SHARE CARD
// ═══════════════════════════════════════

let _shareProfile = null;

function buildShareCard(profile, name) {
  _shareProfile = profile;
  const canvas = document.getElementById('share-canvas');
  if (!canvas) return;

  const W = 1200, H = 628;
  canvas.width = W;
  canvas.height = H;

  const levelColors = { Explorer: '#a1665e', Activator: '#8ccaca', Builder: '#046363', Catalyst: '#058c8c' };
  const accent = levelColors[profile.level] || '#058c8c';

  const logo = new Image();
  logo.crossOrigin = 'anonymous';
  const finish = (img) => {
    document.fonts.ready.then(() => _drawShareCard(canvas.getContext('2d'), W, H, profile, img, accent));
  };
  logo.onload  = () => finish(logo);
  logo.onerror = () => finish(null);
  logo.src = '/logo.png';
}

function _radarVerts(cx, cy, r, n) {
  const pts = [];
  for (let i = 0; i < n; i++) {
    const a = (i * 2 * Math.PI / n) - Math.PI / 2;
    pts.push({ x: cx + r * Math.cos(a), y: cy + r * Math.sin(a) });
  }
  return pts;
}

function _wrapText(ctx, text, x, y, maxW, lineH) {
  const words = text.split(' ');
  let line = '';
  for (let i = 0; i < words.length; i++) {
    const test = line + words[i] + ' ';
    if (ctx.measureText(test).width > maxW && i > 0) {
      ctx.fillText(line.trim(), x, y);
      line = words[i] + ' ';
      y += lineH;
    } else { line = test; }
  }
  ctx.fillText(line.trim(), x, y);
}

function _drawShareCard(ctx, W, H, profile, logo, accent) {
  const pad = 56;

  // ── background ──
  ctx.fillStyle = '#023b3b';
  ctx.fillRect(0, 0, W, H);

  // ── moire echo rings (top-right) ──
  ctx.save();
  const rcx = W * 0.76, rcy = H * 0.22;
  [300, 220, 155, 95, 48].forEach((r, i) => {
    ctx.beginPath();
    ctx.arc(rcx, rcy, r, 0, Math.PI * 2);
    ctx.strokeStyle = `rgba(140,202,202,${0.13 - i * 0.02})`;
    ctx.lineWidth = 1;
    ctx.stroke();
  });
  // cross-hairs through ring centre
  [[rcx - 360, rcy, rcx + 80, rcy], [rcx, rcy - 360, rcx, rcy + 200]].forEach(([x1,y1,x2,y2]) => {
    ctx.beginPath(); ctx.moveTo(x1,y1); ctx.lineTo(x2,y2);
    ctx.strokeStyle = 'rgba(140,202,202,0.05)'; ctx.lineWidth = 1; ctx.stroke();
  });
  ctx.restore();

  // ── left accent bar ──
  ctx.fillStyle = accent;
  ctx.fillRect(0, 0, 4, H);

  // ── logo (white tint) ──
  if (logo) {
    const lh = 34;
    const lw = Math.round(logo.naturalWidth / logo.naturalHeight * lh);
    const tmp = document.createElement('canvas');
    tmp.width = lw; tmp.height = lh;
    const tc = tmp.getContext('2d');
    tc.drawImage(logo, 0, 0, lw, lh);
    tc.globalCompositeOperation = 'source-in';
    tc.fillStyle = 'rgba(255,255,255,0.88)';
    tc.fillRect(0, 0, lw, lh);
    ctx.drawImage(tmp, pad, pad, lw, lh);
  }

  // ── eyebrow ──
  ctx.font = '400 18px "iA Writer Quattro S","Courier New",monospace';
  ctx.fillStyle = 'rgba(140,202,202,0.65)';
  ctx.fillText('AI  READINESS  NAVIGATOR', pad, 168);

  // ── level name ──
  ctx.font = 'bold 108px "iA Writer Quattro S","Helvetica Neue",Arial,sans-serif';
  ctx.fillStyle = '#ffffff';
  ctx.fillText(profile.level.toUpperCase(), pad, 295);

  // ── score ──
  ctx.font = '400 26px "iA Writer Quattro S","Courier New",monospace';
  ctx.fillStyle = 'rgba(140,202,202,0.85)';
  ctx.fillText(Math.round(profile.overall) + '%  ·  AI Readiness Score', pad, 344);

  // ── description ──
  ctx.font = '400 21px "iA Writer Quattro S","Helvetica Neue",Arial,sans-serif';
  ctx.fillStyle = 'rgba(255,255,255,0.52)';
  _wrapText(ctx, profile.desc, pad, 405, W * 0.52, 34);

  // ── separator ──
  ctx.beginPath(); ctx.moveTo(pad, H - 82); ctx.lineTo(W - pad, H - 82);
  ctx.strokeStyle = 'rgba(140,202,202,0.14)'; ctx.lineWidth = 1; ctx.stroke();

  // ── URL ──
  ctx.font = '400 19px "iA Writer Quattro S","Courier New",monospace';
  ctx.fillStyle = 'rgba(140,202,202,0.48)';
  ctx.fillText('ajared.ca/ai-readiness/', pad, H - 50);

  // ── mini radar ──
  const rx = W - 190, ry = H / 2 + 50, rr = 130;
  const keys = Object.keys(profile.dims);
  const n = keys.length;

  // rings
  [0.25, 0.5, 0.75, 1.0].forEach(s => {
    const pts = _radarVerts(rx, ry, rr * s, n);
    ctx.beginPath();
    pts.forEach((p, i) => i === 0 ? ctx.moveTo(p.x, p.y) : ctx.lineTo(p.x, p.y));
    ctx.closePath();
    ctx.strokeStyle = 'rgba(140,202,202,0.12)'; ctx.lineWidth = 1; ctx.stroke();
  });
  // spokes
  _radarVerts(rx, ry, rr, n).forEach(p => {
    ctx.beginPath(); ctx.moveTo(rx, ry); ctx.lineTo(p.x, p.y);
    ctx.strokeStyle = 'rgba(140,202,202,0.1)'; ctx.lineWidth = 1; ctx.stroke();
  });
  // data poly
  ctx.beginPath();
  keys.forEach((k, i) => {
    const a = (i * 2 * Math.PI / n) - Math.PI / 2;
    const v = profile.dims[k] / 100;
    const px = rx + rr * v * Math.cos(a), py = ry + rr * v * Math.sin(a);
    i === 0 ? ctx.moveTo(px, py) : ctx.lineTo(px, py);
  });
  ctx.closePath();
  ctx.fillStyle = accent + '2e'; ctx.fill();
  ctx.strokeStyle = 'rgba(140,202,202,0.75)'; ctx.lineWidth = 2; ctx.stroke();

  // dim labels
  ctx.font = '400 13px "iA Writer Quattro S","Courier New",monospace';
  ctx.fillStyle = 'rgba(140,202,202,0.45)';
  _radarVerts(rx, ry, rr + 20, n).forEach((p, i) => {
    const label = keys[i].substring(0, 3).toUpperCase();
    const tw = ctx.measureText(label).width;
    ctx.fillText(label, p.x - tw / 2, p.y + (p.y < ry ? -6 : 18));
  });
}

// ── share button handlers ──

// Get canvas as a File for Web Share API
function _canvasToFile(filename) {
  return new Promise((resolve, reject) => {
    const canvas = document.getElementById('share-canvas');
    if (!canvas) return reject('no canvas');
    canvas.toBlob(blob => {
      if (!blob) return reject('no blob');
      resolve(new File([blob], filename, { type: 'image/png' }));
    }, 'image/png');
  });
}

function shareLinkedIn() {
  const assessUrl  = 'https://ajared.ca/ai-readiness/';
  const shareText  = _shareProfile
    ? 'I just took the Ajared AI Readiness Navigator — I\'m a ' + _shareProfile.level +
      ' at ' + Math.round(_shareProfile.overall) + '% readiness. Find out where your organization stands.'
    : 'Find out your AI readiness level with the Ajared AI Readiness Navigator.';

  // Mobile: Web Share API with image file
  if (navigator.share && navigator.canShare) {
    const filename = 'ajared-ai-readiness-' + (_shareProfile ? _shareProfile.level.toLowerCase() : 'results') + '.png';
    _canvasToFile(filename).then(file => {
      const shareData = { title: 'My AI Readiness Results', text: shareText, url: assessUrl, files: [file] };
      if (navigator.canShare(shareData)) {
        return navigator.share(shareData);
      }
      // Files not supported — share text + url only
      return navigator.share({ title: 'My AI Readiness Results', text: shareText, url: assessUrl });
    }).catch(() => {
      // Fallback to LinkedIn URL
      window.open('https://www.linkedin.com/sharing/share-offsite/?url=' + encodeURIComponent(assessUrl), '_blank', 'width=600,height=500,noopener');
    });
  } else {
    // Desktop: LinkedIn share URL
    window.open('https://www.linkedin.com/sharing/share-offsite/?url=' + encodeURIComponent(assessUrl), '_blank', 'width=600,height=500,noopener');
  }
}

function shareX() {
  if (!_shareProfile) return;
  const shareText = 'I just took the Ajared AI Readiness Navigator — I\'m a ' +
    _shareProfile.level + ' at ' + Math.round(_shareProfile.overall) +
    '% readiness. Find out where your organization stands:';
  const assessUrl = 'https://ajared.ca/ai-readiness/';

  // Mobile: Web Share API with image file
  if (navigator.share && navigator.canShare) {
    const filename = 'ajared-ai-readiness-' + _shareProfile.level.toLowerCase() + '.png';
    _canvasToFile(filename).then(file => {
      const shareData = { title: 'My AI Readiness Results', text: shareText, url: assessUrl, files: [file] };
      if (navigator.canShare(shareData)) {
        return navigator.share(shareData);
      }
      return navigator.share({ title: 'My AI Readiness Results', text: shareText, url: assessUrl });
    }).catch(() => {
      const text = encodeURIComponent(shareText);
      window.open('https://x.com/intent/tweet?text=' + text + '&url=' + encodeURIComponent(assessUrl), '_blank', 'width=600,height=400,noopener');
    });
  } else {
    // Desktop: X intent URL
    const text = encodeURIComponent(shareText);
    window.open('https://x.com/intent/tweet?text=' + text + '&url=' + encodeURIComponent(assessUrl), '_blank', 'width=600,height=400,noopener');
  }
}

function downloadCard() {
  const canvas = document.getElementById('share-canvas');
  if (!canvas) return;
  const a = document.createElement('a');
  a.download = 'ajared-ai-readiness-' + (_shareProfile ? _shareProfile.level.toLowerCase() : 'results') + '.png';
  a.href = canvas.toDataURL('image/png');
  a.click();
}

function copyAssessmentLink() {
  navigator.clipboard.writeText('https://ajared.ca/ai-readiness/').then(() => {
    const t = document.getElementById('copy-toast');
    t.classList.add('visible');
    setTimeout(() => t.classList.remove('visible'), 2200);
  }).catch(() => {
    // fallback: select a temp input
    const inp = document.createElement('input');
    inp.value = 'https://ajared.ca/ai-readiness/';
    document.body.appendChild(inp);
    inp.select();
    document.execCommand('copy');
    document.body.removeChild(inp);
    const t = document.getElementById('copy-toast');
    t.classList.add('visible');
    setTimeout(() => t.classList.remove('visible'), 2200);
  });
}

// ═══════════════════════════════════════
//  FORM HANDLING
// ═══════════════════════════════════════

document.addEventListener('DOMContentLoaded', () => {
  renderQuiz();

  const form = document.getElementById('lead-form');
  form.addEventListener('submit', function(e) {
    e.preventDefault();

    const name = document.getElementById('lead-name').value.trim();
    const email = document.getElementById('lead-email').value.trim();
    const errEl = document.getElementById('form-error');

    if (!name || !email) {
      errEl.textContent = 'Please fill in both fields.';
      errEl.style.display = 'block';
      return;
    }

    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      errEl.textContent = 'Please enter a valid email address.';
      errEl.style.display = 'block';
      return;
    }

    errEl.style.display = 'none';

    // Submit to Formspree in background
    const formData = new FormData(form);
    fetch(form.action, {
      method: 'POST',
      body: formData,
      headers: { 'Accept': 'application/json' }
    }).catch(() => {
      // Silently fail — results still show
    });

    // Show results immediately
    showResults(name);
  });
});
