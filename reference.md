# Clean code reference

Every rule from [SKILL.md](SKILL.md) with a ❌/✅ example. The examples are in
TypeScript because they are short; the principle holds in any language — translate
it to the one the repository uses.

**Remember:** the repository's written convention (`CLAUDE.md`, `CONVENTIONS.md`,
`CONTRIBUTING.md`, the linter config) takes precedence over this page.

---

## 1. Names and intent

- A **clear, descriptive name**: it says what the thing does or returns.
- No needless abbreviations (`qty`, `tmp`, `val`, `data2`).
- Casing consistent with the language: `camelCase` for variables and functions,
  `PascalCase` for types and classes, `UPPER_SNAKE_CASE` for module constants (in
  Python/Go/Rust, whatever that community uses).
- **Language**: code (identifiers, functions, types) in **English** by default,
  unless the project explicitly specifies another language; comments,
  documentation, and user-facing logs follow the pattern and tone already
  established in the project.

---

## 2. Functions

- Does **one thing only** (SRP).
- **Small**: if it doesn't fit on a screen, it is probably doing too much.
- **Few parameters**: with 4+ related ones, group them into an object.
- **Early return** instead of nesting `if`/`else`.

**❌ Avoid** — needless nesting:

```ts
function parse(value: unknown): number | null {
  if (typeof value === 'string') {
    if (value.trim() !== '') {
      return Number(value);
    }
  }
  return null;
}
```

**✅ Prefer** — early return:

```ts
function parse(value: unknown): number | null {
  if (typeof value !== 'string') return null;

  const trimmed = value.trim();

  if (trimmed === '') return null;

  return Number(trimmed);
}
```

**Python equivalent:**

```python
# ❌ Avoid - nesting
def parse(value: object) -> int | None:
    if isinstance(value, str):
        if value.strip():
            return int(value)
    return None

# ✅ Prefer - guard clauses / early return
def parse(value: object) -> int | None:
    if not isinstance(value, str):
        return None

    trimmed = value.strip()
    if not trimmed:
        return None

    return int(trimmed)
```

**Go equivalent:**

```go
// ❌ Avoid - deep nesting
func Process(user *User) error {
    if user != nil {
        if user.Active {
            return sendEmail(user)
        }
    }
    return ErrInactive
}

// ✅ Prefer - guard clauses
func Process(user *User) error {
    if user == nil || !user.Active {
        return ErrInactive
    }

    return sendEmail(user)
}
```

### Boolean flag arguments

Boolean flags as parameters indicate that a function does more than one thing and obscures call-site readability.

**❌ Avoid:**

```ts
function createUser(name: string, isAdmin: boolean) {
  if (isAdmin) {
    // provisioning with elevated privileges
    return createAdmin(name);
  }

  // standard user provisioning
  return createStandard(name);
}

createUser("Alice", true); // what does true mean?
```

**✅ Prefer:**

```ts
// Split into two dedicated functions:
function createAdminUser(name: string) {
  /* ... */
}

function createStandardUser(name: string) {
  /* ... */
}

// Or pass an explicit options object:
function createUser(name: string, options?: { notifyOnboarding?: boolean }) {
  /* ... */
}
```

---

## 3. Constants vs. magic numbers

No loose magic number (or string). Give the value a name.

**❌ Avoid:**

```ts
if (digits.length === 11) formatCpf(digits);
```

**✅ Prefer:**

```ts
const CPF_LENGTH = 11;

if (digits.length === CPF_LENGTH) formatCpf(digits);
```

---

## 4. Immutability — avoid a mutable variable decided in an if/else

A mutable variable scatters the "how" and hides the intent. Instead of mutating
inside `if`/`else`, extract a constant pointing at a named function whose name says
**what** is being decided.

**❌ Avoid:**

```ts
let provider;
if (isWithdraw) provider = pickWithdrawProvider(account);
else provider = pickDepositProvider(account);
```

**✅ Prefer:**

