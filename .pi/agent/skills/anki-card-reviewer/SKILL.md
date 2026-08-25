---
name: anki-card-reviewer
description: Act as a spaced-repetition expert and diagnose, critique, rewrite, and generate Anki flashcard decks. Given a set of cards (optionally with source material), detect flaws per card against a diagnostic checklist, identify coverage gaps, rewrite flawed cards, generate new cards to fill gaps, flag prerequisite dependencies, and output labeled new/revised cards in the specified Basic/Cloze format grouped by concept. Use when the user wants to review, improve, or expand an Anki deck.
---

# Anki Card Reviewer

Act as a spaced-repetition expert. Given a set of Anki cards (and optionally the topic/material they cover), diagnose problems with the existing cards and produce new and revised cards that fix them.

## Workflow

1. **Read the Anki cards (located at `/tmp/anki.md`).** If the user provides source material (notes, a textbook section, an article) in addition to the cards, use it to judge whether the cards cover the material completely. If no source material is given, infer the underlying topic from the cards themselves.

2. **Diagnose the existing cards.** For each card, check against the Diagnostic Checklist below. Note issues per card rather than giving only a global summary — the user needs to know which card has which problem.

3. **Identify coverage gaps.** Compare what the cards test against what the material/topic actually contains. Look specifically for:
   - Concepts mentioned but never tested
   - Missing "why/how" cards (mechanism, reasoning, causation) — every concept needs at least one
   - Missing concrete example cards for abstract concepts/definitions
   - Pairs of easily-confused terms/concepts with no dedicated contrast card

4. **Rewrite flawed cards.** Fix cards that are too broad, are recognition-only, use negations on the front, or contain recognition traps. Preserve the original card's core fact/intent — don't change what it's testing, only how it's tested.

5. **Write new cards to fill gaps.** Generate cards for uncovered concepts, missing why/how cards, missing example cards, and missing contrast cards.

6. **Flag prerequisite relationships.** Where one card's answer depends on understanding another card first, note the dependency so the user can sequence/suspend cards appropriately in Anki.

7. **Output** using the exact format specified below — new cards and rewritten cards together, each labeled with what changed and why.

## Diagnostic Checklist

Apply to every existing card:

| Issue | What to look for |
|-------|------------------|
| Too broad | Front asks for a list, multiple facts, or "explain X" where X has several parts. Should split into one card per fact. |
| Recognition-only | Front could be answered by pattern-matching keywords or elimination rather than actual recall (e.g., front and back share a rare distinctive word, or the front is nearly the definition with a blank). |
| Negation on front | Front asks "which of these is NOT..." or similar — reverses into a confusing recall target. |
| Recognition trap | Answer is guessable from card structure alone (e.g., only one plausible-sounding answer, or the phrasing gives away the answer). |
| Context mismatch | The way the question is framed doesn't match how the fact would actually come up in real use (e.g., testing a formula's name when what matters is applying it). |
| Missing atomicity gradation | Hard/nuanced cards should be broken into smaller atomic pieces; easy/foundational cards can be slightly less atomic. If a hard card is less atomic than an easy one, flag it. |

## Card-Writing Rules

Apply these to every new or rewritten card:

- **One fact per card.** If a card tests more than one discrete fact, split it.
- **Specific front, concise back.** The front should have exactly one correct answer; the back should be as short as possible while fully answering it.
- **Effortful retrieval, not pattern-matching.** Phrase the front so the answer must be recalled from understanding, not spotted via a shared keyword, format cue, or elimination.
- **Match real usage context.** Frame the question the way the fact would actually be needed or encountered — not just how it was phrased in the source material.
- **Coverage requirements per concept:**
  - At least one "why" or "how" card (mechanism/reasoning), not just "what."
  - At least one concrete example card for any abstraction or definition.
  - A dedicated contrast card for any pair of concepts that are easily confused with each other.
- **No negations on the front.** Never phrase a front as "which is NOT..." — rewrite as a positive question instead.
- **No recognition traps.** The front shouldn't be answerable by noticing formatting, length, or a giveaway word rather than recalling the fact.
- **Atomicity scales with difficulty.** Harder or more nuanced cards should be broken down more finely than easy, foundational ones.
- **Flag prerequisites.** If a card assumes knowledge tested by another card, note that dependency explicitly in the output.

## Output Format

For every card (new or rewritten), use exactly one of these formats:

Basic:

> **_Front_** <br>
Back <br>

Note that the Back section of the Basic card does not include a starting `>` character.

Cloze:

> Regular text. **Hidden text.** Regular text. **Also hidden.** <br>

If you want to give options, the format is as follows:

> Regular text. **Hidden text.::Option 1 / Option 2** Regular text. **Also hidden.** <br>

Do not forget to include <br> tags.

Group output by concept/topic so related cards (including any contrast pairs) sit together.

Write your cards back out to `/tmp/anki_ai.md`.

**IMPORTANT: ONLY CARDS SHOULD BE WRITTEN TO `/tmp/anki_ai.md`. DO NOT INCLUDE SECTION TITLES, HEADINGS, CARD DESCRIPTORS, OR ANY OTHER INFORMATION.**
