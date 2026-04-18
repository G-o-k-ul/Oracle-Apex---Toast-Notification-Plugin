# 🔔 Toast Notification – Oracle APEX Dynamic Action Plugin

> **Plugin Type:** Dynamic Action  
> **Internal Name:** `COM.ORACLE.ACE.TOAST.NOTIFICATION`  
> **APEX Version:** 22.1+  
> **Author:** GOKUL – Oracle ACE Apprentice  
> **Version:** 1.0.0  

---

## 📌 Overview

**Toast Notification** is a lightweight, zero-dependency Oracle APEX Dynamic Action plugin that displays elegant, auto-dismissing toast (snackbar) notifications on your APEX pages.

Native APEX notifications are often tied to page submit/refresh cycles. This plugin enables **real-time, inline feedback** — perfect for confirming button actions, AJAX operations, form validations, and process completions — without any page reload.

---

## ✨ Features

| Feature | Details |
|---|---|
| **4 Toast Types** | Success ✔, Error ✖, Warning ⚠, Info ℹ |
| **4 Positions** | Top Right, Top Left, Bottom Right, Bottom Left |
| **Auto-Dismiss** | Configurable duration in milliseconds |
| **Manual Close** | Click toast or ✕ button to dismiss early |
| **APEX Substitution** | Supports `&ITEM_NAME.` in message text |
| **Stacking** | Multiple toasts stack cleanly |
| **Animated** | Smooth slide-in / fade-out transitions |
| **No dependencies** | Pure JS + CSS, injected on demand |

---

## 📁 File Structure

```
plugin-1-toast-notification/
├── src/
│   ├── dynamic_action_plugin_com_oracle_ace_toast_notification.sql  ← Plugin definition
│   ├── ace_toast_notification_pkg.sql                               ← PL/SQL Package
│   └── ace_toast_notification.css                                   ← Stylesheet reference
├── dist/
│   └── install.sql                                                  ← Combined install script
├── demo/
│   └── demo_app_export.sql                                          ← Sample APEX app
└── README.md
```

---

## 🚀 Installation

### Step 1 – Install PL/SQL Package
Run the following in your Oracle schema (SQL*Plus / SQL Developer / SQLcl):
```sql
@src/ace_toast_notification_pkg.sql
```

### Step 2 – Import Plugin into APEX
1. Open your APEX application
2. Go to **Shared Components → Plug-ins**
3. Click **Import**
4. Upload `src/dynamic_action_plugin_com_oracle_ace_toast_notification.sql`
5. Click **Next → Install Plugin**

---

## ⚙️ Configuration

After importing, use the plugin in any **Dynamic Action**:

1. Create or edit a Dynamic Action (e.g., on Button Click)
2. Add a **True Action**
3. Select Action: **Toast Notification [ACE]**
4. Configure attributes:

| Attribute | Description | Example |
|---|---|---|
| **Toast Type** | Visual style | `success` |
| **Message** | Text to display | `Record saved successfully!` |
| **Position** | Screen location | `top-right` |
| **Duration (ms)** | Auto-close delay (`0` = persistent) | `3000` |

### Using APEX Item Substitution in Message
You can reference APEX page items in your message:
```
Employee &P1_ENAME. was updated successfully.
```

---

## 📸 Screenshots

| Success Toast | Error Toast |
|---|---|
| *(screenshot)* | *(screenshot)* |

| Warning Toast | Info Toast |
|---|---|
| *(screenshot)* | *(screenshot)* |

---

## 💡 Use Cases

- ✅ After a **Save** button submits data via AJAX
- ❌ When a **validation fails** before submit
- ⚠️ Warning user about **unsaved changes** on navigation
- ℹ️ Displaying **informational tips** on page load

---

## 🧪 Testing

1. Import the demo app from `demo/demo_app_export.sql`
2. Run the app and click each test button to see all toast types and positions

---

## 📄 License

MIT License – free to use, modify, and distribute. Attribution appreciated.

---

## 👤 Author

**GOKUL**  
Oracle ACE Apprentice  
GitHub: https://github.com/G-o-k-ul
Blog: https://codewithgokul.blogspot.com/
LinkedIn: https://www.linkedin.com/in/gokul-b-ab86a6229/