```ts
const resolveProvider = () =>
  isWithdraw ? pickWithdrawProvider(account) : pickDepositProvider(account);

const provider = resolveProvider();
```

**Python equivalent:**

```python
# ❌ Avoid - mutable variable decided across branches
provider = None
if is_withdraw:
    provider = pick_withdraw_provider(account)
else:
    provider = pick_deposit_provider(account)

# ✅ Prefer - pure function or inline expression
def resolve_provider(is_withdraw: bool, account: Account) -> Provider:
    if is_withdraw:
        return pick_withdraw_provider(account)
    return pick_deposit_provider(account)

provider = resolve_provider(is_withdraw, account)
```

Mutation is still fine when it is the essence of the algorithm (accumulating in a
loop) — but that is the exception, not the default.

---

## 5. Room to breathe and explicit scopes

Code with no vertical spacing reads as one wall. Separate the logical steps with a
blank line and give every branch that does real work its own braces — the eye finds
where a thought starts and ends without parsing the whole block.

- Blank line **before every `if`**, **after a block of declarations**, **before a
  `return`**, and **around a loop**.
- Braces on any `if`/`for`/`while` body that does real work — and keep separating
  inside them: a log line and the `throw` that follows it are two thoughts.
- The exception is the **guard clause**: an `if` whose whole body is a `return` or
  a `throw` stays unbraced, even when it has to wrap to the next line. Braces there
  only add noise.
- Group consecutive declarations that feed the same step. Don't put a blank line
  between every single line — that is as unreadable as none.

**❌ Avoid** — one wall of code; branches with no scope, so a second statement
forces the condition to be repeated:

```ts
async function settleWithdrawal(input: WithdrawalInput): Promise<Receipt> {
  const account = await loadAccount(input.accountId);
  if (!account) throw new NotFoundError(`Account ${input.accountId} not found`);
  const provider = resolveProvider(account, input);
  const feeInCents = provider.feeFor(input.amountInCents);
  const totalInCents = input.amountInCents + feeInCents;
  if (totalInCents > account.balanceInCents) throw new InsufficientFundsError(account.id);
  const payout = await provider.send(input);
  if (!payout.ok) logger.error('payout recusado', { provider: provider.id, reason: payout.reason });
  if (!payout.ok) throw new PayoutFailedError(payout.reason);
  await debit(account, totalInCents);
  return buildReceipt(input, payout, feeInCents);
}
```

**✅ Prefer** — one step per block, every `if` with room around it, the branch that
does work scoped:

```ts
async function settleWithdrawal(input: WithdrawalInput): Promise<Receipt> {
  const account = await loadAccount(input.accountId);

  if (!account) throw new NotFoundError(`Account ${input.accountId} not found`);

  const provider = resolveProvider(account, input);
  const feeInCents = provider.feeFor(input.amountInCents);
  const totalInCents = input.amountInCents + feeInCents;

  if (totalInCents > account.balanceInCents)
    throw new InsufficientFundsError(account.id);

  const payout = await provider.send(input);

  if (!payout.ok) {
    logger.error('payout recusado', {
      provider: provider.id,
      reason: payout.reason,
    });

    throw new PayoutFailedError(payout.reason);
  }

  await debit(account, totalInCents);

  return buildReceipt(input, payout, feeInCents);
}
```

Read the ✅ version's left edge alone and the flow is already there: load, price,
send, react, settle. That is what the blank lines buy.

### Narrow variable scoping

Declare variables and constants as close to their first usage as possible. Avoid hoarding declarations at the top of the function.

**❌ Avoid:**

```ts
function processOrder(order: Order) {
  const taxRate = getTaxRate();
  const discount = calculateDiscount(order);

  if (!order.items.length) return null;
  if (!order.isVerified) return null;

  // 30 lines later...
  return (order.subtotal - discount) * (1 + taxRate);
}
```

**✅ Prefer:**

