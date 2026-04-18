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

prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>100001
,p_default_application_id=>100
,p_default_id_offset=>0
,p_default_owner=>'MRDEV'
);
end;
/
 
prompt APPLICATION 100 - AparX
--
-- Application Export:
--   Application:     100
--   Name:            AparX
--   Date and Time:   13:32 Saturday April 18, 2026
--   Exported By:     GOKUL
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 15716169443382798
--   Manifest End
--   Version:         24.2.0
--   Instance ID:     2114711391975929
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/toast_notification_ace
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(15716169443382798)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'TOAST_NOTIFICATION_ACE'
,p_display_name=>'Toast Notification [ACE]'
,p_category=>'NOTIFICATION'
,p_api_version=>1
,p_render_function=>'ace_toast_notification.render'
,p_standard_attributes=>'ONLOAD:STOP_EXECUTION_ON_ERROR'
,p_substitute_attributes=>true
,p_version_scn=>30729396
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(15717349279402909)
,p_plugin_id=>wwv_flow_imp.id(15716169443382798)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Toast Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'success'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15718675119420346)
,p_plugin_attribute_id=>wwv_flow_imp.id(15717349279402909)
,p_display_sequence=>10
,p_display_value=>'SUCCESS'
,p_return_value=>'success'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15719018229423234)
,p_plugin_attribute_id=>wwv_flow_imp.id(15717349279402909)
,p_display_sequence=>20
,p_display_value=>'ERROR'
,p_return_value=>'error'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15719493723424678)
,p_plugin_attribute_id=>wwv_flow_imp.id(15717349279402909)
,p_display_sequence=>30
,p_display_value=>'WARNING'
,p_return_value=>'warning'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15719869429425628)
,p_plugin_attribute_id=>wwv_flow_imp.id(15717349279402909)
,p_display_sequence=>40
,p_display_value=>'INFO'
,p_return_value=>'info'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(15717601601405970)
,p_plugin_id=>wwv_flow_imp.id(15716169443382798)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Message'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(15717934645409500)
,p_plugin_id=>wwv_flow_imp.id(15716169443382798)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Position'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'top-right'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15720318652430653)
,p_plugin_attribute_id=>wwv_flow_imp.id(15717934645409500)
,p_display_sequence=>10
,p_display_value=>'top-right'
,p_return_value=>'top-right'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15720708127431437)
,p_plugin_attribute_id=>wwv_flow_imp.id(15717934645409500)
,p_display_sequence=>20
,p_display_value=>'top-left'
,p_return_value=>'top-left'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15721122122432143)
,p_plugin_attribute_id=>wwv_flow_imp.id(15717934645409500)
,p_display_sequence=>30
,p_display_value=>'bottom-right'
,p_return_value=>'bottom-right'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(15721593973432792)
,p_plugin_attribute_id=>wwv_flow_imp.id(15717934645409500)
,p_display_sequence=>40
,p_display_value=>'bottom-left'
,p_return_value=>'bottom-left'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(15718208572412004)
,p_plugin_id=>wwv_flow_imp.id(15716169443382798)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Duration (ms)'
,p_attribute_type=>'NUMBER'
,p_is_required=>false
,p_default_value=>'3000'
,p_is_translatable=>false
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
