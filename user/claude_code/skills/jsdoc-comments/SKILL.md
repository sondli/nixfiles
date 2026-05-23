---
name: jsdoc-comments
description: >
  Add or improve JSDoc comments on JavaScript/TypeScript functions and methods.
  Use this skill whenever the user asks to "add JSDoc", "document this function",
  "add comments to my code", "add documentation", or mentions JSDoc in any way.
  Also trigger when the user pastes a JS/TS function and asks for documentation,
  comments, or annotations — even if they don't say "JSDoc" explicitly.
---

# JSDoc Comments

Add standard JSDoc comments to JavaScript and TypeScript functions and methods.

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

## Rules

1. **Summary line** — always present, always first. One sentence, imperative mood, no period.
2. **`@param`** — one per parameter, in declaration order. Include the type in curly braces unless the code is TypeScript with explicit type annotations (in that case, omit the type from JSDoc to avoid duplication).
3. **`@returns`** — always present unless the function returns `void`/`undefined` with no meaningful intent. Omit the type in TypeScript when the return type is already annotated.
4. **`@throws`** — include for every error the function explicitly throws. Skip if there are none.
5. **`@example`** — include only when usage isn't obvious from the signature and summary. Keep examples short (1–5 lines).
6. **Descriptions** — be concise. Don't restate the parameter name. "`@param {string} name - The name`" is useless; "`@param {string} name - Display name shown in the header`" is helpful.
7. **Blank lines** — one blank comment line between the summary and the long description, and between the long description and the tags. No blank lines between consecutive tags of the same kind.

## TypeScript-Specific Guidance

- **Don't duplicate types.** If the function signature already has TypeScript types, omit `{type}` from `@param` and `@returns`. The JSDoc provides the *description*, TypeScript provides the *type*.
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
- Don't add JSDoc to trivial one-line arrow functions like event handlers or simple callbacks unless the user explicitly asks.

## Workflow

When the user gives you code to document:

1. Read the function(s) and understand what each one does.
2. Add a JSDoc block immediately above each function/method.
3. Preserve all existing code exactly — only add comments, don't modify logic.
4. If existing JSDoc is present but incomplete or incorrect, fix it in place.
5. Return the complete code with the new JSDoc comments added.