```ts
function processOrder(order: Order) {
  if (!order.items.length) return null;
  if (!order.isVerified) return null;

  const discount = calculateDiscount(order);
  const taxRate = getTaxRate();

  return (order.subtotal - discount) * (1 + taxRate);
}
```

---

## 6. Comments: only when non-obvious

- Comment **only where the logic got complex** or the intent isn't obvious from the
  name.
- Use the language's doc format (JSDoc `/** ... */`, docstring, `///`).
- Don't comment the obvious, don't leave stale comments.

**❌ Avoid** — a comment that repeats the name:

```ts
/** Adds two numbers. */
function sum(a: number, b: number) {
  return a + b;
}
```

**✅ Prefer** — a comment that explains the non-obvious:

```ts
/**
 * Exponential backoff with full jitter to avoid the thundering herd
 * problem when downstream dependencies recover from an outage.
 */
function calculateBackoffDelay(attempt: number): number {
  /* ... */
}
```

---

## 7. Readability and simplicity

- **Readability over cleverness.** Obvious code beats short cryptic code.
- Write code that **explains itself**; a good name makes the comment unnecessary.
- Remove **needless complexity** and **dead code**.
- **DRY**: extract what repeats — but apparent duplication ≠ real duplication. Only
  merge what changes for the same reason.

### No type escape hatches (`any`, `@ts-ignore`)

Using `any` or `@ts-ignore` disables the compiler and pushes runtime crashes to production. Use `unknown` with type narrowing or schema parsing.

**❌ Avoid:**

```ts
const payload: any = JSON.parse(rawResponse);

// @ts-ignore
payload.executeTransaction();
```

**✅ Prefer:**

```ts
const raw: unknown = JSON.parse(rawResponse);
const payload = TransactionPayloadSchema.parse(raw);

payload.executeTransaction();
```

### Concurrent I/O and chunked batches

Avoid sequential `await` inside loops for independent I/O. Use `Promise.all()` for small bounded collections; for large volumes, process in batches to prevent socket exhaustion and memory spikes.

**❌ Avoid — sequential await inside loop:**

```ts
for (const userId of userIds) {
  await notifyUser(userId); // slow: executes one by one
}
```

**❌ Avoid — unbounded Promise.all on large collections:**

```ts
// Risk: opens thousands of concurrent sockets, crashes DB/network
await Promise.all(thousandUserIds.map(notifyUser));
```

**✅ Prefer — Promise.all for small bounded sets:**

```ts
const [user, preferences, permissions] = await Promise.all([
  fetchUser(id),
  fetchPreferences(id),
  fetchPermissions(id),
]);
```

**✅ Prefer — chunked batches for large collections:**

```ts
const CHUNK_SIZE = 50;

for (let i = 0; i < userIds.length; i += CHUNK_SIZE) {
  const chunk = userIds.slice(i, i + CHUNK_SIZE);
  await Promise.all(chunk.map(notifyUser));
}
```

---

## 8. Coupling and cohesion

- **Reduce coupling**: depend on small, stable interfaces, not on the other
  module's internals.
- **Increase cohesion**: what changes together stays together; what is unrelated
  stays apart.
- **Separate business logic from infrastructure** (DB, HTTP, queues, formatting).
- Prefer **composition over inheritance**.
- A file growing too large is a sign it is doing too much.

### Command Query Separation (CQS)

A function should either perform an action (command) or return data (query), never both secretly. Functions with query names (`getUser`, `isValid`) must not trigger hidden mutations.

**❌ Avoid — query with hidden mutation:**

```ts
function getUser(id: string): User {
  const user = db.users.find(id);

  user.lastAccessedAt = new Date(); // hidden side effect!
  db.users.save(user);

  return user;
}
```

**✅ Prefer — separate query and command:**

```ts
function getUser(id: string): User {
  return db.users.find(id);
}

function touchUserAccess(id: string): void {
  db.users.update(id, { lastAccessedAt: new Date() });
}
```

### Parse at the boundary, don't validate everywhere

Validate and shape untyped inputs at system boundaries (HTTP request, queue message, webhook) using typed schemas (e.g. Zod). Core business logic receives strongly-typed data without defensive boilerplate.

