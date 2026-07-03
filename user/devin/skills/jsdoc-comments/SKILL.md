---
name: jsdoc-comments
description: >
  Add or improve JSDoc comments on JavaScript/TypeScript functions and methods,
  conforming to the project's eslint-plugin-jsdoc rules.
  Use this skill whenever the user asks to "add JSDoc", "document this function",
  "add comments to my code", "add documentation", or mentions JSDoc in any way.
  Also trigger when the user pastes a JS/TS function and asks for documentation,
  comments, or annotations — even if they don't say "JSDoc" explicitly. Use it
  even when the project lints JSDoc via ESLint: this skill defers to those rules.
---

# JSDoc Comments

Add standard JSDoc comments to JavaScript and TypeScript functions and methods.

## Conform to the project's ESLint config (do this FIRST)

If the project uses `eslint-plugin-jsdoc`, **the ESLint config is the source of truth**, not the defaults in this file. The rules below are sensible defaults that ESLint config can and should override. Never produce JSDoc that fails the project's linter.

Before writing comments:

1. **Find the config.** Look for `eslint.config.js` / `eslint.config.mjs` (flat config) or `.eslintrc.*` (legacy), plus any shared config package they `extends`/spread. The relevant rules are the `jsdoc/*` entries and the chosen preset (e.g. `jsdoc.configs['flat/recommended']`, `flat/recommended-typescript`, `flat/recommended-typescript-flavor`).
2. **Derive the active rules** and let them override the defaults below. Watch especially for rules that contradict this file's defaults:
   - `jsdoc/require-description-complete-sentence` → descriptions must be capitalized, complete sentences ending in a period. If ON, **ignore** the "imperative, no period" and "lowercase param description" defaults below.
   - `jsdoc/require-param-type` / `jsdoc/require-returns-type` / `jsdoc/no-types` → these decide whether to include `{type}` on TS code, overriding the "omit types in TS" default.
   - `jsdoc/require-jsdoc` (and its `publicOnly` / `contexts` options) → decides *which* functions need a block, overriding the "skip trivial arrow functions" default.
   - `jsdoc/tag-lines` → controls blank lines between tags, overriding the blank-line rules below.
   - `jsdoc/require-throws`, `jsdoc/check-param-names`, `jsdoc/require-hyphen-before-param-description`, `jsdoc/match-description` → align to these where present.
3. **If you can't read the config** (e.g. a pasted snippet with no repo access), ask the user for their `jsdoc/*` rules or the preset they use, or proceed with the defaults below and note that you assumed them.

### Verify with the linter (when running inside the project)

After adding JSDoc, if ESLint is available in the project:

```bash
npx eslint --fix <changed files>   # auto-fixes alignment, hyphens, tag spacing, etc.
npx eslint <changed files>         # confirm zero jsdoc/* errors remain
```

Resolve any remaining `jsdoc/*` errors by hand, then re-run until clean. ESLint is the ground truth — if its output disagrees with this file, ESLint wins. (CI will run ESLint anyway, so leaving violations just moves the failure downstream.)

## Comment Structure

Every JSDoc block follows this order:

```
/**
 * Short summary — one line, imperative mood ("Fetch user data", not "Fetches user data").
 *
 * Longer description if the function's behavior isn't obvious from the summary.
 * Explain *why* it exists or any non-obvious logic — not just what it does.
 *
 * @param {type} name - Description starting with a lowercase letter.
 * @param {type} [optionalName] - Square brackets for optional params.
 * @param {type} [optionalName=default] - Include default value when meaningful.
 * @returns {type} Description of the return value.
 * @throws {ErrorType} When/why this error is thrown.
 * @example
 * // Only include when the usage isn't obvious
 * const result = myFunction('input');
 */
```

## Rules (defaults — overridden by the project's ESLint config)

