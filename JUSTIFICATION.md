# Activity: Refactor the Spaghetti Screen — Justification

**CC105 — Applications Development and Emerging Technologies**

I split the single `main.dart` into Atomic Design layers. The app should look and behave the same as the starter (search, add product, delete, add to cart, validation, snackbars).

```
lib/
  main.dart
  models/product.dart
  constants/categories.dart
  utils/validators.dart
  ui/
    atoms/       (11 files)
    molecules/   (7 files)
    organisms/   (3 files)
    templates/   (1 file)
    pages/       (1 file)
```

## Atoms (`lib/ui/atoms/`)

**SectionTitle** – Atom. It is one `Text` with a fixed style and nothing else inside it. The starter repeated the same 20px bold text three times ("Search Products", "Catalog", "Add New Product"), so it is reusable. It is a StatelessWidget and only takes a string, so it follows the atom rule of no logic and no state.

**AppTopBar** – Atom. It is a single styled `AppBar` with a title string and no other widgets of mine inside. It has no state and no logic, so it follows the atom rules. I was a little unsure about this one (see the notes at the end).

**ProductNameText** – Atom. It is only the product name `Text` with its style (16, w600). It is the smallest piece of the product card and can't be split further. It is stateless and only renders the string it receives.

**ProductCategoryText** – Atom. It is only the category `Text` (13px, grey). It is a single element with no children and no logic, so it is an atom.

**ProductPriceText** – Atom. It renders one `Text` showing "PHP" plus the price with 2 decimals. The `toStringAsFixed(2)` is only formatting for display and not business logic, so it is allowed in an atom. It is stateless.

**ProductIconBox** – Atom. It is the 56x56 rounded box with the product icon. It looks like it has two parts (Container + Icon), but it is one styled visual element that only draws the `IconData` it is given, with no logic. Because it is a single visual element, it stays an atom.

**PrimaryButton** – Atom. It is a styled `ElevatedButton` (indigo background, white text). It is used for both "Add to Cart" and "Submit Product", which only differ in padding and text style, so those are optional parameters. It does not decide what happens on press; the `onPressed` callback comes from outside, so it holds no logic.

**DeleteButton** – Atom. It is one red `IconButton` with the delete icon. It has no state and just calls the `onPressed` it is given. The actual deleting happens in the page.

**SearchInput** – Atom. It is one `TextField` with the hint text and an `onChanged` callback. I kept it as a plain `TextField` and uncontrolled, like the original. It stores nothing itself, so it is an atom.

**AppTextField** – Atom. It is the base `TextFormField` used by name, price and description. The label, controller, validator, keyboard type and max lines are all parameters, so the atom has no rules of its own. It is a single input element, so it is an atom, and it is stateless because the controller is owned by whoever uses it.

**CategoryDropdown** – Atom. It is one `DropdownButtonFormField`. The list of categories, the current value and `onChanged` are all passed in, so the atom does not know which categories exist and does not keep the selected value. It is a single input control, so it is an atom.

## Molecules (`lib/ui/molecules/`)

**SearchBox** – Molecule. It groups two atoms, `SectionTitle` and `SearchInput`, into one labeled search unit. This follows the molecule rule of a small group of atoms working together as one unit. It has no state and no logic. It only passes `onChanged` up to the page, which owns the search query.

**ProductInfo** – Molecule. It stacks three atoms (`ProductNameText`, `ProductCategoryText`, `ProductPriceText`) in a column with spacing. These three always appear together as "the details of a product", so together they are a molecule. It receives plain values (name, category, price) and does nothing else.

**ProductActions** – Molecule. It combines `PrimaryButton` ("Add to Cart") and `DeleteButton` in a column. They are the two actions a user can take on a product, so grouping two atoms into one functional unit makes it a molecule. It has no state and only forwards the two callbacks.

**ProductNameField** – Molecule. It is `AppTextField` plus the name validation rule (`validateName`). One atom with a rule attached makes a field with a purpose, which is why I put it at molecule level and not atom level. The rule itself is not written inside the widget, it lives in `utils/validators.dart`. The widget has no state, because the controller comes from the form.

**ProductPriceField** – Molecule. It is `AppTextField` with the number keyboard and `validatePrice`. It is the same idea as the name field: an atom configured for one specific purpose and connected to its validation rule. The checks (required, must be a number, greater than zero) are in `validators.dart`, not in the widget.

**ProductCategoryField** – Molecule. It connects `CategoryDropdown` with the shared category list from `constants/categories.dart`. The atom doesn't know the categories, and this molecule supplies them. It keeps no state; the selected value is held by the form and passed in.

