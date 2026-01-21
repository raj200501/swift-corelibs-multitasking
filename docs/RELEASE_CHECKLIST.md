# Release Candidate Checklist

- [ ] `swift build` succeeds.
- [ ] `swift test` succeeds.
- [ ] `swift run multitasking-demo` succeeds.
- [ ] `./scripts/verify.sh` passes.
- [ ] Documentation updated (README, ARCHITECTURE, DEMO, SECURITY).
- [ ] No secrets added; no new external network dependencies.
- [ ] CI workflow passes on a clean runner.