1. **Summary line** — always present, always first. One sentence, imperative mood, no period. (If `jsdoc/require-description-complete-sentence` is on, use a complete sentence with a period instead.)
2. **`@param`** — one per parameter, in declaration order. Include the type in curly braces unless the code is TypeScript with explicit type annotations (in that case, omit the type from JSDoc to avoid duplication — unless `jsdoc/require-param-type` requires it).
3. **`@returns`** — always present unless the function returns `void`/`undefined` with no meaningful intent. Omit the type in TypeScript when the return type is already annotated.
4. **`@throws`** — include for every error the function explicitly throws. Skip if there are none.
5. **`@example`** — include only when usage isn't obvious from the signature and summary. Keep examples short (1–5 lines). (If `jsdoc/require-example` is on, include one regardless.)
6. **Descriptions** — be concise. Don't restate the parameter name. "`@param {string} name - The name`" is useless; "`@param {string} name - Display name shown in the header`" is helpful.
7. **Blank lines** — one blank comment line between the summary and the long description, and between the long description and the tags. No blank lines between consecutive tags of the same kind. (Defer to `jsdoc/tag-lines` if configured.)

## TypeScript-Specific Guidance

- **Don't duplicate types.** If the function signature already has TypeScript types, omit `{type}` from `@param` and `@returns` — unless the config's preset/rules require types. The JSDoc provides the *description*, TypeScript provides the *type*.
- **Generics.** Use `@template T` only when the generic's purpose isn't clear from the signature. Describe what the generic represents.
- **Overloads.** Document the implementation signature, not each overload separately.

### Plain JS Example

```js
/**
 * Calculate the total price including tax
 *
 * Rounds the result to two decimal places to avoid floating-point issues.
 *
 * @param {number} subtotal - Pre-tax price in dollars.
 * @param {number} taxRate - Tax rate as a decimal (e.g., 0.08 for 8%).
 * @param {number} [discount=0] - Flat discount applied before tax.
 * @returns {number} Final price rounded to two decimal places.
 * @throws {RangeError} If subtotal or taxRate is negative.
 */
function calculateTotal(subtotal, taxRate, discount = 0) {
  if (subtotal < 0 || taxRate < 0) throw new RangeError('Values must be non-negative');
  return Math.round((subtotal - discount) * (1 + taxRate) * 100) / 100;
}
```

### TypeScript Example

```ts
/**
 * Find an item in an array by a predicate
 *
 * Returns the first matching element or undefined if none match.
 *
 * @param items - Collection to search through.
 * @param predicate - Test function called for each element.
 * @returns The first matching element, or undefined.
 */
function findItem<T>(items: T[], predicate: (item: T) => boolean): T | undefined {
  return items.find(predicate);
}
```

## Common Mistakes to Avoid

- Don't start descriptions with "This function..." — the JSDoc block is already on the function.
- Don't write `@returns {void}` — just omit `@returns` for void functions.
- Don't use `@type` inside a JSDoc function comment — that's for variable annotations.
- Don't add JSDoc to trivial one-line arrow functions like event handlers or simple callbacks unless the user explicitly asks (or `jsdoc/require-jsdoc` is configured to require them).
- Don't fight the linter — if `npx eslint` flags your JSDoc, fix it to satisfy the rule rather than leaving it.

## Workflow

When the user gives you code to document:

1. **Check for ESLint integration first.** Locate the project's ESLint config and derive the active `jsdoc/*` rules (see "Conform to the project's ESLint config" above). These override the defaults in this file. If there's no repo access, ask for the rules or note your assumptions.
2. Read the function(s) and understand what each one does.
3. Add a JSDoc block immediately above each function/method, following the project's rules.
4. Preserve all existing code exactly — only add comments, don't modify logic.
5. If existing JSDoc is present but incomplete or incorrect, fix it in place.
6. **Verify.** If ESLint is available in the project, run `npx eslint --fix` on the changed files, then `npx eslint` to confirm no `jsdoc/*` errors remain. Fix anything left by hand and re-run until clean.
7. Return the complete code with the new JSDoc comments added.
