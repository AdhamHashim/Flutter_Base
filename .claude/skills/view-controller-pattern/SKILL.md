---
name: view-controller-pattern
description: ViewController class pattern — TextEditingController, ValueNotifier, ScrollController, FocusNode, AnimationController, and UI logic handlers MUST live in a separate ViewController class, never inside the View/State directly. Use ValueNotifier + ValueListenableBuilder instead of setState.
---

# Skill: ViewController Pattern (MANDATORY)

## When to Use

- أي شاشة فيها TextEditingController, ValueNotifier, ScrollController, FocusNode, AnimationController
- أي UI logic handler (onSend, onSearch, selectTab, onFilter, toggleVisibility…)
- أي state بـ setState — استبدله بـ ValueNotifier + ValueListenableBuilder

## القاعدة الأساسية (NON-NEGOTIABLE)

> **ممنوع نهائياً: أي Controller أو Notifier أو UI handler داخل الـ View/State مباشرة.**
> **كل حاجة UI-stateful بتاعتها لازم تكون في class منفصل اسمه `<Feature>ViewController`. الـ View تستدعي الـ class object (_vc) فقط.**

---

## ما يدخل ViewController

- TextEditingController (أي field input)
- ValueNotifier<T> (أي UI state بسيط: bool, int, enum, entity)
- ScrollController (أي scroll listener أو jump)
- FocusNode (أي focus management)
- AnimationController (أي animation custom)
- UI handler functions (onSend, onSearch, selectTab, onFilter…)
- dispose() لكل اللي فوق

## ما لا يدخل ViewController

- BLoC/Cubit logic (دي في الـ Cubit)
- API calls (دي في الـ Cubit)
- Validation (دي في الـ Params class بـ FormMixin)
- Navigation (دي مباشرة في الـ View عبر Go.to/back/off)

---

## Pattern الكامل

```dart
class ChatViewController {
  final TextEditingController messageController = TextEditingController();
  final ValueNotifier<bool> isSending = ValueNotifier(false);
  final ScrollController scrollController = ScrollController();

  void onSend(BuildContext context) {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    context.read<ChatCubit>().sendMessage(text);
    messageController.clear();
  }

  void dispose() {
    messageController.dispose();
    isSending.dispose();
    scrollController.dispose();
  }
}

class _ChatInputState extends State<_ChatInput> {
  late final ChatViewController _vc = ChatViewController();

  @override
  void dispose() { _vc.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: DefaultTextField(controller: _vc.messageController)),
      8.szW,
      ValueListenableBuilder<bool>(
        valueListenable: _vc.isSending,
        builder: (_, sending, __) => _SendButton(onTap: () => _vc.onSend(context), isLoading: sending),
      ),
    ]);
  }
}
```

---

## Anti-pattern

```dart
class _ChatInputState extends State<_ChatInput> {
  final _controller = TextEditingController();           // ❌
  bool _isSending = false;                                // ❌
  final ValueNotifier<int> _tabIndex = ValueNotifier(0); // ❌
  void _onSend() { setState(() => ...); }                 // ❌
}
```

> **See `form-api-pipeline` skill** for the full Form → Params → Cubit → Submit pipeline.
