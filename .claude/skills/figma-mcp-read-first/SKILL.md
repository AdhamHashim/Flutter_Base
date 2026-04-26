---
name: figma-mcp-read-first
description: Mandatory — read screens from Figma MCP before writing any UI code. If MCP read fails, STOP and report to user; never guess or fall back to placeholder UI.
---

# Figma MCP — Read First, Stop on Failure

## القاعدة الأساسية (NON-NEGOTIABLE)

> **قبل كتابة أي كود لأي شاشة — لازم تقرأ التصميم من Figma MCP أولاً.**
> **لو فشلت القراءة لأي سبب → STOP. بلّغ المستخدم بالفشل. لا تكمل.**

---

## الخطوات الإلزامية

### 1. اقرأ من Figma MCP (قبل أي شيء)

```
1. get_node_info(nodeId)               → الأبعاد، الألوان، الـ layout
2. scan_nodes_by_types(nodeId, types)  → كل الـ children IDs
3. get_nodes_info([...ids])            → batch fetch (10 nodes max per call)
4. scan_text_nodes(nodeId)             → كل النصوص + styles
```

### 2. تحقق من نجاح القراءة

بعد كل call للـ Figma MCP:
- لو رجع **بيانات صحيحة** → كمّل
- لو رجع **خطأ / null / فاضي** → **STOP فوراً**

---

## سلوك الفشل (MANDATORY)

```
❌ STOP — لا تكتب أي كود
❌ لا تخمّن التصميم
❌ لا تستخدم بيانات قديمة أو افتراضية

✅ بلّغ المستخدم:
   "فشلت قراءة التصميم من Figma MCP.
    السبب: [الخطأ]
    المطلوب: تأكد من الـ Figma URL وأن الـ MCP متصل، ثم أعد المحاولة."
```

---

## استثناء واحد

> لو المستخدم **صراحةً** طلب UI_ONLY بدون Figma → مسموح تكمل بدون MCP.
> في أي حالة تانية → Figma MCP قراءة إلزامية.
