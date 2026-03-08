// ═══════════════════════════════════════════════════════════════
//  1 Month AI Development Sprint — Intake Assessment
//  sprint.js  |  loaded only on @id='ai-sprint' pages
// ═══════════════════════════════════════════════════════════════

document.addEventListener('DOMContentLoaded', () => {

  // ── Question data ──────────────────────────────────────────
  const questions = [
    {
      id: 'idea_stage',
      label: 'What best describes your AI product idea?',
      max: 1,
      options: [
        { id: 'idea_clear',    text: 'I have a clear problem statement and defined target user' },
        { id: 'idea_general',  text: 'I have a concept but it needs more definition' },
        { id: 'idea_tech',     text: 'I know the AI capability I want to use, not the exact product' },
        { id: 'idea_multiple', text: "I'm deciding between a few different ideas" },
        { id: 'idea_none',     text: "I don't have a specific idea yet" }
      ]
    },
    {
      id: 'project_stage',
      label: 'What stage is your project currently at?',
      max: 1,
      options: [
        { id: 'stage_existing',  text: 'Existing product — I want to add AI features' },
        { id: 'stage_demo',      text: 'Working demo or MVP — tested with real users' },
        { id: 'stage_prototype', text: 'Basic prototype or proof of concept built' },
        { id: 'stage_research',  text: 'Market research or customer interviews done' },
        { id: 'stage_starting',  text: 'Just starting — nothing built yet' }
      ]
    },
    {
      id: 'tech_skills',
      label: 'What technical capabilities does your team have?',
      max: 3,
      options: [
        { id: 'can_code',  text: 'I or my co-founder can write code (Python, JS, etc.)' },
        { id: 'built_ai',  text: "We've built AI or ML applications before" },
        { id: 'has_dev',   text: 'We have a dedicated developer on the team' },
        { id: 'no_code',   text: "We're comfortable with no-code / low-code tools" },
        { id: 'no_tech',   text: "We don't have technical resources yet" }
      ]
    },
    {
      id: 'ai_tools',
      label: 'Which AI technologies are you familiar with?',
      max: 3,
      options: [
        { id: 'llm_apis',      text: 'LLM APIs — OpenAI, Anthropic, or Google' },
        { id: 'open_source',   text: 'Open source models — Llama, Mistral, etc.' },
        { id: 'ai_agents',     text: 'AI agents or workflow automation tools' },
        { id: 'vector_dbs',    text: 'Vector databases or embeddings' },
        { id: 'new_to_ai_dev', text: 'New to AI development — still exploring' }
      ]
    },
    {
      id: 'market_knowledge',
      label: 'How well do you understand your target market?',
      max: 2,
      options: [
        { id: 'user_interviews', text: 'Done user interviews or customer discovery calls' },
        { id: 'am_user',         text: 'I am the target user — I feel the problem daily' },
        { id: 'in_industry',     text: "I work in the industry I'm building for" },
        { id: 'assumptions',     text: "I have assumptions but haven't validated them yet" },
        { id: 'market_unclear',  text: "I haven't fully defined my target market yet" }
      ]
    },
    {
      id: 'business_model',
      label: 'How clear is your business model?',
      max: 1,
      options: [
        { id: 'biz_paying',    text: 'I have paying customers or a letter of intent' },
        { id: 'biz_defined',   text: "I have a defined revenue model — I know how I'll charge" },
        { id: 'biz_exploring', text: "I have a few options in mind but haven't committed" },
        { id: 'biz_open',      text: "I'll figure it out once the product is built" },
        { id: 'biz_none',      text: "Business model isn't my focus for this sprint" }
      ]
    },
    {
      id: 'sprint_goal',
      label: "What's your primary goal for this sprint?",
      max: 1,
      options: [
        { id: 'goal_mvp',        text: 'Ship a working MVP I can demo or put in users\' hands' },
        { id: 'goal_validate',   text: 'Validate my core idea with real user feedback' },
        { id: 'goal_pitch',      text: 'Build something credible to pitch investors or clients' },
        { id: 'goal_foundation', text: 'Lay the technical foundation for a larger product' },
        { id: 'goal_explore',    text: 'Explore whether AI can solve my specific problem' }
      ]
    },
    {
      id: 'time_available',
      label: 'How many hours per week can you commit to the sprint?',
      max: 1,
      options: [
        { id: 'time_35plus', text: '35+ hours — full-time focus on this' },
        { id: 'time_20_35',  text: '20–35 hours — near full-time commitment' },
        { id: 'time_10_20',  text: '10–20 hours — serious part-time' },
        { id: 'time_5_10',   text: '5–10 hours — fitting around other work' }
      ]
    }
  ];

  // ── State ──────────────────────────────────────────────────
  const answers = {};
  questions.forEach(q => { answers[q.id] = []; });

  // ── Render quiz ────────────────────────────────────────────
  function renderQuiz() {
    const container = document.getElementById('sprint-questions');
    if (!container) return;

    container.innerHTML = questions.map((q, qi) => `
      <div class="sprint-q-block">
        <div class="sprint-q-header">
          <span class="sprint-q-num">0${qi + 1}</span>
          <span class="sprint-q-label">${q.label}</span>
          <span class="sprint-q-hint">${q.max === 1 ? 'Pick one' : 'Pick up to ' + q.max}</span>
        </div>
        <div class="sprint-options" id="opts-${q.id}">
          ${q.options.map(opt => `
            <button class="sprint-opt" data-qid="${q.id}" data-oid="${opt.id}"
              onclick="sprintToggle('${q.id}','${opt.id}',${q.max})">
              <span class="sprint-opt-mark${q.max === 1 ? ' radio' : ''}"></span>
              ${opt.text}
            </button>
          `).join('')}
        </div>
      </div>
    `).join('');
  }

  // expose toggleOption globally so onclick="" works
  window.sprintToggle = function(qId, optId, max) {
    const arr = answers[qId];
    const idx = arr.indexOf(optId);

    if (idx > -1) {
      arr.splice(idx, 1);
    } else {
      if (max === 1) {
        answers[qId] = [optId];
      } else {
        if (arr.length >= max) return;
        arr.push(optId);
      }
    }
    updateUI();
  };

  function updateUI() {
    questions.forEach(q => {
      const selected = answers[q.id];
      document.querySelectorAll(`[data-qid="${q.id}"]`).forEach(btn => {
        const oid = btn.dataset.oid;
        const isSel = selected.includes(oid);
        const isDisabled = !isSel && selected.length >= q.max;
        btn.classList.toggle('selected', isSel);
        btn.classList.toggle('disabled', isDisabled);
      });
    });

    const answered = questions.filter(q => answers[q.id].length > 0).length;
    const total = questions.length;
    const pct = (answered / total) * 100;

    const fill = document.getElementById('sprint-progress-fill');
    const label = document.getElementById('sprint-progress-label');
    if (fill) fill.style.width = pct + '%';
    if (label) label.textContent = String(answered).padStart(2, '0') + ' / ' + String(total).padStart(2, '0') + ' answered';

    const allAnswered = questions.every(q => answers[q.id].length > 0);
    const btn = document.getElementById('sprint-submit');
    const hint = document.getElementById('sprint-submit-hint');
    if (btn) btn.disabled = !allAnswered;
    if (hint) hint.style.display = allAnswered ? 'none' : 'inline';
  }

  // ── Scoring ────────────────────────────────────────────────
  function computeProfile() {
    const a = answers;
    let clar = 0, tech = 0, mkt = 0, cap = 0;

    // Clarity
    if (a.idea_stage.includes('idea_clear'))    clar += 4;
    else if (a.idea_stage.includes('idea_general'))  clar += 2;
    else if (a.idea_stage.includes('idea_tech'))     clar += 1;
    else if (a.idea_stage.includes('idea_multiple')) clar += 1;

    if (a.project_stage.includes('stage_demo'))      clar += 4;
    else if (a.project_stage.includes('stage_existing'))  clar += 3;
    else if (a.project_stage.includes('stage_prototype')) clar += 3;
    else if (a.project_stage.includes('stage_research'))  clar += 2;

    if (a.business_model.includes('biz_paying'))   clar += 4;
    else if (a.business_model.includes('biz_defined'))   clar += 3;
    else if (a.business_model.includes('biz_exploring')) clar += 1;

    // Technical
    if (a.tech_skills.includes('can_code'))  tech += 4;
    if (a.tech_skills.includes('built_ai'))  tech += 4;
    if (a.tech_skills.includes('has_dev'))   tech += 3;
    if (a.tech_skills.includes('no_code'))   tech += 2;

    if (a.ai_tools.includes('llm_apis'))     tech += 2;
    if (a.ai_tools.includes('open_source'))  tech += 3;
    if (a.ai_tools.includes('ai_agents'))    tech += 2;
    if (a.ai_tools.includes('vector_dbs'))   tech += 3;

    // Market
    if (a.market_knowledge.includes('user_interviews')) mkt += 4;
    if (a.market_knowledge.includes('am_user'))         mkt += 3;
    if (a.market_knowledge.includes('in_industry'))     mkt += 3;
    if (a.market_knowledge.includes('assumptions'))     mkt += 1;

    // Capacity
    if (a.time_available.includes('time_35plus')) cap += 4;
    else if (a.time_available.includes('time_20_35')) cap += 3;
    else if (a.time_available.includes('time_10_20')) cap += 2;
    else if (a.time_available.includes('time_5_10'))  cap += 1;

    if (a.sprint_goal.includes('goal_mvp') || a.sprint_goal.includes('goal_pitch'))      cap += 2;
    else if (a.sprint_goal.includes('goal_validate') || a.sprint_goal.includes('goal_foundation')) cap += 1;

    const maxClar = 12, maxTech = 18, maxMkt = 7, maxCap = 6;
    const norm = (v, m) => Math.max(0, Math.min(100, (v / m) * 100));

    const dims = {
      Clarity:   norm(clar, maxClar),
      Technical: norm(tech, maxTech),
      Market:    norm(mkt,  maxMkt),
      Capacity:  norm(cap,  maxCap)
    };

    const overall = Object.values(dims).reduce((s, v) => s + v, 0) / 4;

    let level, desc;
    if (overall <= 25) {
      level = 'Exploring';
      desc = "You're working through the fundamentals. A focused prep period will make the sprint far more productive.";
    } else if (overall <= 50) {
      level = 'Developing';
      desc = "You have real foundations. A few targeted steps to sharpen your idea and fill skill gaps and you'll hit sprint day one running.";
    } else if (overall <= 75) {
      level = 'Sprint Ready';
      desc = "You're well positioned to hit the ground running. The sprint will move you from strong foundations to a shippable product.";
    } else {
      level = 'Launch Ready';
      desc = "You're exceptionally prepared. Use the sprint as an accelerant — validate faster, build deeper, close the gap to launch.";
    }

    return { dims, overall, level, desc };
  }

  function getSteps(profile) {
    const a = answers;
    const steps = [];

    if (profile.dims.Clarity < 50) {
      if (a.idea_stage.includes('idea_none') || a.idea_stage.includes('idea_multiple')) {
        steps.push('Spend time this week defining one specific problem to solve — who experiences it, how often, and what a solution would be worth to them.');
      } else if (a.idea_stage.includes('idea_tech')) {
        steps.push("Flip the lens: start with a user problem, not a technology. Ask 5 people in your target market about their biggest workflow frustration.");
      }
      if (a.business_model.includes('biz_open') || a.business_model.includes('biz_none')) {
        steps.push('Sketch a one-page business model canvas before the sprint — even rough, it forces clarity on who pays and how much.');
      }
    }

    if (profile.dims.Technical < 40) {
      if (a.tech_skills.includes('no_tech')) {
        steps.push('Decide before day one: technical co-founder, or no-code AI tools (Bubble, Zapier AI, Voiceflow)? This shapes your entire sprint plan.');
      } else if (a.ai_tools.includes('new_to_ai_dev')) {
        steps.push("Get hands-on with one LLM API before the sprint — build a small demo so you understand the core loop: prompt in, completion out.");
      }
    }

    if (profile.dims.Market < 50) {
      if (a.market_knowledge.includes('market_unclear') || a.market_knowledge.includes('assumptions')) {
        steps.push("Do at least 3 customer discovery calls before the sprint. You don't need to validate everything — just confirm the problem is real.");
      }
    }

    if (profile.dims.Capacity < 40 && a.time_available.includes('time_5_10')) {
      steps.push("With limited hours, scoping is everything. Plan to build one core feature only — protect your sprint hours like unmissable meetings.");
    }

    if (a.sprint_goal.includes('goal_pitch')) {
      steps.push("Define your 'demo moment' now — the one 60-second interaction that makes the value obvious. Build toward that specific moment.");
    }
    if (a.sprint_goal.includes('goal_validate')) {
      steps.push("Identify 10 potential users you can get feedback from during week 3. Line them up before the sprint starts so testing doesn't become a blocker.");
    }

    if (profile.level === 'Launch Ready') {
      steps.push("Set aggressive targets — aim to have something in users' hands by end of week 2, leaving weeks 3–4 for iteration and polish.");
    }

    return steps.slice(0, 3);
  }

  // ── Navigation ─────────────────────────────────────────────
  const submitBtn = document.getElementById('sprint-submit');
  if (submitBtn) {
    submitBtn.addEventListener('click', () => {
      const profile = computeProfile();
      document.getElementById('sprint-quiz').style.display = 'none';
      document.getElementById('sprint-lead').style.display = 'block';

      document.getElementById('sprint-hidden-level').value = profile.level;
      document.getElementById('sprint-hidden-score').value = Math.round(profile.overall);
      document.getElementById('sprint-hidden-answers').value = JSON.stringify(answers);

      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  function showResults() {
    document.getElementById('sprint-lead').style.display = 'none';
    document.getElementById('sprint-results').style.display = 'block';

    const profile = computeProfile();
    const steps = getSteps(profile);

    const levelColors = {
      'Exploring':    '#a1665e',
      'Developing':   '#8ccaca',
      'Sprint Ready': '#046363',
      'Launch Ready': '#058c8c'
    };
    const color = levelColors[profile.level] || '#058c8c';

    const badge = document.getElementById('sprint-level-badge');
    badge.textContent = profile.level;
    badge.style.color = color;
    badge.style.borderColor = color;

    document.getElementById('sprint-level-score').textContent = Math.round(profile.overall) + '%';
    document.getElementById('sprint-level-desc').textContent = profile.desc;

    // Dimension grid
    const grid = document.getElementById('sprint-dim-grid');
    grid.innerHTML = Object.entries(profile.dims).map(([key, val]) => `
      <div class="sprint-profile-cell">
        <span class="label">${key}</span>
        <div class="sprint-dim-val">${Math.round(val)}%</div>
        <div class="sprint-dim-track">
          <div class="sprint-dim-fill" style="width:${val}%"></div>
        </div>
      </div>
    `).join('');

    // Steps
    const stepsList = document.getElementById('sprint-steps-list');
    stepsList.innerHTML = steps.map((s, i) => `
      <div class="sprint-step-item">
        <span class="sprint-step-num">0${i + 1}</span>
        <span class="sprint-step-text">${s}</span>
      </div>
    `).join('');

    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  const retakeBtn = document.getElementById('sprint-retake');
  if (retakeBtn) {
    retakeBtn.addEventListener('click', () => {
      questions.forEach(q => { answers[q.id] = []; });
      document.getElementById('sprint-results').style.display = 'none';
      document.getElementById('sprint-quiz').style.display = 'block';
      updateUI();
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  // ── Form submission ────────────────────────────────────────
  const leadForm = document.getElementById('sprint-lead-form');
  if (leadForm) {
    leadForm.addEventListener('submit', function(e) {
      e.preventDefault();

      const name  = document.getElementById('sprint-lead-name').value.trim();
      const email = document.getElementById('sprint-lead-email').value.trim();
      const errEl = document.getElementById('sprint-lead-error');

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

      // Submit to Formspree silently
      fetch(leadForm.action, {
        method: 'POST',
        body: new FormData(leadForm),
        headers: { Accept: 'application/json' }
      }).catch(() => {});

      showResults();
    });
  }

  // ── Init ───────────────────────────────────────────────────
  renderQuiz();
  updateUI();

});