**❌ Avoid — defensive checks scattered across services:**

```ts
function processTransfer(input: any) {
  if (!input || typeof input.amount !== 'number' || input.amount <= 0) {
    throw new Error('Invalid amount');
  }
  // Repeated in controller, service, repository...
}
```

**✅ Prefer — parse once at the entry boundary:**

```ts
import { z } from 'zod';

const TransferSchema = z.object({
  amount: z.number().int().positive(),
  recipientId: z.string().uuid(),
});

type TransferDTO = z.infer<typeof TransferSchema>;

// Boundary (Route / Controller):
const transferData = TransferSchema.parse(req.body);

// Domain Service (Operates on guaranteed types):
function processTransfer(data: TransferDTO) {
  return ledger.execute(data);
}
```

---

## 9. Error handling

- Don't swallow an exception silently.
- Fail explicitly and with useful context (status, message, cause).

**❌ Avoid:**

```ts
try {
  await charge(order);
} catch {
  return null;
}
```

**✅ Prefer:**

```ts
try {
  await charge(order);
} catch (error) {
  throw new Error(`Failed to charge order ${order.id}`, { cause: error });
}
```

**Python equivalent:**

```python
# ❌ Avoid - swallowing exception or losing cause
try:
    charge(order)
except Exception:
    return None

# ✅ Prefer - explicit contextual error chaining
try:
    charge(order)
except PaymentGatewayError as err:
    raise OrderProcessingError(
        f"Failed to charge order {order.id}"
    ) from err
```

**Go equivalent:**

```go
// ❌ Avoid - discarding error or losing original context
if err := charge(order); err != nil {
    return errors.New("charge failed")
}

// ✅ Prefer - wrap with context using %w
if err := charge(order); err != nil {
    return fmt.Errorf("failed to charge order %s: %w", order.ID, err)
}
```

---

## 10. React — an effect is not for syncing state

Only when the project uses React. An effect is for talking to the outside world
(network, timers, DOM, polling). Copying a prop into state inside an effect renders
twice and flashes the stale value. Two ways out, in this order:

1. **Remounting.** State that must "reset" when something changes should die with
   the component: a `key`, or the unmount the dialog library already does on close.
2. **Adjusting during render**, when remounting won't do (the field has to keep
   focus, for instance).

**❌ Avoid** — an effect that only copies a prop into state:

```tsx
const [draft, setDraft] = useState(value);

useEffect(() => {
  setDraft(value);
}, [value]);
```

**✅ Prefer** — adjust during render, with the reason written down:

```tsx
const [draft, setDraft] = useState(value);
const [lastValue, setLastValue] = useState(value);

// The filter changed from the outside (browser back/forward): the field follows.
if (lastValue !== value) {
  setLastValue(value);
  setDraft(value);
}
```

**✅ Better still**, when possible — let the unmount reset it:

```tsx
// Dialog unmounts its content on close: every opening starts clean.
function PlanFormDialog({ open, ...props }) {
  return (
    <Dialog open={open}>
      <PlanFormBody {...props} />
    </Dialog>
  );
}
```

An effect is **still right** when the trigger really is external (a webhook arriving
through polling). In that case, an `eslint-disable-next-line` with the reason
alongside it — not a silent exception.

---

## 11. Boy Scout Rule

Leave the code **cleaner than you found it**. When touching a file for another
reason, fix what is nearby and easy (an avoidable mutable variable, a magic number,
a stale comment). **Don't** open a huge style-only diff separate from the real
change.

---

## 12. Human judgment (not mechanizable)

What no linter catches and matters most in review:

- **Magic numbers** → extract a named constant.
- **SRP / cohesion** → does the function/file do only one thing?
- **Real DRY** → does the duplication change for the same reason?
- **Name intent** → does the name explain without reading the body?
- **Coupling** → can the internals change without breaking consumers?
- **Error handling** → no exception swallowed in silence.
