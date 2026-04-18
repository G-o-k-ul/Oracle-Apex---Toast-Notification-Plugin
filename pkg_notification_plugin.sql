CREATE PACKAGE ace_toast_notification AS
-- =============================================================================
-- Package: ACE_TOAST_NOTIFICATION
-- Description: PL/SQL Package for the Toast Notification APEX Dynamic Action Plugin
-- Author: GOKUL - Oracle ACE Apprentice
-- Version: 1.0.0
-- =============================================================================

  FUNCTION render (
    p_dynamic_action IN apex_plugin.t_dynamic_action,
    p_plugin         IN apex_plugin.t_plugin
  ) RETURN apex_plugin.t_dynamic_action_render_result;

END ace_toast_notification;
/

CREATE OR REPLACE PACKAGE BODY ace_toast_notification AS

  -- ---------------------------------------------------------------------------
  -- FUNCTION: render
  -- Description: Renders the JavaScript required to display the toast.
  -- ---------------------------------------------------------------------------
  FUNCTION render (
    p_dynamic_action IN apex_plugin.t_dynamic_action,
    p_plugin         IN apex_plugin.t_plugin
  ) RETURN apex_plugin.t_dynamic_action_render_result AS

    l_result       apex_plugin.t_dynamic_action_render_result;
    l_toast_type   VARCHAR2(20)   := p_dynamic_action.attribute_01;  -- success/error/warning/info
    l_message      VARCHAR2(4000) := p_dynamic_action.attribute_02;  -- message text
    l_position     VARCHAR2(20)   := p_dynamic_action.attribute_03;  -- position
    l_duration     NUMBER         := NVL(TO_NUMBER(p_dynamic_action.attribute_04), 3000);

    -- Perform APEX item substitution on message
    l_final_message VARCHAR2(4000);

  BEGIN

    -- Substitute APEX item values (e.g., &P1_EMPNO.)
    l_final_message := apex_plugin_util.replace_substitutions(
      p_value   => l_message,
      p_escape  => true
    );

    -- Define colors per toast type
    -- Inject CSS once per page using a guard flag
    apex_javascript.add_onload_code(
      p_code => '
        if (!window.aceToastInitialized) {
          window.aceToastInitialized = true;

          // Inject CSS styles for toast container
          var style = document.createElement("style");
          style.innerHTML = `
            .ace-toast-container {
              position: fixed;
              z-index: 99999;
              display: flex;
              flex-direction: column;
              gap: 10px;
              max-width: 360px;
              width: 100%;
              pointer-events: none;
            }
            .ace-toast-container.top-right    { top: 20px; right: 20px; align-items: flex-end; }
            .ace-toast-container.top-left     { top: 20px; left: 20px;  align-items: flex-start; }
            .ace-toast-container.bottom-right { bottom: 20px; right: 20px; align-items: flex-end; }
            .ace-toast-container.bottom-left  { bottom: 20px; left: 20px;  align-items: flex-start; }

            .ace-toast {
              pointer-events: all;
              display: flex;
              align-items: flex-start;
              gap: 12px;
              padding: 14px 18px;
              border-radius: 8px;
              box-shadow: 0 4px 20px rgba(0,0,0,0.15);
              font-size: 14px;
              font-family: inherit;
              color: #fff;
              min-width: 240px;
              max-width: 360px;
              animation: aceToastIn 0.35s ease forwards;
              position: relative;
              cursor: pointer;
            }
            .ace-toast.success { background: #28a745; border-left: 5px solid #1e7e34; }
            .ace-toast.error   { background: #dc3545; border-left: 5px solid #bd2130; }
            .ace-toast.warning { background: #fd7e14; border-left: 5px solid #e96b02; }
            .ace-toast.info    { background: #007bff; border-left: 5px solid #0056b3; }

            .ace-toast-icon { font-size: 18px; flex-shrink: 0; margin-top: 1px; }
            .ace-toast-body { flex: 1; }
            .ace-toast-title { font-weight: 700; margin-bottom: 2px; text-transform: capitalize; }
            .ace-toast-message { opacity: 0.92; font-size: 13px; }
            .ace-toast-close {
              background: none; border: none; color: #fff;
              font-size: 16px; cursor: pointer; opacity: 0.7;
              padding: 0; line-height: 1; flex-shrink: 0;
            }
            .ace-toast-close:hover { opacity: 1; }
            .ace-toast.fade-out { animation: aceToastOut 0.3s ease forwards; }

            @keyframes aceToastIn  { from { opacity:0; transform:translateX(40px); } to { opacity:1; transform:translateX(0); } }
            @keyframes aceToastOut { from { opacity:1; transform:translateX(0);   } to { opacity:0; transform:translateX(40px); } }
          `;
          document.head.appendChild(style);

          // Global toast function
          window.aceShowToast = function(type, message, position, duration) {
            var icons = { success:"✔", error:"✖", warning:"⚠", info:"ℹ" };
            var containerId = "ace-toast-" + position;
            var container = document.getElementById(containerId);
            if (!container) {
              container = document.createElement("div");
              container.id = containerId;
              container.className = "ace-toast-container " + position;
              document.body.appendChild(container);
            }
            var toast = document.createElement("div");
            toast.className = "ace-toast " + type;
            toast.innerHTML =
              ''<span class="ace-toast-icon">'' + (icons[type]||"ℹ") + ''</span>'' +
              ''<div class="ace-toast-body">'' +
                ''<div class="ace-toast-title">'' + type + ''</div>'' +
                ''<div class="ace-toast-message">'' + message + ''</div>'' +
              ''</div>'' +
              ''<button class="ace-toast-close" title="Close">✕</button>'';

            toast.querySelector(".ace-toast-close").addEventListener("click", function() {
              aceRemoveToast(toast);
            });
            toast.addEventListener("click", function(e) {
              if (!e.target.classList.contains("ace-toast-close")) aceRemoveToast(toast);
            });

            container.appendChild(toast);

            if (duration > 0) {
              setTimeout(function() { aceRemoveToast(toast); }, duration);
            }
          };

          window.aceRemoveToast = function(toast) {
            if (!toast.classList.contains("fade-out")) {
              toast.classList.add("fade-out");
              setTimeout(function() { if (toast.parentNode) toast.parentNode.removeChild(toast); }, 300);
            }
          };
        }
      '
    );

    -- Emit the actual toast trigger call
    l_result.javascript_function :=
      'function() { ' ||
        'window.aceShowToast(' ||
          apex_javascript.add_value(l_toast_type)   ||
          apex_javascript.add_value(l_final_message) ||
          apex_javascript.add_value(l_position)      ||
          l_duration ||
        '); ' ||
      '}';

    RETURN l_result;

  EXCEPTION
    WHEN OTHERS THEN
      apex_debug.error('ACE Toast Notification Plugin Error: %s', SQLERRM);
      RAISE;
  END render;

END ace_toast_notification;
/