# Pam Migration Analysis (Gap Report + Execution Guidance)

## 1) Agent and Scope
- **Agent:** Pam (Organization dimension)
- **Migration objective:** Align Pam to capability standards with full contract coverage for Reading DB + Todo DB, while preserving current intent and concise interaction style.
- **In-scope:** capability definition, task contract planning, prompt/architecture split, lifecycle/state model decisions, smoke-testable acceptance.
- **Out-of-scope:** full product redesign, rigid ontology design, unrelated cross-agent architecture changes.

---

## 2) Runtime Discovery (Current State)
- **Live prompt path:** Not yet standardized in current context; current behavioral guidance appears in `/home/ubuntu/.openclaw/workspace/pam/instructions.md`.
- **Live architecture path:** Not explicitly defined in available Pam docs (gap).
- **Registry entries:** Not provided in source bundle for this planning pass (to confirm during implementation).
- **Active command/capability surface (inferred from stories + scope):**
  - Reading capture
  - Categorization
  - Unread list
  - Mark read
  - Search/filter
  - Add/update todos
  - Complete/defer/reopen
  - Prioritize/focus reminders

### Discovery notes
1. Current Pam artifacts are minimal and markdown-oriented (`instructions.md`, `todos.md`, `notes.md`), indicating a lightweight legacy surface rather than standards-governed contract implementation.
2. No canonical task folders/contracts exist yet in the provided Pam paths.
3. `pam_scope.md` provides strong behavioral constraints and should be treated as functional baseline.

---

## 3) Data Discovery (Current + Target)
- **Current observable state:** markdown files in `/home/ubuntu/.openclaw/workspace/pam/`.
- **Target state:** standards-aligned owned data surfaces:
  1. Reading DB
  2. Todo DB
- **Real schema verified:** Not available in current source context; schema must be finalized in implementation phase using standards conventions.
- **Derived fields required:**
  - unread backlog visibility
  - focus queue / top priorities
  - deferred/reopened hotspots
  - concise recommendation-ready summary outputs

### Planning assumptions (explicit)
- Use stable IDs for both reading and todo records.
- Preserve update lineage (append-only preferred) to avoid history loss.
- Treat effective current state as query-time resolved where corrections/reopens/defer cycles exist.

---

## 4) Standards Target Comparison

### 4.1 Structure gaps
1. **Gap:** Pam currently lacks standards-aligned agent folder, agent spec, and task contract directories.
2. **Gap:** No canonical contract artifacts (`input/output schemas`, `output.format`, `examples`, `query template`) per capability.
3. **Gap:** No explicit runtime prompt/architecture split artifacts.

### 4.2 Contract gaps
1. **Reading categorization enforcement** not encoded in machine-checkable task contracts yet.
2. **Todo lifecycle transitions** (complete/defer/reopen with deterministic state semantics) not contract-specified.
3. **Reminder behavior contracts** (proactive but concise, trigger thresholds, anti-spam guardrails) not formally defined.

### 4.3 Prompt/architecture separation gaps
1. Existing instruction file mixes style-level behavior and some operational notes, but lacks clear architectural routing/specification.
2. No formal architecture artifact defining capabilities, routes, state transitions, and boundaries.

### 4.4 Deprecated/legacy cleanup gaps
1. Legacy markdown list surfaces are useful references but not sufficient as standards runtime.
2. Need clear migration policy for whether legacy md artifacts remain read-only references, active fallbacks, or retired paths.

---

## 5) Risk Assessment

### 5.1 Runtime mismatch risks
- Implementing new standards files without wiring runtime pointers can produce “docs migrated, behavior unchanged” failure.

### 5.2 Data compatibility risks
- Ambiguous treatment of legacy markdown records can cause duplicate state or orphaned history.
- Missing correction-lineage policy can break deterministic status for reopened/deferred tasks.

### 5.3 Backward compatibility risks
- Hard enforcement of category specificity without transition plan may break prior loosely categorized items.
- Overly aggressive reminder cadence could degrade user trust.

### 5.4 Governance risks
- Ambiguous decisions (priority model, cadence, strict category rules) may drift if not explicitly gated.

---

## 6) Ambiguous Items (Require Explicit Decision)
- **AMBIGUOUS-001:** Reminder cadence trigger policy (event-driven only vs time-and-state hybrid).
- **AMBIGUOUS-002:** Strictness level for category quality checks (warn vs block generic categories).
- **AMBIGUOUS-003:** Todo priority scale granularity (3-level vs expanded/custom).
- **AMBIGUOUS-004:** Whether all updates are append-only by rule, or if controlled in-place updates are allowed with separate history logs.
- **AMBIGUOUS-005:** Legacy markdown ingestion policy (one-time import, dual-write, or no import).

All ambiguous items must follow **proposal -> user OK -> implementation**.

---

## 7) Proposed Migration Actions
1. Establish Pam standards skeleton (`agents/pam`, spec, prompts, task folders).
2. Define contract set for Reading DB and Todo DB capabilities using canonical artifacts.
3. Encode mandatory reading categorization rule in input validation + workflow gating.
4. Define explicit Todo lifecycle state machine including defer/reopen semantics.
5. Implement concise reminder task contract with clear trigger inputs and anti-noise constraints.
6. Add story-to-task traceability table and smoke tests for each user-critical path.
7. Confirm runtime pointer wiring before merge to avoid shadow migration.

---

## 8) Story-to-Requirement Traceability (Pam)

| Story reference (`Organization (Pam)`) | Requirement in migration plan | Task-level implication |
|---|---|---|
| Manage dedicated Reading DB + Todo DB | Dual-surface ownership locked | Separate but interoperable task families |
| Save reading link + brief description | Reading capture contract | `add_reading_item` requires URL + summary |
| Track unread/read status | Reading state model | `list_unread_reading`, `mark_reading_as_read` |
| List unread queue | Retrieval/filter contract | unread-focused query task |
| Mark as read | Status transition contract | read transition + queue removal |
| Category assignment mandatory | Validation rule | `categorize_reading_item` required path |
| Categories open/editable over time | Open taxonomy policy | no hardcoded category enum |
| Categories somewhat specific/tech-oriented | Quality policy | warning/review rule (strictness pending approval) |
| Add/update todos | Todo capture/update contracts | `add_todo`, `update_todo_status` |
| Complete/reopen/defer todos | Lifecycle policy | deterministic transitions + lineage |
| Track priority + status | Focus model | `prioritize_todos`, focus listing |
| Proactive concise reminders | Reminder behavior contract | `remind_focus` concise, trigger-aware |

---

## 9) Readiness Conclusion
Pam is a strong candidate for immediate migration planning execution. The functional intent is clear, but current artifacts are under-specified for standards compliance. The migration should proceed with:
1) strict prompt/architecture split,
2) canonical contract artifact completion,
3) explicit lifecycle/categorization enforcement,
4) governance-gated resolution of ambiguous behavior.

With these controls, Codex can implement Pam in a reviewable, low-regression path.
