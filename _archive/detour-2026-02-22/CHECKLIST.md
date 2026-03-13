# DEPRECATED (Legacy archive)
# CHECKLIST.md — Factory Persona vs Jim

## Factory Persona checklist (webchat)
- [ ] Is this a **new identity/config** request (not runtime)?
- [ ] Template version selected (`template_version`)?
- [ ] Role + permissions defined?
- [ ] Tools + memory settings set?
- [ ] Output schema contract defined/versioned?
- [ ] Manifest generated (`agent_id`, versions, hash, timestamps)?
- [ ] Registry updated?
- [ ] Handoff artifact available for Jim?

## Jim checklist (telegram)
- [ ] Is manifest present and valid for target agent?
- [ ] Task dispatched to correct existing agent?
- [ ] Agent responded within timeout?
- [ ] Output matches schema contract?
- [ ] If failure: retry policy applied?
- [ ] Incident logged with correct type (if needed)?
- [ ] Operational summary compiled?
- [ ] No identity/template/schema mutation done at runtime?