**ProductDescriptionField** – Molecule. It is `AppTextField` set up as a 3-line description box with the label aligned to the hint. It has no validator because the starter's description was optional. I kept it as its own molecule so all four fields follow the same pattern and each one can be reused or changed separately.

## Organisms (`lib/ui/organisms/`)

**ProductCard** – Organism. It is a complete, distinct section of the interface: the icon box atom, the `ProductInfo` molecule and the `ProductActions` molecule inside one styled card. It combines atoms and molecules into a standalone piece, which is the organism rule. It takes a `Product` to display but does not own the product list, and it receives `onDelete` from outside. The "Added … to cart" snackbar is inside it as local logic, which organisms are allowed to have, and since the cart is only a message it is not core data.

**CatalogList** – Organism. It is the whole catalog section: the "Catalog" title plus the list of `ProductCard`s. It repeats an organism for each product, so it is a bigger section than a molecule. It only receives the already-filtered list and an `onDelete` callback, so it does not own the data. The page decides which products to pass.

**AddProductForm** – Organism. This holds everything that belongs to the form, which is why it is an organism. The form key, the three text controllers and the selected category are local UI state. It validates through the field molecules, then on submit it reads the values, calls `onSubmit(name, price, category, description)`, clears the fields, resets the category and shows the green "added to catalog!" snackbar. It never touches the product list and does not import the `Product` model. It just hands the values up, so the form does not own the core data.

## Template (`lib/ui/templates/`)

**CatalogTemplate** – Template. It only defines the layout of the screen: scaffold, scroll view, padding, and the order and spacing of four slots (`appBar`, `search`, `catalog`, `form`) with the divider between catalog and form. It receives all of them as widget parameters, so it follows the template rule of accepting layout slots. It does not import `Product` or any other model, and it has no data and no state.

## Page (`lib/ui/pages/`)

**CatalogPage** – Page. This is the only place that holds the real data: the `_products` list, the `_searchQuery` and the `_nextId`. It does the filtering, adds a new product when the form submits (creating the `Product` with its id and the `inventory_2` icon), and removes products on delete. It then wires the data down into the template, `SearchBox`, `CatalogList` and `AddProductForm`. Because it uses a molecule and organisms between itself and the atoms, no level is skipped. This follows the rule that pages are the only place allowed to hold the product list.

## Supporting files (not widgets)

- `models/product.dart` – a small `Product` class that replaces the `Map<String, dynamic>` from the starter, so widgets don't need string keys and casts.
- `utils/validators.dart` – `validateName` and `validatePrice` with the same rules and messages as the starter. This is where the validation was taken out of the widget tree.
- `constants/categories.dart` – the category list and the default category ("Electronics").

## Where each part of the submit logic went

| Part of the old `_submitNewProduct` | Where it is now | Why |
|---|---|---|
| Validation rules | `utils/validators.dart`, used by the field molecules | The rules are not UI, so they are out of the widget tree |
| `_formKey.validate()` and reading the controllers | `AddProductForm` (organism) | It is form-local logic, which organisms may hold |
| Resetting the fields and category | `AddProductForm` | It is the form's own state |
| Confirmation snackbar | `AddProductForm` | It is feedback about the form being submitted |
| Adding to the list, new id, clearing the search query | `CatalogPage` | Only the page may own the product list |

## Notes: parts I was unsure about

1. **AppTopBar (atom or not)** – It could be argued that an app bar belongs at a higher level because it is a bar and often has actions. In this app it is only a title on a styled `AppBar` with nothing else in it, so I kept it as an atom. If it had a menu or buttons, I would make it a molecule or organism. The page passes it straight into the template's `appBar` slot.

2. **ProductCard (molecule or organism)** – It could be a molecule because it is "just one card". I chose organism because it contains a molecule-level structure (`ProductInfo` and `ProductActions`) plus an atom, takes a model object, and has its own local behavior (the cart snackbar). That is more than a small group of atoms.

3. **Field molecules (very thin)** – `ProductNameField` and the others are small wrappers. I kept them as molecules so that each field is separately reusable and validation is attached in one place, but a different answer would be to make them atoms and pass the validator from the form. I went with molecules because a field with a built-in rule and label is more than one bare element.

4. **Search text is not cleared after adding a product** – In the starter, submitting a product sets `_searchQuery = ''` but the search `TextField` was never connected to a controller, so the typed text stays visible while the list shows everything again. Since the activity says the behavior must match exactly, I kept it the same instead of fixing it. A fix would be to give `SearchInput` a controller owned by the page.

5. **Where the "added to cart" snackbar lives** – I put it in `ProductCard` as local organism logic because it is only a message. If the cart became real data, it would need to move up to the page.
