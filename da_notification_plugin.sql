-- =============================================================================
-- Oracle APEX Plugin: Toast Notification
-- Type: Dynamic Action Plugin
-- Internal Name: COM.ORACLE.ACE.TOAST.NOTIFICATION
-- Author: GOKUL - Oracle ACE Apprentice
-- Version: 1.0.0
-- Description: Displays elegant, auto-dismissing toast notifications
--              with customizable position, type, duration and message.
-- Compatible: Oracle APEX 22.1+
-- =============================================================================

-- Plugin Definition
begin
  wwv_flow_imp.component_begin (
   p_version_yyyy_mm_dd=>'2023.10.31',
   p_release=>'23.2.0',
   p_default_workspace_id=>0,
   p_default_application_id=>0,
   p_default_id_offset=>0,
   p_default_owner=>'nobody'
  );
end;
/

-- Dynamic Action Plugin: Toast Notification
begin
  wwv_flow_api.create_plugin (
    p_id                    => wwv_flow_api.id(1000000000001),
    p_plugin_type           => 'DYNAMIC ACTION',
    p_name                  => 'COM.ORACLE.ACE.TOAST.NOTIFICATION',
    p_display_name          => 'Toast Notification [ACE]',
    p_supported_component_types => 'APEX_APPLICATION_PAGE_DA_ACTI',
    p_render_function       => null,
    p_execution_function    => 'ace_toast_notification.render',
    p_substitute_attributes => true,
    p_version_identifier    => '1.0.0',
    p_about_url             => 'https://github.com/[your-github]/apex-plugins',
    p_plugin_comment        => 'Toast Notification Dynamic Action Plugin by Oracle ACE Apprentice'
  );
end;
/

-- Custom Attributes
begin
  -- Attribute 1: Toast Type
  wwv_flow_api.create_plugin_attribute (
    p_id                    => wwv_flow_api.id(1000000000002),
    p_plugin_id             => wwv_flow_api.id(1000000000001),
    p_attribute_scope       => 'COMPONENT',
    p_attribute_sequence    => 1,
    p_display_sequence      => 10,
    p_prompt                => 'Toast Type',
    p_attribute_type        => 'SELECT LIST',
    p_is_required           => true,
    p_default_value         => 'success',
    p_lov_type              => 'STATIC',
    p_help_text             => 'Select the type/style of the toast notification.'
  );
  wwv_flow_api.create_plugin_attr_value (
    p_id           => wwv_flow_api.id(1000000000003),
    p_plugin_attribute_id => wwv_flow_api.id(1000000000002),
    p_display_sequence => 10,
    p_display_value    => 'Success (Green)',
    p_return_value     => 'success'
  );
  wwv_flow_api.create_plugin_attr_value (
    p_id           => wwv_flow_api.id(1000000000004),
    p_plugin_attribute_id => wwv_flow_api.id(1000000000002),
    p_display_sequence => 20,
    p_display_value    => 'Error (Red)',
    p_return_value     => 'error'
  );
  wwv_flow_api.create_plugin_attr_value (
    p_id           => wwv_flow_api.id(1000000000005),
    p_plugin_attribute_id => wwv_flow_api.id(1000000000002),
    p_display_sequence => 30,
    p_display_value    => 'Warning (Orange)',
    p_return_value     => 'warning'
  );
  wwv_flow_api.create_plugin_attr_value (
    p_id           => wwv_flow_api.id(1000000000006),
    p_plugin_attribute_id => wwv_flow_api.id(1000000000002),
    p_display_sequence => 40,
    p_display_value    => 'Info (Blue)',
    p_return_value     => 'info'
  );

  -- Attribute 2: Message
  wwv_flow_api.create_plugin_attribute (
    p_id                    => wwv_flow_api.id(1000000000007),
    p_plugin_id             => wwv_flow_api.id(1000000000001),
    p_attribute_scope       => 'COMPONENT',
    p_attribute_sequence    => 2,
    p_display_sequence      => 20,
    p_prompt                => 'Message',
    p_attribute_type        => 'TEXT',
    p_is_required           => true,
    p_is_translatable       => true,
    p_help_text             => 'The message text to display in the toast notification. Supports &ITEM. substitutions.'
  );

  -- Attribute 3: Position
  wwv_flow_api.create_plugin_attribute (
    p_id                    => wwv_flow_api.id(1000000000008),
    p_plugin_id             => wwv_flow_api.id(1000000000001),
    p_attribute_scope       => 'COMPONENT',
    p_attribute_sequence    => 3,
    p_display_sequence      => 30,
    p_prompt                => 'Position',
    p_attribute_type        => 'SELECT LIST',
    p_is_required           => true,
    p_default_value         => 'top-right',
    p_lov_type              => 'STATIC',
    p_help_text             => 'Position of the toast on the screen.'
  );
  wwv_flow_api.create_plugin_attr_value (
    p_id           => wwv_flow_api.id(1000000000009),
    p_plugin_attribute_id => wwv_flow_api.id(1000000000008),
    p_display_sequence => 10,
    p_display_value    => 'Top Right',
    p_return_value     => 'top-right'
  );
  wwv_flow_api.create_plugin_attr_value (
    p_id           => wwv_flow_api.id(1000000000010),
    p_plugin_attribute_id => wwv_flow_api.id(1000000000008),
    p_display_sequence => 20,
    p_display_value    => 'Top Left',
    p_return_value     => 'top-left'
  );
  wwv_flow_api.create_plugin_attr_value (
    p_id           => wwv_flow_api.id(1000000000011),
    p_plugin_attribute_id => wwv_flow_api.id(1000000000008),
    p_display_sequence => 30,
    p_display_value    => 'Bottom Right',
    p_return_value     => 'bottom-right'
  );
  wwv_flow_api.create_plugin_attr_value (
    p_id           => wwv_flow_api.id(1000000000012),
    p_plugin_attribute_id => wwv_flow_api.id(1000000000008),
    p_display_sequence => 40,
    p_display_value    => 'Bottom Left',
    p_return_value     => 'bottom-left'
  );

  -- Attribute 4: Duration (ms)
  wwv_flow_api.create_plugin_attribute (
    p_id                    => wwv_flow_api.id(1000000000013),
    p_plugin_id             => wwv_flow_api.id(1000000000001),
    p_attribute_scope       => 'COMPONENT',
    p_attribute_sequence    => 4,
    p_display_sequence      => 40,
    p_prompt                => 'Duration (milliseconds)',
    p_attribute_type        => 'NUMBER',
    p_is_required           => false,
    p_default_value         => '3000',
    p_help_text             => 'Duration in milliseconds before the toast auto-dismisses. Use 0 for persistent (manual close).'
  );
end;
/

begin
  wwv_flow_imp.component_end;
end;
/